//
//  ProfileEditViewController.swift
//  MediaProject
//
//  Created by 이재희 on 2/10/24.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    let textField = UITextField()
    
    var handler: ((String) -> Void)?
    var profileLabel: ProfileLabel?
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = profileLabel?.title
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        textField.delegate = self
        textField.placeholder = profileLabel?.placeHolder
        textField.text = text
    }

}

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handler?(textField.text!)
        navigationController?.popViewController(animated: true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        handler?(textField.text!)
        navigationController?.popViewController(animated: true)
    }
}
