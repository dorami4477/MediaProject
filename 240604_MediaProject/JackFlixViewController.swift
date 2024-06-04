//
//  JackFlixViewController.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/4/24.
//

import UIKit

class JackFlixViewController: UIViewController {

    let titleLabel = {
        let label = UILabel()
        label.text = "JACKFLIX"
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    let emailTextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(
            string: "이메일 주소 또는 전화번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textField
    }()
    let passwordTextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 8
        return textField
    }()
    let nicknameTextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "닉네임",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 8
        return textField
    }()
    let locationTextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "위치",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 8
        return textField
    }()
    let codeTextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "추천 코드 입력",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.backgroundColor = .gray
        textField.layer.cornerRadius = 8
        return textField
    }()
    lazy var textFieldStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }()
    let signUpButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        return button
    }()
    let additionalInfoLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    let additionalInfoSwitch = {
        let aiSwitch = UISwitch()
        aiSwitch.onTintColor = .red
        aiSwitch.isOn = true
        return aiSwitch
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureHierarchy()
        configureLayout()
    }

    func configureHierarchy(){
        [titleLabel, textFieldStackView, signUpButton, additionalInfoLabel,additionalInfoSwitch].forEach {
            view.addSubview($0)
        }
        [emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField].forEach {
            self.textFieldStackView.addArrangedSubview($0)
        }

    }
    func configureLayout(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        textFieldStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(240)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        additionalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
        }
        additionalInfoSwitch.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
}
