//
//  WeatherViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/8/24.
//

import UIKit
import Alamofire
import Kingfisher

class WeatherViewController: UIViewController {

    let dateLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    let locationLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    let shareButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        return button
    }()
    let refreshButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .white
        return button
    }()
    let titleWrapView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let tableView = UITableView()
    
    var data:WeatherModel?{
        didSet{
            guard let data else { return  }
            let attributedString = NSMutableAttributedString(string: "")
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "location.fill")?.withTintColor(.white)
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            attributedString.append(NSAttributedString(string: data.name))
            locationLabel.attributedText = attributedString
            
            tableView.reloadData()
            print(data)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        callRequest()
        configureTableView()
    }
    
    func configureHierarchy(){
        [dateLabel, titleWrapView,tableView].forEach { view.addSubview($0) }
        [locationLabel, shareButton, refreshButton].forEach { titleWrapView.addSubview($0) }
    }
    func configureLayout(){
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        titleWrapView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        shareButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(refreshButton.snp.leading).offset(-16)
        }
        refreshButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleWrapView.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    func configureUI(){
        view.backgroundColor = .orange
        dateLabel.text = getNow()
        
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        tableView.register(WeatherImgCell.self, forCellReuseIdentifier: "WeatherImgCell")
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }

    
    func callRequest(){
        let url = "\(APIUrl.weather)lat=37.498061&lon=127.028759&lang=kr&units=metric&appid=\(APIKey.weather)"
     
        AF.request(url).responseDecodable(of: WeatherModel.self) { response in
            switch response.result{
            case .success(let value):
                self.data = value
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getNow() -> String{
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "MM월 dd일 HH시 mm분"
            let savedDateString = myFormatter.string(from: Date())
            return savedDateString
    }

}


extension WeatherViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 5{
            guard let data else { return UITableViewCell()}
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherImgCell", for: indexPath) as! WeatherImgCell
            let url = URL(string:"https://openweathermap.org/img/wn/\(data.weather[0].icon)@2x.png")
            cell.weatherImage.kf.setImage(with: url)
            
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            guard let data else { return UITableViewCell()}
            switch indexPath.row{
                case 0:
                cell.resultLabel.text = "지금은 \(data.main.temp)도 에요."
                case 1:
                cell.resultLabel.text = "체감 온도는 \(data.main.feelsLike)도 입니다. "
                case 2:
                cell.resultLabel.text = "날씨는 \(data.weather[0].description)!"
                case 3:
                cell.resultLabel.text = "습도는 \(data.main.humidity)% 에요."
                case 4:
                cell.resultLabel.text = "바람은 \(data.wind.speed)m/s으로 불어요"
            default:
                cell.resultLabel.text = "지금 날씨는 어떤가요?"
            }
            return cell
        }
    }
    
    
}