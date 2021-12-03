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
	@IBOutlet weak var likeButton: UIButton?
	
	// MARK: - Life Cycle
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	@IBAction func likeButtonDidTap(_ sender: Any) {
		if let isSelected = likeButton?.isSelected {
			manager.feedThumbnails[mangerModelIndex].isLike = isSelected
			sendLikeToServer()
		}
	}
}

// MARK: - Send Like To Server

extension FeedTVC: ReloadData {
	private func sendLikeToServer() {
		let index = self.mangerModelIndex
		manager.sendLikeToServer(manager.feedThumbnails[index].id, manager.feedThumbnails[index].isLike)
	}
	
	func reloadData() {
		let index = self.mangerModelIndex
		likeButton?.isSelected = manager.feedThumbnails[index].isLike
		likeCountLabel?.text = String(manager.feedThumbnails[index].likeCount)
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
		likeButton?.isSelected = manager.getLikeStatus(index)
	}
}
