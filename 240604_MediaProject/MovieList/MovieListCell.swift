//
//  MovieListCell.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/5/24.
//

import UIKit

class MovieListCell: UITableViewCell {
    let rankLabel = UILabel()
    let movieTitleLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy(){
        contentView.addSubview(rankLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(dateLabel)
    }
    func configureLayout(){
        rankLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.width.equalTo(27)
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalTo(rankLabel.snp.trailing).offset(8)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
        }
    }
    func configureUI(){
        backgroundColor = .clear
        rankLabel.backgroundColor = .white
        rankLabel.font = .boldSystemFont(ofSize: 16)
        rankLabel.textAlignment = .center
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .systemFont(ofSize: 16)
        movieTitleLabel.numberOfLines = 0
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 13)
        
    }

}
