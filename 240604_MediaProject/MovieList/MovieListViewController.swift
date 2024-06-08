//
//  MovieListViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit


class MovieListViewController: UIViewController {

    let searchTextField = UITextField()
    let searchButton = UIButton()
    let tableView = UITableView()
    
    var movieData:[DailyBoxOfficeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        setDelegate()
        callRequest(date: getYesterday())
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)

    }
    func configureHierarchy(){
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func configureLayout(){
        searchTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(view.frame.width - 110)
            make.height.equalTo(40)
        }
        searchButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(searchTextField.snp.trailing).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    func configureUI(){
        view.backgroundColor = .black
        searchTextField.backgroundColor = .white
        //* 밑줄만 보이게 안됨...
        searchTextField.layer.addBorder([.bottom], color: UIColor.gray, width: 2)
        searchTextField.text = getYesterday()
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        tableView.backgroundColor = .clear
    }
    
    func setDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListCell.self, forCellReuseIdentifier: "MovieListCell")
    }

    func callRequest(date:String){
        let url = "\(APIUrl.movie)key=\(APIKey.movie)&targetDt=\(date)"
   
        AF.request(url).responseDecodable(of: MovieModel.self) { response in
            switch response.result{
            case .success(let value):
                print(value)
                self.movieData = value.boxOfficeResult.dailyBoxOfficeList
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func searchButtonClicked(){
        guard let date = searchTextField.text else { return }
                callRequest(date:date)
    }
    
    func getYesterday() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateResult = formatter.string(from: yesterday!)
        return dateResult
    }

}

extension MovieListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.rankLabel.text = movieData[indexPath.row].rank
        cell.movieTitleLabel.text = movieData[indexPath.row].movieNm
        cell.dateLabel.text = movieData[indexPath.row].openDt
        return cell
    }
    
    
}
