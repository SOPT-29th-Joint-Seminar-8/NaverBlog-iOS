//
//  FeedContent.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/25.
//

import UIKit

struct FeedContent {
	var thumbnailImage: UIImage?
	var thumbnailDesc: String
	var title: String
	var contentUpdatedAt: Date
	var commentCount: Int
	var likeCount: Int {
		didSet {
			NotificationCenter.default.post(name: .changeLikeCount, object: nil)
		}
	}
}
