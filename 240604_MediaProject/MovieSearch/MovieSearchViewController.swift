//
//  MovieSearchViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/11/24.
//

import UIKit
import Alamofire

final class MovieSearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private var data:MovieSearch?
    
    private var page = 1
    private var totalPage = 1
    
    private func collectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 30
        layout.itemSize = CGSize(width: width/2, height: width/1.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureCV()
    }

    
    private func configureHierarchy(){
        view.addSubview(collectionView)
        view.addSubview(searchBar)
    }
    private func configureLayout(){
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureUI(){
        view.backgroundColor = .white
    }
    private func configureCV(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieSearchCell.self, forCellWithReuseIdentifier: MovieSearchCell.identifier)
        collectionView.prefetchDataSource = self
        searchBar.delegate = self
    }
    
/*
    func callRequest(query:String){
        let url = "\(APIUrl.movieSearch)"
        
        let header:HTTPHeaders = ["accept": "application/json", "Authorization": APIKey.tmdbAccess]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: MovieSearch.self) { response in
            switch response.result{
            case .success(let value):
                self.totalPage = value.total_pages
                
                if self.page == 1{
                    self.data = value
                    
                }else{
                    self.data?.results.append(contentsOf: value.results)
                }
                self.collectionView.reloadData()
                
                if self.page == 1{
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                }
            case .failure(let error):
                print(error)
            }
        }
    }*/
}

// MARK: - collectionView
extension MovieSearchViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchCell.identifier, for: indexPath) as! MovieSearchCell
        guard let data else { return UICollectionViewCell() }
        cell.configureData(data:data.results[indexPath.item])
        return cell
    }
    
}

// MARK: - searchBar
extension MovieSearchViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //page = 1
        //callRequest(query:searchBar.text!)
        NetworkManager.shared.callRequest(api: TrendingAPI.search(query: searchBar.text!, page: 1), model: MovieSearch.self) { value, error in
            if let error{
                print(error)
            }else{
                guard let value else { return }
                self.totalPage = value.total_pages
                self.data = value
                
                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            }
        }
    }
}

// MARK: - Prefetching
extension MovieSearchViewController:UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths{
            if data!.results.count - 4 == item.item && totalPage > page{
                page += 1
                //callRequest(query: searchBar.text!)
                NetworkManager.shared.callRequest(api: TrendingAPI.search(query: searchBar.text!, page: page), model: MovieSearch.self) { value, error in
                    if let error{
                        print(error)
                    }else{
                        guard let value else { return }
                        self.totalPage = value.total_pages
                        self.data?.results.append(contentsOf: value.results)
                        
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
}
