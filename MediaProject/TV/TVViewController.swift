//
//  TVViewController.swift
//  MediaProject
//
//  Created by 이재희 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class TVViewController: BaseViewController {
    
    var mediaType: MediaType = .all {
        didSet {
            mainView.tagCollectionView.reloadData()
            apiList = [.trending(type: mediaType), .topRated(type: mediaType), .popular(type: mediaType)]
            requestAPI()
        }
    }
    
    let mainView = TVView()
    
    let tmdbManager = TMDBSessionManager.shared
    
    lazy var apiList: [TMDBAPI] = [.trending(type: mediaType), .topRated(type: mediaType), .popular(type: mediaType)]
    
    lazy var list: [[TVResult]] = Array(repeating: [], count: apiList.count)
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tagCollectionView.delegate = self
        mainView.tagCollectionView.dataSource = self
        mainView.tagCollectionView.tag = list.count
        mainView.tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        requestAPI()
    }
    
    func requestAPI() {
        
        Task {
            list = try await tmdbManager.fetchTVModel(apiList: apiList)
            mainView.tableView.reloadData()
        }

    }
}

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return apiList[indexPath.row] == .topRated(type: mediaType) ? 344 : 244
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
        return collectionView.tag == list.count ? HomeTag.allCases.count : list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == list.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            
            cell.label.text = HomeTag.allCases[indexPath.item].rawValue
            cell.label.font = .systemFont(ofSize: 16)
            
            switch mediaType {
            case .movie:
                if MediaType.allCases[indexPath.item] == .movie {
                    cell.backgroundColor = .systemGray6
                } else {
                    cell.backgroundColor = .clear
                }
            case .tv:
                if MediaType.allCases[indexPath.item] == .tv {
                    cell.backgroundColor = .systemGray6
                } else {
                    cell.backgroundColor = .clear
                }
            case .all:
                cell.backgroundColor = .clear
            }
            
            return cell
        } else {
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
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == list.count {
            let type = MediaType.allCases[indexPath.item]
            if type != mediaType {
                mediaType = type
            }
        } else {
            let vc = TVDetailViewController()
            vc.id = list[collectionView.tag][indexPath.item].id
            vc.isPresented = true
            vc.mediaType = mediaType
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        }
    }
    
}

extension TVViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == list.count {
            return .zero
        }
        return apiList[collectionView.tag] == .topRated(type: mediaType) ? CGSize(width: 150, height: 300) : CGSize(width: 100, height: 200)
    }
    
}
