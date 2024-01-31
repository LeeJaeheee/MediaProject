//
//  RecommendationTableViewCell.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func configureView() {
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewFlowLayout{
        let spacing: CGFloat = 16
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        return layout
    }
    
}
