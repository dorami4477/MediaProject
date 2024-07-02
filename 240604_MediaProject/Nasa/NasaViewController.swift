//
//  NasaViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 7/1/24.
//

import UIKit

final class NasaViewController: UIViewController {
    
    enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
         
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
    
    private let requestButton = {
        let button = UIButton()
        button.setTitle("이미지 불러오기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .brown
        return button
    }()
    private let progressLabel = UILabel()
    private let progressView = UIProgressView()
    private let nasaImageView = UIImageView()
    
    private var session:URLSession!
    private var total:Double = 0
    private var buffer:Data?{
        didSet{
            let progress = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\((progress * 100).rounded()) / 100"
            progressView.progress = Float(progress)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    private func configureHierarchy(){
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(progressView)
        view.addSubview(nasaImageView)
    }
    private func configureLayout(){
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(requestButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        nasaImageView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    private func configureUI(){
        view.backgroundColor = .white
        progressLabel.backgroundColor = .lightGray
        requestButton.addTarget(self, action: #selector(requestbuttonTapped), for: .touchUpInside)
        nasaImageView.contentMode = .scaleAspectFit
        progressView.progress = 0.1
        buffer = Data()
    }
    
    @objc private func requestbuttonTapped(){
        print("buttonTapped")
        callRequest()
    }
    
    private func callRequest(){
        //reset
        buffer = Data()
        nasaImageView.image = UIImage(systemName: "star")
        
        let url = Nasa.photo
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume()
        requestButton.isEnabled = false
    }
    
}

extension NasaViewController:URLSessionDataDelegate{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let response = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode){
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length") else { return .cancel }
            total = Double(contentLength)!
            return .allow
        }else{
            nasaImageView.image = UIImage(systemName: "star")
            return .cancel
        }
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer?.append(data)
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error{
            print(error)
            nasaImageView.image = UIImage(systemName: "star")
        }else{
            guard let buffer else {
                print("buffer nil")
                return
            }
            nasaImageView.image = UIImage(data: buffer)
        }
        requestButton.isEnabled = true
    }
}
