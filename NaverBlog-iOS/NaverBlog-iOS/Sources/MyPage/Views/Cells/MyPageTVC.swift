//
//  MyPageTVC.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/14.
//

import UIKit

protocol MyPageCellDelegate {
    func pushToDetailVC()
}

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
    
    
    // MARK: - Properties
    
    var delegate: MyPageCellDelegate?
    var isFilled = false
    var likeCount = Int()
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTapGesture()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MyPageTVC {
    func addTapGesture() {
        let commentTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpCommentImageView(_:)))
        commentImageView.addGestureRecognizer(commentTapGesture)
        commentImageView.isUserInteractionEnabled = true
        
        let heartTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpHeartButton(_:)))
        likeImageView.addGestureRecognizer(heartTapGesture)
        likeImageView.isUserInteractionEnabled = true
    }
}

extension MyPageTVC {
    @objc
    func touchUpCommentImageView(_ sender: UITapGestureRecognizer) {
        delegate?.pushToDetailVC()
    }
    
    @objc
    func touchUpHeartButton(_ sender: UITapGestureRecognizer) {
        if isFilled {
            likeImageView.image = UIImage(named: "icBigheartDefault")
            likeCount -= 1
        } else {
            likeImageView.image = UIImage(named: "icBigheartSelected")
            likeCount += 1
        }
        likeCountLabel.text = "\(likeCount)"
        isFilled.toggle()
    }
}

extension MyPageTVC {
    func initCell(image: String, title: String, content: String, time: String, likeCount: Int, commentCount: Int) {
        mainImageView.image = UIImage(named: image)
        
        titleLabel.text = title
        contentLabel.text = content
        
        timeLabel.text = time
        
        likeCountLabel.text = "\(likeCount)"
        self.likeCount = likeCount
        
        commentCountLabel.text = "\(commentCount)"
    }
}
