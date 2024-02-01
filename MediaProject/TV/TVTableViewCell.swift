//
//  TVTableViewCell.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import UIKit

class TVTableViewCell: UITableViewCell, ConfigureProtocol {
    
    static var type: TMDBAPI = .trending
    
    let titleLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

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
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.height.equalTo(TVTableViewCell.type == .topRated ? 300 : 200)
        }
    }
    
    func configureView() {
        selectionStyle = .none
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .darkGray
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        print(TVTableViewCell.type)
        print(#function)
        let spacing: CGFloat = 16
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = TVTableViewCell.type == .topRated ? CGSize(width: 150, height: 300) : CGSize(width: 100, height: 200)
        print(layout.itemSize)
        layout.minimumInteritemSpacing = spacing
        return layout
    }
    
}
