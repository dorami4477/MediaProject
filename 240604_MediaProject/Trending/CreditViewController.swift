//
//  CreditViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import UIKit
import Alamofire

final class CreditViewController: UIViewController{

    var movieId:Int = 0{
        didSet{
            NetworkManager.shared.callRequest(api: TrendingAPI.credit(id: movieId), model: Credit.self) { value, error in
                if let error{
                    print(error)
                }else{
                    guard let value else { return }
                    self.castData = value.cast
                    self.tableView.reloadData()
                }
            }
        }
    }
    private var castData:[Cast]?
    
    private let mainIamgeView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    private let posterIamgeView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    private let videoButton = {
        let button = UIButton()
        button.setTitle("영상보기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(videoButtonTapped), for: .touchUpInside)
        return button
    }()
    private let captionLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "출연/제작"
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    private func configureHierarchy(){
        [mainIamgeView, titleLabel, posterIamgeView, videoButton, captionLabel, tableView].forEach { view.addSubview($0)}
    }
    private func configureLayout(){
        mainIamgeView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        posterIamgeView.snp.makeConstraints { make in
            make.bottom.equalTo(mainIamgeView.snp.bottom).inset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(120)
        }
        videoButton.snp.makeConstraints { make in
            make.bottom.equalTo(mainIamgeView.snp.bottom).inset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainIamgeView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
            
    }
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CreditCell.self, forCellReuseIdentifier: CreditCell.identifier)
        tableView.rowHeight = 120
    }
    
    func configureMovieInfo(data:MovieList){
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.backdrop_path)")
        mainIamgeView.kf.setImage(with: url)
        titleLabel.text = data.title
        captionLabel.text = data.overview
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(data.poster_path)")
        posterIamgeView.kf.setImage(with: posterUrl)
    }
    
    @objc func videoButtonTapped(){
        let videoVC = VideoListViewController()
        videoVC.movieId = self.movieId
        navigationController?.pushViewController(videoVC, animated: true)
    }
}

extension CreditViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditCell.identifier, for: indexPath) as! CreditCell
        guard let castData else { return UITableViewCell() }
        cell.configureData(data: castData[indexPath.row])
        return cell
    }
    
    
}
