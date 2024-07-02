//
//  TrendViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import UIKit
import Alamofire

final class TrendViewController: UIViewController {
    
    private let tableView = UITableView()
    let network = NetworkManager.shared
    private var movieData:[MovieList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureTableView()
        network.callRequest(api: TrendingAPI.trending, model: Movie.self) { value, error in
            if let error{
                print(error)
            }else{
                guard let value else { return }
                self.movieData = value.results
                self.tableView.reloadData()
            }
        }
    }

    private func configureHierarchy(){
        view.addSubview(tableView)
    }
    private func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrendCell.self, forCellReuseIdentifier: TrendCell.identifier)
    }
        
}

extension TrendViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendCell.identifier, for: indexPath) as! TrendCell
        cell.configureData(data: movieData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CreditViewController()
        vc.movieId = movieData[indexPath.row].id
        vc.configureMovieInfo(data: movieData[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
 

}
