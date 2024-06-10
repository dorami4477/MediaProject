//
//  CreditCell.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import UIKit

class CreditCell: UITableViewCell {

    let mainImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    let acterNameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let castNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    func configureHierarchy(){
        contentView.addSubview(mainImageView)
        contentView.addSubview(acterNameLabel)
        contentView.addSubview(castNameLabel)
    }
    func configureLayout(){
        mainImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(80)
        }
        acterNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(mainImageView.snp.trailing).offset(12)
        }
        castNameLabel.snp.makeConstraints { make in
            make.top.equalTo(acterNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(mainImageView.snp.trailing).offset(12)
        }
    }
    func configureData(data:Cast){
        guard let imgURL = data.profile_path else { 
            mainImageView.image = UIImage(systemName: "questionmark")
            return }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(imgURL)")
        mainImageView.kf.setImage(with: url)
        acterNameLabel.text = data.name
        castNameLabel.text = "\(data.character ?? data.department!)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
