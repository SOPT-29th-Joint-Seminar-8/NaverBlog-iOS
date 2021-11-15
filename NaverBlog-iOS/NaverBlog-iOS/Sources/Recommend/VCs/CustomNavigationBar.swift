//
//  CustomNavigationBar.swift
//  NaverBlog-iOS
//
//  Created by 배은서 on 2021/11/16.
//

import UIKit

class CustomNavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icBack"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "글 댓글"
        label.textColor = .black
        label.font = UIFont(name: "NanumBarunGothicBold", size: 16)
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "8"
        label.textColor = UIColor(named: "blogGreen")
        label.font = UIFont(name: "NanumBarunGothicBold", size: 16)
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "blogGray001")
        return view
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var barStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleStackView])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 127
        return stackView
    }()
    
    func setupLayout() {
        [barStackView, seperatorView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            barStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            barStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
