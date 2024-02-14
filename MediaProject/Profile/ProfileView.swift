//
//  ProfileView.swift
//  MediaProject
//
//  Created by 이재희 on 2/12/24.
//

import UIKit

class ProfileView: BaseView {
    
    lazy var profileButton: UIButton = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 60)
        let image = UIImage(systemName: "person.fill", withConfiguration: configuration)
       let view = UIButton()
        view.setImage(image, for: .normal)
        view.backgroundColor = .systemGray5
        view.tintColor = .white
        self.setBorder(view, color: .systemGray6, width: 1)
        return view
    }()
    
    lazy var avatarButton: UIButton = {
        let view = UIButton()
        self.setBorder(view, color: .systemGray6, width: 1)
        return view
    }()
    
    lazy var profileTFViews: [ProfileTFView] = {
        var views: [ProfileTFView] = []
        for (i, item) in ProfileLabel.allCases.enumerated() {
            let view = ProfileTFView()
            view.label.text = item.title
            view.textField.placeholder = item.placeHolder
            view.textField.tag = i
            views.append(view)
            addSubview(view)
        }
        return views
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setRoundView(profileButton)
        setRoundView(avatarButton)
    }
    
    override func configureHierarchy() {
        addSubview(profileButton)
        addSubview(avatarButton)
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-45)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.size.equalTo(80)
        }
        
        avatarButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(45)
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.size.equalTo(80)
        }
        
        for (i, view) in profileTFViews.enumerated() {
            view.snp.makeConstraints { make in
                make.top.equalTo(i == 0 ? profileButton.snp.bottom : profileTFViews[i-1].snp.bottom).offset(i == 0 ? 20 : 0)
                make.horizontalEdges.equalTo(safeAreaLayoutGuide)
                make.height.equalTo(40)
            }
        }
    }
    
}
