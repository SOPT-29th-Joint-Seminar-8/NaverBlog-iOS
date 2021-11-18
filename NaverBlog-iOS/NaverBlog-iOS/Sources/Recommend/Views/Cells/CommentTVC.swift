//
//  CommentTVC.swift
//  NaverBlog-iOS
//
//  Created by 배은서 on 2021/11/18.
//

import UIKit

class CommentTVC: UITableViewCell {
    
    static let identifier = "CommentTVC"

    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var commentMoreLabel: UILabel!
    @IBOutlet weak var commentMoreStackView: UIStackView!
    
    @IBOutlet weak var commentStackView: UIStackView!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private var commentStackViewConstraint: NSLayoutConstraint?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy.MM.dd  HH:mm"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        commentStackView.translatesAutoresizingMaskIntoConstraints = false
        commentStackViewConstraint = commentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
    }
    
    override func prepareForReuse() {
        commentMoreStackView.isHidden = false
        commentStackViewConstraint?.isActive = false
    }
    
    func setup(userProfileImage: String,
               userName: String,
               comment: String,
               date: Date,
               likeCount: Int,
               replyCommentCount: Int?) {
        userImageButton.setImage(UIImage(named: userProfileImage), for: .normal)
        userNameLabel.text = userName
        commentLabel.text = comment
        dateLabel.text = dateFormatter.string(from: date)
        if let replyCommentCount = replyCommentCount {
            commentMoreLabel.text = "답글 \(replyCommentCount)개 보기"
        } else {
            commentMoreStackView.isHidden = true
        }
        likeCountLabel.text = "\(likeCount)"
    }
    
    func setReplyCommentLayout() {
        commentStackViewConstraint = commentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54)
        commentStackViewConstraint?.isActive = true
    }
    
    func setCommentLayout() {
        commentStackViewConstraint = commentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        commentStackViewConstraint?.isActive = true
    }
}
