//
//  RecommendVC.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/13.
//

import UIKit

class RecommendVC: UIViewController {

    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        customNavigationBar.setupLayout()
    }
}
