//
//  TVDetailView.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit
import WebKit

class TVDetailView: BaseView {
    
    let backdropImageView = UIImageView()
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let videoView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        return WKWebView(frame: .zero, configuration: config)
    }()
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(backdropImageView)
        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(videoView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
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
        
        videoView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(posterImageView)
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(28)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
 
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        videoView.isHidden = true
        videoView.backgroundColor = .black
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: CastTableViewCell.identifier)
        tableView.register(RecommendationTableViewCell.self, forCellReuseIdentifier: RecommendationTableViewCell.identifier)
    }
}
