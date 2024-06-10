//
//  TrendCell.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import UIKit
import Kingfisher

class TrendCell: UITableViewCell {

    let dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    let categoryLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    let cardView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    let cardImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.roundCorners(cornerRadius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        imageView.clipsToBounds = true
        return imageView
    }()
    let gradeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.backgroundColor = .white
        return label
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    let captionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    let seeMoreLabel = {
        let label = UILabel()
        label.text = "자세히 보기"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    let seeMoreImgeView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        return imageView
    }()
    let lineView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
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
    func configureHierarchy(){
        [dateLabel, categoryLabel, cardView].forEach { contentView.addSubview($0) }
        [cardImageView, gradeLabel, titleLabel, captionLabel, lineView, seeMoreLabel, seeMoreImgeView].forEach { cardView.addSubview($0) }
    }
    func configureLayout(){
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
        }
        categoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(dateLabel.snp.bottom)
        }
        cardView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(20)
            make.top.equalTo(categoryLabel.snp.bottom).offset(4)
            make.height.equalTo(310)
        }
        cardImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
        gradeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(cardImageView.snp.bottom).inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(cardImageView.snp.bottom).offset(15)
        }
        captionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        lineView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(captionLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        seeMoreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(lineView.snp.bottom).offset(10)
        }
        seeMoreImgeView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.height.equalTo(seeMoreLabel.snp.height)
        }
    }
    func configureUI(){
    }
    
    func configureData(data:MovieList){
        dateLabel.text = data.releaseDateString
        categoryLabel.text = "# \(data.media_type)"
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(data.backdrop_path)")
        cardImageView.kf.setImage(with: url)
        gradeLabel.text = "평점 | \(data.vote_average.formatted())"
        titleLabel.text = data.original_title
        captionLabel.text = data.overview
        
    }
}
