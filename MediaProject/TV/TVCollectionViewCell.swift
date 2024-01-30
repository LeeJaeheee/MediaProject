//
//  TVCollectionViewCell.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import UIKit
import Cosmos

class TVCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    lazy var voteStackView = UIStackView(arrangedSubviews: [starLabel, voteAverageLabel])
    let starLabel = UILabel()
    let voteAverageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.cornerRadius = 12
    }
    
}

extension TVCollectionViewCell: ConfigureProtocol {
    
    func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(voteStackView)
    }
    
    func configureLayout() {

        posterImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(20)
        }
        
        voteStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(8)
        }
    
    }
    
    func configureView() {
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.borderWidth = 1

        titleLabel.font = .boldSystemFont(ofSize: 13)
        titleLabel.textAlignment = .center
        
        voteStackView.axis = .horizontal
        voteStackView.distribution = .fillProportionally
        voteStackView.spacing = 4
        
        starLabel.text = "⭐️"
        starLabel.font = .systemFont(ofSize: 12)
        
        voteAverageLabel.font = .systemFont(ofSize: 12)
    }
    
}
