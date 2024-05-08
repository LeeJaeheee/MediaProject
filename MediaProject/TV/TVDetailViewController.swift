//
//  TVDetailViewController.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit
import SnapKit
import Kingfisher

class TVDetailViewController: BaseViewController {
    
    let mainView = TVDetailView()
    var mediaType: MediaType = .tv
 
    let tmdbManager = TMDBSessionManager.shared
    
    lazy var apiList: [TMDBAPI] = [.Details(type: mediaType, id: id), .Cast(type: mediaType, id: id), .Recommendation(type: mediaType, id: id)]
    
    var tvDetail = TVDetailModel()
    var castList: [Cast] = []
    var recommendList: [TVResult] = []
    
    var isPresented: Bool = false
    var id: Int = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                async let tvDetailResult = tmdbManager.request(type: TVDetailModel.self, api: apiList[0])
                async let castListResult = tmdbManager.request(type: CreditModel.self, api: apiList[1])
                async let recommendListResult = tmdbManager.request(type: TVModel.self, api: apiList[2])
                async let videoResult = tmdbManager.request(type: VideoModel.self, api: .video(type: mediaType, id: id))
                
                tvDetail = try await tvDetailResult
                let castResult = try await castListResult
                castList = castResult.cast
                recommendList = try await recommendListResult.results
                
                let video = try await videoResult
                if !video.results.isEmpty, let url = URL(string: "https://www.youtube.com/embed/\(video.results[0].key)") {
                    self.mainView.videoView.load(URLRequest(url: url))
                    self.mainView.videoView.isHidden = false
                }
                
                configureView()
                mainView.tableView.reloadData()
                
            } catch let error as SeSACError {
                handleTMDBError(error)
            } catch {
                print(error)
            }
        }
  
        /*
        let group = DispatchGroup()
        
        group.enter()
        tmdbManager.request(type: TVDetailModel.self, api: apiList[0]) { result, error  in
            if let result {
                self.tvDetail = result
            } else {
                self.handleTMDBError(error)
            }
            group.leave()
        }
        
        group.enter()
        tmdbManager.request(type: CreditModel.self, api: apiList[1]) { result, error  in
            if let result {
                self.castList = result.cast
            } else {
                self.handleTMDBError(error)
            }
            group.leave()
        }
        
        group.enter()
        tmdbManager.request(type: VideoModel.self, api: .video(type: mediaType, id: id)) { result, error  in
            if let result = result, !result.results.isEmpty, let url = URL(string: "https://www.youtube.com/embed/\(result.results[0].key)") {
                self.mainView.videoView.load(URLRequest(url: url))
                self.mainView.videoView.isHidden = false
            } else {
                self.handleTMDBError(error)
            }
            group.leave()
        }
        
        group.enter()
        tmdbManager.request(type: TVModel.self, api: apiList[2]) { result, error  in
            if let result {
                self.recommendList = result.results
            } else {
                self.handleTMDBError(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.configureView()
            self.mainView.tableView.reloadData()
        }
         */

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = isPresented
    }
    
    override func configureView() {
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
        case .Details:
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
            
        case .Details:
            let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as! OverviewTableViewCell
            cell.overviewLabel.text = tvDetail.convertedOverview
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
            cell.roleLabel.text = cast.character
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TVDetailViewController()
        vc.id = recommendList[indexPath.item].id
        vc.isPresented = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



