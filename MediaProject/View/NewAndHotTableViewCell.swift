//
//  NewAndHotTableViewCell.swift
//  MediaProject
//
//  Created by 이재희 on 2/8/24.
//

import UIKit

class NewAndHotTableViewCell: UITableViewCell {
    
    let upcomingDateLabel = UILabel()
    let postImageView = UIImageView()
    let titleImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postImageView)
        contentView.addSubview(titleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        
        postImageView.backgroundColor = .systemCyan
        titleImageView.backgroundColor = .systemYellow
        titleLabel.text = "타이틀"
        detailLabel.text = "디테일"
        
        postImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(postImageView.snp.width)
        }
        titleImageView.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(postImageView)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(8)
            make.leading.equalTo(postImageView)
            make.height.equalTo(18)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(postImageView)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    convenience init(tagType: Tag) {
        self.init(style: .default, reuseIdentifier: NewAndHotTableViewCell.identifier)
        
//        switch tagType {
//        case .upcoming:
//
//        case default:
//            <#code#>
//        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
