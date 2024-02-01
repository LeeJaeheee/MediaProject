//
//  CastTableViewCell.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    let profileImage = UIImageView()
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    let roleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .systemGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 8
    }
    
    func configureHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(roleLabel)
    }
    
    func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(70)
            make.width.equalTo(profileImage.snp.height).multipliedBy(0.75)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
            make.height.equalTo(20)
        }
        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(18)
        }
    }
    
}
