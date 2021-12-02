//
//  FeedTableHeaderView.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/25.
//

import UIKit

class FeedTableHeaderView: UITableViewHeaderFooterView {
	
	var manager = FeedManager.shared
	
	// MARK: - IB Outlets
	
	@IBOutlet weak var todayCountLabel: UILabel?
	@IBOutlet weak var totalCountLabel: UILabel?
	@IBOutlet weak var blogTitleLabel: UILabel?
	@IBOutlet weak var neighborLabel: UIImageView?
	@IBOutlet weak var neighborCountLabel: UILabel?
	
	// MARK: - Life Cycle

	override func awakeFromNib() {
		super.awakeFromNib()
	}
}

extension FeedTableHeaderView {
	
	static let identifier = "FeedTableHeaderView"

	func getHeaderConfigureAt() {
		todayCountLabel?.text = String(manager.headerInfo.todayCount)
		totalCountLabel?.text = String(manager.headerInfo.totalCount)
		blogTitleLabel?.text = manager.headerInfo.blogTitle
		neighborLabel?.image = manager.headerInfo.neighborBadge
		neighborCountLabel?.text = "\(manager.headerInfo.neighborCount)명의 이웃"
	}
}
