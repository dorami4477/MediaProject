//
//  CreditViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import UIKit
import Alamofire

class CreditViewController: UIViewController{

    var movieId:Int = 0{
        didSet{
            callRequestCredit(id:movieId)
        }
    }
    var castData:[Cast]?
    
    let mainIamgeView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    let posterIamgeView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    let captionLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "출연/제작"
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    func configureHierarchy(){
        [mainIamgeView, titleLabel, posterIamgeView, captionLabel, tableView].forEach { view.addSubview($0)}
    }
    func configureLayout(){
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
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainIamgeView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
            
    }
    func configureTableView(){
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
    
    func callRequestCredit(id:Int){
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/credits"
        
        let header:HTTPHeaders = ["accept": "application/json", "Authorization": APIKey.tmdbAccess]
        
        AF.request(url, method: .get, headers: header)
            .responseDecodable(of: Credit.self) { response in
            switch response.result{
            case .success(let value):
                self.castData = value.cast
                self.tableView.reloadData()
                print(self.castData)
            case .failure(let error):
                print(error)
            }
        }
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
