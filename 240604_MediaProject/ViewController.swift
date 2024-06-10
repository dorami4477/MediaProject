//
//  ViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/4/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let mainIamgeView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "노량")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let playButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setTitle(" 재생", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        return button
    }()
    
    let bookmarkButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.setTitle(" 내가 찜한 리스트", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var buttonStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }()
    
    let subtitleLabel = {
        let label = UILabel()
        label.text = "지금 뜨는 콘텐츠"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let media01ImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "더퍼스트슬램덩크")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let media02ImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "밀수")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let media03ImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "범죄도시3")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var mediaStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureNavigation()
        configureHierarchy()
        configureLayout()
    }

    func configureNavigation(){
        let plus = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        title = "고래밥님"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = plus
    }
    
    func configureHierarchy(){
        [mainIamgeView, buttonStackView, subtitleLabel, mediaStackView].forEach {
            view.addSubview($0)
        }
        [playButton, bookmarkButton].forEach {
            self.buttonStackView.addArrangedSubview($0)
        }
        [media01ImageView, media02ImageView, media03ImageView].forEach {
            self.mediaStackView.addArrangedSubview($0)
        }
    }
    
    func configureLayout(){
        mainIamgeView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(mainIamgeView.snp.width).multipliedBy(1.3)
        }
        buttonStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(mainIamgeView.snp.horizontalEdges).inset(15)
            make.bottom.equalTo(mainIamgeView.snp.bottom).offset(-15)
            make.height.equalTo(44)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainIamgeView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        mediaStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
    }
    
    @objc func plusButtonTapped(){
        let nextVC = TrendViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

}

