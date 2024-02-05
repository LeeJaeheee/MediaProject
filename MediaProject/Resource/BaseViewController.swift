//
//  BaseViewController.swift
//  MediaProject
//
//  Created by 이재희 on 1/31/24.
//

import UIKit

enum TransitionStyle {
    case present
    case presentNavigation
    case presentFullNavigation
    case push
}

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
    
    func transition<T: UIViewController>(style: TransitionStyle, viewController: T.Type) {
        let vc = T()
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func handleTMDBError(_ error: SeSACError?) {
        guard let error = error else { return }
        switch error {
        case .failedRequest:
            showAlert(message: "Failed Request")
        case .noData:
            showAlert(message: "No Data")
        case .invalidResponse:
            showAlert(message: "Invalid Response")
        case .invalidData:
            showAlert(message: "Invalid Data")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "오류 발생", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
