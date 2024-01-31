//
//  TVViewController.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

enum TVType: Int, CaseIterable {
    
    case trending
    case topRated
    case popular
    
    var title: String {
        switch self {
        case .trending:
            return "추천 TV 콘텐츠"
        case .topRated:
            return "TOP 20 TV 콘텐츠"
        case .popular:
            return "인기 TV 콘텐츠"
        }
    }
    
    var url: String {
        switch self {
        case .trending:
            "trending/tv/day"
        case .topRated:
            "tv/top_rated"
        case .popular:
            "tv/popular"
        }
    }
}

class TVViewController: BaseViewController {
    
    let tableView = UITableView()
    
    let tmdbManager = TMDBAPIManager.shared
    
    var list: [[TVResult]] = Array(repeating: [], count: TVType.allCases.count)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TVType.allCases.enumerated().forEach { i, type in
            tmdbManager.fetchTV(url: type.url) { result in
                self.list[i] = result
                self.tableView.reloadData()
            }
        }

    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
}

extension TVViewController: TableViewProtocol {
    
    func configureTableView() {
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
    }

}

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TVType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
        
        cell.collectionView.tag = indexPath.row
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        
        cell.titleLabel.text = TVType.allCases[indexPath.row].title
        
        return cell
    }
    
}

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        
        let item = list[collectionView.tag][indexPath.item]
        
        if let poster = item.poster {
            let url = URL(string: "\(tmdbManager.imageBaseURL)\(poster)")
            cell.posterImageView.kf.setImage(with: url)
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        cell.titleLabel.text = item.name
        
        let count = item.voteCount > 999 ? "999+" : "\(item.voteCount)"
        cell.voteAverageLabel.text = String(format: "%.1f", item.voteAverage) + "( \(count))"
        
        return cell
    }
    
}
