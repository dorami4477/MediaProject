//
//  VideoCell.swift
//  240604_MediaProject
//
//  Created by 박다현 on 7/2/24.
//

import UIKit

final class VideoCell: UITableViewCell {

    var data:Video?{
        didSet{
            setData()
        }
    }
    
    private let officalLabel = {
        let label = UILabel()
        label.text = "Offical"
        label.backgroundColor = .red
        label.layer.cornerRadius = 3
        label.font = .systemFont(ofSize: 13)
        label.clipsToBounds = true
        return label
    }()
    
    private let subTitleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy(){
        contentView.addSubview(officalLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(titleLabel)
    }
    private func configureLayout(){
        officalLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalTo(officalLabel.snp.trailing).offset(5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(officalLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(15)
        }

    }
    private func configureUI(){
        backgroundColor = .white
    }
    
    private func setData(){
        guard let data else { return }
        if !data.official{
            officalLabel.isHidden = true
        }else{
            officalLabel.isHidden = false
        }
        
        titleLabel.text = data.name
        subTitleLabel.text = data.site
    }
}
