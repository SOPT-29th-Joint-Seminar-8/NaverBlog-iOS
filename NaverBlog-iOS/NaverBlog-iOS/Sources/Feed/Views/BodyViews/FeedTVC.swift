//
//  FeedTVC.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/25.
//

import UIKit

class FeedTVC: UITableViewCell {
	
	var manager = FeedManager.shared
	var mangerModelIndex = 0
	
	// MARK: - IB Outlets
	
	@IBOutlet weak var thumbnailImage: UIImageView?
	@IBOutlet weak var thumbnailTitleLabel: UILabel?
	@IBOutlet weak var thumbnailDescLabel: UILabel?
	@IBOutlet weak var thumbailTimeStampLabel: UILabel?
	@IBOutlet weak var likeCountLabel: UILabel?
	@IBOutlet weak var commentCountLabel: UILabel?
	@IBOutlet weak var likeButton: UIButton? {
		didSet {
			// TODO: 서버에서 받은 값으로 likeButton 상태 초기화
			likeButton?.isSelected = false
		}
	}
	
	// MARK: - Life Cycle
	
	override func awakeFromNib() {
        super.awakeFromNib()
		addObserver()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func addObserver() {
		NotificationCenter.default.addObserver(self, selector: #selector(changeLikeCountLabel(_:)), name: .changeLikeCount, object: nil)
	}
	
	@IBAction func likeButtonDidTap(_ sender: Any) {
		likeButton?.isSelected.toggle()
		var likeCount = Int(manager.getLikeCount(mangerModelIndex)) ?? 0
		
		if let isSelected = likeButton?.isSelected {
			likeCount = isSelected ? likeCount + 1 : likeCount - 1
			manager.feedThumbnails[mangerModelIndex].likeCount = likeCount
		}
	}
	
	@objc func changeLikeCountLabel(_ notification: Notification) {
		DispatchQueue.main.async { [self] in
			likeCountLabel?.text = String(manager.feedThumbnails[mangerModelIndex].likeCount)
		}
	}
}

extension FeedTVC {
	
	static let identifier = "FeedTVC"
	
	func getCellConfigureAt(_ index: Int) {
		mangerModelIndex = index
		thumbnailImage?.image = manager.getThumbnailImage(index)
		thumbnailTitleLabel?.text = manager.getTitle(index)
		thumbnailDescLabel?.text = manager.getThumbnailDesc(index)
		thumbailTimeStampLabel?.text = manager.getContentUpdatedAt(index)
		likeCountLabel?.text = manager.getLikeCount(index)
		commentCountLabel?.text = manager.getCommentCount(index)
	}
}


