//
//  BaseView.swift
//  MediaProject
//
//  Created by 이재희 on 2/1/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { }
    
    func setRoundView<T: UIView> (_ view: T) {
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.width / 2
    }
    
    func setBorder<T: UIView> (_ view: T, color: UIColor, width: CGFloat) {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = width
    }
    
}
