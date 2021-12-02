//
//  CustomNavigationBarView.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/17.
//

import UIKit

class CustomNavigationBarView: UIView {
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icBack"), for: .normal)
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    init(vc: UIViewController, title: String) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setAction(vc: vc)
        setTitle(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = UIColor.white
    }
    
    private func setLayout() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(separatorView)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    private func setAction(vc: UIViewController) {
        let backAction = UIAction { _ in
            vc.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(backAction, for: .touchUpInside)
    }
    
}


