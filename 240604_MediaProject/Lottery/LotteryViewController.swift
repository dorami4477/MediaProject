//
//  LotteryViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/5/24.
//

import UIKit
import Alamofire

struct Lottery:Decodable{
    let drwNo:Int
    let drwNoDate:String
    let drwtNo1:Int
    let drwtNo2:Int
    let drwtNo3:Int
    let drwtNo4:Int
    let drwtNo5:Int
    let drwtNo6:Int
    let bnusNo:Int
    var drwNms:[Int]{
        return [drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo]
    }
}

final class LotteryViewController: UIViewController {
    
    private let searchTextField = UITextField()
    private let infoLabel = UILabel()
    private let dateLabel = UILabel()
    private let roundLabel = UILabel()
    private let lineView = UIView()
    private let lottoResultStackView = UIStackView()
    private let drawNum01Label = UILabel()
    private let drawNum02Label = UILabel()
    private let drawNum03Label = UILabel()
    private let drawNum04Label = UILabel()
    private let drawNum05Label = UILabel()
    private let drawNum06Label = UILabel()
    private let drawNum07Label = UILabel()
    private let drawNum08Label = UILabel()
    private lazy var drawNumLabels = [drawNum01Label, drawNum02Label, drawNum03Label, drawNum04Label, drawNum05Label, drawNum06Label, drawNum08Label]
    
    private let pickerView = UIPickerView()
    private var rounds:[Int] = []
    
    private var lottoResult:Lottery?{
        didSet{
            guard let lottoResult else { return }
            roundLabel.text = "\(lottoResult.drwNo)회 당첨결과"
            dateLabel.text = "\(lottoResult.drwNoDate) 추첨"
            for i in 0..<drawNumLabels.count{
                drawNumLabels[i].text = lottoResult.drwNms[i].formatted()
                setNumberColor(label: drawNumLabels[i])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        callRequest()
        makeTotalRounds(lastRound: 1122)
    }
    
    override func viewDidLayoutSubviews() {
        drawNumLabels.forEach {
            $0.textAlignment = .center
            $0.textColor = .white
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configureHierarchy(){
        [searchTextField, infoLabel, dateLabel, lineView, roundLabel, lottoResultStackView, pickerView].forEach { view.addSubview($0)}
        [drawNum01Label, drawNum02Label, drawNum03Label, drawNum04Label, drawNum05Label, drawNum06Label, drawNum07Label, drawNum08Label].forEach{ lottoResultStackView.addArrangedSubview($0)}
    }
    
    private func configureLayout(){
        searchTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(1)
        }
        roundLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        lottoResultStackView.snp.makeConstraints { make in
            make.top.equalTo(roundLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(drawNum01Label.snp.width)
        }
        pickerView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view)
        }
    }
    
    private func configureUI(){
        view.backgroundColor = .white
        searchTextField.delegate = self
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.borderStyle = .roundedRect
        searchTextField.textAlignment = .center
        searchTextField.tintColor = .clear
        searchTextField.text = "1122"
        infoLabel.text = "당첨번호 안내"
        infoLabel.font = .boldSystemFont(ofSize: 14)
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        
        lineView.backgroundColor = .gray
        
        roundLabel.font = .boldSystemFont(ofSize: 20)
        roundLabel.textAlignment = .center
        searchTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        drawNum07Label.text = "+"
        drawNum07Label.textAlignment = .center

        lottoResultStackView.axis = .horizontal
        lottoResultStackView.distribution = .fillEqually
        lottoResultStackView.spacing = 5
        
        pickerView.isHidden = true
    }
    
    private func setNumberColor(label:UILabel){
            switch Int(label.text!)!{
            case 1...10:
                label.backgroundColor = UIColor(red: 0.86, green: 0.67, blue: 0.01, alpha: 1.00)
            case 11...20:
                label.backgroundColor = UIColor(red: 0.00, green: 0.48, blue: 0.76, alpha: 1.00)
            case 21...30:
                label.backgroundColor = UIColor(red: 0.97, green: 0.24, blue: 0.06, alpha: 1.00)
            case 31...40:
                label.backgroundColor = .gray
            case 41...45:
                label.backgroundColor = UIColor(red: 0.07, green: 0.63, blue: 0.60, alpha: 1.00)
            default:
                label.backgroundColor = .gray
            }
    }
    
    // MARK: - Network
    private func callRequest(){
        let url = "\(APIUrl.lottery)\(searchTextField.text!)"
        AF.request(url).responseDecodable(of: Lottery.self){ response in
            switch response.result{
            case .success(let value):
                self.lottoResult = value
            case .failure(let error):
                print(error)
            }
        }
    }
    //회차 리스트
    private func makeTotalRounds(lastRound:Int){
        for i in 1...lastRound{
            rounds.append(i)
        }
    }

}

// MARK: - PickerView
extension LotteryViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rounds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(rounds.reversed()[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        searchTextField.text = "\(rounds.reversed()[row])"
        callRequest()
    }
}

extension LotteryViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.isHidden = false
    }
}
