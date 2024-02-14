//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 이재희 on 2/8/24.
//

import UIKit

enum ProfileLabel: Int, CaseIterable {
    case name
    case username
    case gender
    case introduce
    case link
    
    var title: String {
        switch self {
        case .name:
            "이름"
        case .username:
            "사용자 이름"
        case .gender:
            "성별 대명사"
        case .introduce:
            "소개"
        case .link:
            "링크"
        }
    }
    
    var placeHolder: String {
        "\(title)을 입력하세요"
    }
}

class ProfileViewController: UIViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        navigationItem.title = "프로필 편집"
        
        mainView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        for item in mainView.profileTFViews {
            item.textField.delegate = self
        }
    }
    
    @objc func profileButtonTapped() {
        navigationController?.pushViewController(UnsplashSearchViewController(), animated: true)
    }

}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc = ProfileEditViewController()
        vc.text = textField.text!
        vc.profileLabel = ProfileLabel(rawValue: textField.tag)
        vc.handler = { text in
            textField.text = text
        }
        navigationController?.pushViewController(vc, animated: true)
        return false
    }
}
