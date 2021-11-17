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
    
    @IBOutlet weak var emptyViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addCommentLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Properties
    
    var isFilled = false
    var likeCount = Int()
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setAddTargetAction()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MyPageDetailTVC {
    func setAddTargetAction() {
        likeButton.addTarget(self, action: #selector(touchUpHeartButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpHeartButton() {
        if isFilled {
            likeButton.setImage(UIImage(named: "icSmallheartDefault"), for: .normal)
            likeCount -= 1
        } else {
            likeButton.setImage(UIImage(named: "icSmallheartSelected"), for: .normal)
            likeCount += 1
        }
        likeCountLabel.text = "\(likeCount)"
        isFilled.toggle()
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
        
        self.likeCount = likeCount
        likeCountLabel.text = "\(likeCount)"
    }
}
