//
//  WeatherCell.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/8/24.
//

import UIKit

class WeatherCell: UITableViewCell {

    let resultLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .white
        label.layer.cornerRadius = 4
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy(){
        contentView.addSubview(resultLabel)
    }
    func configureLayout(){
        resultLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.leading.equalToSuperview().offset(30)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(30)

        }
    }


    

}
