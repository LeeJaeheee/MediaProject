//
//  UnsplashSearchViewController.swift
//  MediaProject
//
//  Created by 이재희 on 2/12/24.
//

import UIKit

class UnsplashSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UnsplashAPIManager.shared.request(type: UnsplashSearchModel.self, api: .search(query: "hi")) { data, error in
            print(data)
        }
    }

}
