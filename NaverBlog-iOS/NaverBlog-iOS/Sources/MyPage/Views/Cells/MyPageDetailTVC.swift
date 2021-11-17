//
//  MyPageDetailTVC.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/16.
//

import UIKit

class MyPageDetailTVC: UITableViewCell {
    static let identifier = "MyPageDetailTVC"
    
    // MARK: - UI
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addCommentLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MyPageDetailTVC {
    func initCell(userImage: String, userName: String, comment: String, time: String, likeCount: Int) {
        userImageView.image = UIImage(named: userImage)
        userNameLabel.text = userName
        
        commentLabel.text = comment
        
        timeLabel.text = time
        
        commentLabel.text = comment
        
        timeLabel.text = time
        
        likeCountLabel.text = "\(likeCount)"
    }
}
