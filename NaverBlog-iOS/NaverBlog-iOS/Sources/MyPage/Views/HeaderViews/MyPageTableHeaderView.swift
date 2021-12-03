//
//  MyPageTableHeaderView.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/12/03.
//

import UIKit

class MyPageTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UI
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var blogNameLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var headerData: MyPageBanner?
    
    // MARK: - Initializers
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initHeader(image: String, todayCount: Int, totalCount: Int, blogName: String, profileName: String, blogCategory: String, neighborNum: Int) {
        // url -> uiimage
        
        countLabel.text = "오늘\(todayCount) | 전체 \(totalCount)"
        
        blogNameLabel.text = blogName
        
        profileNameLabel.text = profileName
        
        descriptionLabel.text = "\(blogCategory) \(neighborNum)명의 이웃"
    }
}
