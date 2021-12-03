//
//  FeedNetworkModel.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/12/03.
//

import Foundation

// MARK: - FeedNetworkModel

struct FeedNetworkModel: Codable {
	let success: Bool
	let message: String
	let data: DataClass?
}

// MARK: - DataClass

struct DataClass: Codable {
	let banners: [banner]
	let posts: [post]
	
	enum CodingKeys: String, CodingKey {
		case banners = "banner"
		case posts
	}
}

struct banner: Codable {
	var blogId: Int
	var bannerImage: String
	var todayCount: Int
	var totalCount: Int
	var blogName: String
	var profileName: String
	var blogCategory: String
	var neighborNum: Int
}

struct post: Codable {
	var postId: Int
	var title: String
	var content: String
	var heartNum: Int
	var secretCommentNum: Int
	var isLike: Bool
	var createdAt: String
	var commentNum: String
}
