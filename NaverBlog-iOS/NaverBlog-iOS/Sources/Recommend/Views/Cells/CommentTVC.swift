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
    
    var isOpen: Bool = false
    var replyCommentCount: Int = 0
    var likeCount: Int = 0
    
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
        self.replyCommentCount = replyCommentCount ?? 0
        self.likeCount = likeCount
    }
    
    private func set(isOpen: Bool, replyCommentCount: Int) {
        if isOpen {
            commentMoreLabel.text = "답글 숨기기"
        } else {
            commentMoreLabel.text = "답글 \(replyCommentCount)개 보기"
        }
    }
    
    func setCommentLeadingLayout(constant: CGFloat) {
        commentStackViewConstraint = commentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant)
        commentStackViewConstraint?.isActive = true
    }
    
    func setCommentMoreLabel(isOpen: Bool) {
        if isOpen {
            commentMoreLabel.text = "답글 숨기기"
        } else {
            commentMoreLabel.text = "답글 \(replyCommentCount)개 보기"
        }
    }
    
    @IBAction func touchUpLikeButton(_ sender: Any) {
        if likeButton.isSelected {
            likeButton.isSelected.toggle()
            likeCount -= 1
            likeCountLabel.text = "\(likeCount)"
        } else {
            likeButton.isSelected.toggle()
            likeCount += 1
            likeCountLabel.text = "\(likeCount)"
        }
    }
}
