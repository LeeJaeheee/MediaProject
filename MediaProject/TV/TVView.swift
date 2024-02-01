//
//  TVView.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit

class TVView: BaseView {
    
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.separatorStyle = .none
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
    }
    
}
