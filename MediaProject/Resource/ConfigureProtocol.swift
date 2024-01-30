//
//  ConfigureProtocol.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import UIKit

@objc protocol ConfigureProtocol {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}

@objc protocol VCProtocol: ConfigureProtocol {
    @objc optional func configureNavigationItem()
    @objc optional func setupActions()
}

protocol TableViewProtocol {
    func configureTableView()
}

protocol CollectionViewProtocol {
    func configureCollectionView()
    func configureCollectionViewLayout() -> UICollectionViewFlowLayout
}
