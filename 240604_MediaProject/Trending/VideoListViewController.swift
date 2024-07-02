//
//  VideoViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 7/2/24.
//

import UIKit

final class VideoListViewController: UIViewController {

    var movieId:Int = 0{
        didSet{
            NetworkManager.shared.callRequest(api: TrendingAPI.video(id: movieId), model: MovieVideo.self) { data, error in
                if let error = error{
                    print(error)
                }else{
                    guard let data else { return }
                    self.list = data.results
                    self.tableview.reloadData()
                }
            }
        }
    }
    
    private let tableview = UITableView()
    
    private var list:[Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    private func configureHierarchy(){
        view.addSubview(tableview)
    }
    private func configureLayout(){
        tableview.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureUI(){
        view.backgroundColor = .white
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
        tableview.rowHeight = UITableView.automaticDimension
    }
}


extension VideoListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.identifier, for: indexPath) as! VideoCell
        cell.data = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VideoViewController()
        vc.link = list[indexPath.row].key
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
