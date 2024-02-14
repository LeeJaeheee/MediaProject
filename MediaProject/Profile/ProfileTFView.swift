//
//  ProfileTFView.swift
//  MediaProject
//
//  Created by 이재희 on 2/8/24.
//

import UIKit
import SnapKit

class ProfileTFView: BaseView {
    
    let label = UILabel()
    let textField = UITextField()
    
    override func configureHierarchy() {
        addSubview(label)
        addSubview(textField)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(100)
        }
        textField.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.trailing)
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    override func configureView() {
        label.font = .systemFont(ofSize: 14)
        textField.font = .systemFont(ofSize: 14)
    }
    
}
