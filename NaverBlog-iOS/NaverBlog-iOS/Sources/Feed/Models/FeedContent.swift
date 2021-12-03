//
//  FeedContent.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/25.
//

import UIKit

struct FeedContent {
	var id: Int
	var thumbnailImage: UIImage?
	var thumbnailDesc: String
	var title: String
	var contentUpdatedAt: Date
	var commentCount: String
	var isLike: Bool
	var likeCount: Int
}
