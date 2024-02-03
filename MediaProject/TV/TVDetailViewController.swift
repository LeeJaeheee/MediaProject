//
//  TVDetailViewController.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit
import SnapKit
import Kingfisher

//enum TVDetailTableViewSections: Int, CaseIterable {
//    case Overview
//    case Cast
//    case Recommendation
//}

class TVDetailViewController: BaseViewController {
    
    let mainView = TVDetailView()
 
    let tmdbManager = TMDBAPIManager.shared
    
    lazy var apiList: [TMDBAPI] = [.Overview(id: id), .Cast(id: id), .Recommendation(id: id)]
    
    var tvDetail: TVDetailModel?
    var castList: [Cast] = []
    var recommendList: [TVResult] = []
    
    var id: Int = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let group = DispatchGroup()
        
        group.enter()
        tmdbManager.request(type: TVDetailModel.self, api: apiList[0]) { result in
            self.tvDetail = result
            group.leave()
        }
        
        group.enter()
        tmdbManager.request(type: CreditModel.self, api: apiList[1]) { result in
            self.castList = result.cast
            group.leave()
        }
        
        group.enter()
        tmdbManager.request(type: TVModel.self, api: apiList[2]) { result in
            self.recommendList = result.results
//            if self.recommendList.isEmpty {
//                self.apiList.remove(at: 2)
//            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.configureView()
            self.mainView.tableView.reloadData()
        }
    }
    
    override func configureView() {
        guard let tvDetail = tvDetail else { return }
        
        if let backdrop = tvDetail.backdropPath {
            mainView.backdropImageView.kf.setImage(with: URL(string: TMDBAPI.imageBaseURL + backdrop))
        } else {
            mainView.backdropImageView.image = UIImage(systemName: "xmark")
        }
        
        mainView.titleLabel.text = tvDetail.name

        
        if let poster = tvDetail.posterPath {
            mainView.posterImageView.kf.setImage(with: URL(string: TMDBAPI.imageBaseURL + poster))
        } else {
            mainView.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
    }
    

}

extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return apiList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return apiList[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch apiList[section] {
        case .Overview:
            return 1
        case .Cast:
            return min(4, castList.count)
        case .Recommendation:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch apiList[indexPath.section] {
            
        case .Overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as! OverviewTableViewCell
            cell.overviewLabel.text = tvDetail?.convertedOverview
            return cell
            
        case .Cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
            let cast = castList[indexPath.row]
            if let profile = cast.profilePath {
                cell.profileImage.kf.setImage(with: URL(string: TMDBAPI.imageBaseURL + profile))
            } else {
                cell.profileImage.image = UIImage(systemName: "person")
            }
            cell.nameLabel.text = cast.name
            cell.roleLabel.text = cast.roles[0].character
            return cell
            
        case .Recommendation:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationTableViewCell.identifier, for: indexPath) as! RecommendationTableViewCell
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(RecommendationCollectionViewCell.self, forCellWithReuseIdentifier: RecommendationCollectionViewCell.identifier)
            cell.collectionView.reloadData()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.identifier, for: indexPath) as! RecommendationCollectionViewCell

        cell.backgroundColor = .black
        if let poster = recommendList[indexPath.item].poster {
            cell.posterImageView.kf.setImage(with: URL(string: TMDBAPI.imageBaseURL + poster))
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        return cell
    }
    
}


