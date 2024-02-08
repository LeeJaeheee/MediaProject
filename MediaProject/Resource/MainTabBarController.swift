//
//  MainTabBarController.swift
//  MediaProject
//
//  Created by 이재희 on 2/8/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let vc = TVViewController()
        let nav2 = UINavigationController(rootViewController: NewAndHotViewController())
        let nav3 = UINavigationController(rootViewController: ProfileViewController())
        
        vc.tabBarItem.title = "홈"
        vc.tabBarItem.image = UIImage(systemName: "house")
        vc.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        nav2.tabBarItem.title = "New & Hot"
        nav2.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        nav2.tabBarItem.selectedImage = UIImage(systemName: "play.rectangle.on.rectangle.fill")
        
        nav3.tabBarItem.title = "나의 프로필"
        nav3.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        nav3.tabBarItem.selectedImage = UIImage(systemName: "arrow.down.circle.fill")
        
        setViewControllers([vc, nav2, nav3], animated: true)
    }

}
