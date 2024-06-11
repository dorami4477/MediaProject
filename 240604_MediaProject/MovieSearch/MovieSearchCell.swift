//
//  MovieSearchCell.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/11/24.
//

import UIKit

class MovieSearchCell: UICollectionViewCell {
    
    let mainImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .black)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowRadius = 2
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        return label
    }()
    let overviewLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    let genreLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let gradeLabel = {
        let label = PaddingLabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.backgroundColor = .red
        label.textColor = .white
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy(){
        contentView.addSubview(mainImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(gradeLabel)
    }
    func configureLayout(){
        mainImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(15)

        }
        gradeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.top.trailing.equalToSuperview().inset(15)
        }
    }
    func configureUI(){
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
    }
    
    
    
    func configureData(data:SearchResult){
        if let post = data.backdrop_path{
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(post)")
            mainImageView.kf.setImage(with: url)
        }else{
            mainImageView.image = UIImage(systemName: "questionmark")
        }
        titleLabel.text = data.title
        overviewLabel.text = data.overview
        gradeLabel.text = String(format: "%.1f", data.vote_average)
    }
}
