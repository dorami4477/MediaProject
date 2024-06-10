//
//  TrendViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import UIKit
import Alamofire

class TrendViewController: UIViewController {
    
    let tableView = UITableView()
    
    var movieData:[MovieList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        callRequest()
    }
    func configureHierarchy(){
        view.addSubview(tableView)
    }
    func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureUI(){
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendCell.self, forCellReuseIdentifier: TrendCell.identifier)
    }
    
    func callRequest(){
        let url = "https://api.themoviedb.org/3/trending/movie/day"
        
        let header:HTTPHeaders = ["accept": "application/json", "Authorization": APIKey.tmdbAccess]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Movie.self) { response in
            switch response.result{
            case .success(let value):
                self.movieData = value.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension TrendViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendCell.identifier, for: indexPath) as! TrendCell
        cell.configureData(data: movieData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreditViewController()
        vc.movieId = movieData[indexPath.row].id
        vc.configureMovieInfo(data: movieData[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
