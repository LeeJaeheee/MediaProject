//
//  RecommendationCollectionViewCell.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
