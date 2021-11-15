//
//  MyPageTVC.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/14.
//

import UIKit

class MyPageTVC: UITableViewCell {
    static let identifier = "MyPageTVC"
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MyPageTVC {
    func initCell(image: String, title: String, content: String, time: String, likeCount: Int, commentCount: Int) {
        mainImageView.image = UIImage(named: image)
        
        titleLabel.text = title
        contentLabel.text = content
        
        timeLabel.text = time
        
        likeCountLabel.text = "\(likeCount)"
        
        commentCountLabel.text = "\(commentCount)"
    }
}
