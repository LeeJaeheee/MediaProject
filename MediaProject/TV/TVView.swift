//
//  TVView.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit
import SnapKit

enum HomeTag: String, CaseIterable {
    case 영화
    case 시리즈
}

class TVView: BaseView {
    //TODO: tagCollectionView 커스텀으로 빼서 NEW&HOT이랑 공유하기
    let tagCollectionView: UICollectionView = {
        let spacing: CGFloat = 16
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tagCollectionView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tagCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.separatorStyle = .none
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
    }
    
}
