//
//  BaseViewController.swift
//  MediaProject
//
//  Created by 이재희 on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.backButtonTitle = ""

        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { }

}
