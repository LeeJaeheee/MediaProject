//
//  TVViewController.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

//enum TVType: Int, CaseIterable {
//    case trending
//    case topRated
//    case popular
//}

class TVViewController: BaseViewController {
    
    let mainView = TVView()
    
    let tmdbManager = TMDBAPIManager.shared
    
    let apiList: [TMDBAPI] = [.trending, .topRated, .popular]
    
    lazy var list: [[TVResult]] = Array(repeating: [], count: apiList.count)
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        let group = DispatchGroup()
        
        apiList.enumerated().forEach { i, type in
            group.enter()
            tmdbManager.request(type: TVModel.self, api: apiList[i]) { result in
                self.list[i] = result.results
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }
}

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return apiList[indexPath.row] == .topRated ? 344 : 244
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
        
        cell.titleLabel.text = apiList[indexPath.row].title
        cell.collectionView.tag = indexPath.row
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        
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
            let url = URL(string: "\(TMDBAPI.imageBaseURL)\(poster)")
            cell.posterImageView.kf.setImage(with: url)
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        cell.titleLabel.text = item.name
        
        cell.voteAverageLabel.text = item.voteCountString
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TVDetailViewController()
        vc.id = list[collectionView.tag][indexPath.item].id
        present(vc, animated: true)
    }
    
}

extension TVViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if apiList[collectionView.tag] == .topRated {
            return CGSize(width: 150, height: 300)
        } else {
            return CGSize(width: 100, height: 200)
        }
    }
    
}
