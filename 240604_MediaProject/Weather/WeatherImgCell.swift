//
//  WeatherImgCell.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/8/24.
//

import UIKit

final class WeatherImgCell: UITableViewCell {

    let weatherImage = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 4
        img.clipsToBounds = true
        return img
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy(){
        contentView.addSubview(weatherImage)
    }
    private func configureLayout(){
        weatherImage.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(30)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(30)
            make.height.equalTo(100)
        }
    }

}
