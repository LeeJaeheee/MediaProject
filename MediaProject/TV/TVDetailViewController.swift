//
//  TVDetailViewController.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit
import SnapKit
import Kingfisher

enum TVDetailTableViewSections: Int, CaseIterable {
    case Overview
    case Cast
    case Recommendation
    
    var title: String {
        switch self {
        case .Overview:
            return "줄거리"
        case .Cast:
            return "출연"
        case .Recommendation:
            return "추천 콘텐츠"
        }
    }
}

class TVDetailViewController: BaseViewController {
    
    let backdropImageView = UIImageView()
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let tableView = UITableView()
    
    let tmdbManager = TMDBAPIManager.shared
    var tvDetail: TVDetailModel?
    var castList: [Cast] = []
    var recommendList: [TVResult] = []
    
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let group = DispatchGroup()
        
        group.enter()
        tmdbManager.fetchTVDetail(id: id) { result in
            self.tvDetail = result
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchCredits(id: id) { result in
            self.castList = result
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchTV(url: "tv/\(id)/recommendations") { result in
            self.recommendList = result
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.configureView()
            self.tableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(backdropImageView)
        view.addSubview(titleLabel)
        view.addSubview(posterImageView)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(backdropImageView.snp.width).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView).inset(16)
            make.horizontalEdges.equalToSuperview().inset(28)
            make.height.equalTo(28)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(backdropImageView).inset(8)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(2.0/3.0)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        guard let tvDetail = tvDetail else { return }
        
        if let backdrop = tvDetail.backdropPath {
            backdropImageView.kf.setImage(with: URL(string: tmdbManager.imageBaseURL + backdrop))
        } else {
            backdropImageView.image = UIImage(systemName: "xmark")
        }
        
        titleLabel.text = tvDetail.name
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        if let poster = tvDetail.posterPath {
            posterImageView.kf.setImage(with: URL(string: tmdbManager.imageBaseURL + poster))
        } else {
            posterImageView.image = UIImage(systemName: "xmark")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        tableView.register(RecommendationTableViewCell.self, forCellReuseIdentifier: RecommendationTableViewCell.identifier)
    }

}

extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TVDetailTableViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TVDetailTableViewSections.allCases[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TVDetailTableViewSections.allCases[section] {
        case .Overview:
            return 1
        case .Cast:
            return 4
        case .Recommendation:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch TVDetailTableViewSections.allCases[indexPath.section] {
            
        case .Overview:
            let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as! OverviewTableViewCell
            cell.overviewLabel.text = tvDetail?.overview
            return cell
            
        case .Cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as! CastTableViewCell
            let cast = castList[indexPath.row]
            if let profile = cast.profilePath {
                cell.profileImage.kf.setImage(with: URL(string: tmdbManager.imageBaseURL + profile))
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
            cell.posterImageView.kf.setImage(with: URL(string: tmdbManager.imageBaseURL + poster))
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        return cell
    }
    
}


