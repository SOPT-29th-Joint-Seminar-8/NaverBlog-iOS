//
//  FeedManager.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/25.
//

import UIKit

class FeedManager {
	
	/// single ton
	
	static let shared = FeedManager()
	private init() { }
	
	var networkManager = FeedNetworkManager.shared
	var delegate: ReloadData?
	var headerInfo: FeedHeader?
	var feedThumbnails = [FeedContent]()
}

// MARK: - Fetch Feed Data

extension FeedManager {
	func getMainFeed() {
		networkManager.requestGetFeed { [weak self] responseData in
			switch responseData {
			case .success(let feedResponseData):
				guard let response = feedResponseData as? FeedNetworkModel else { return }
				
				if let responseData = response.data {
					let header = responseData.banners.map {  banner in
						FeedHeader(todayCount: banner.todayCount, totalCount: banner.totalCount, neighborCount: banner.neighborNum, blogTitle: banner.blogName, userName: banner.profileName, category: banner.blogCategory)
					}
					var feed = responseData.posts.map { post in
						FeedContent(id: post.postId, thumbnailImage: UIImage(), thumbnailDesc: post.content, title: post.title, contentUpdatedAt: Formatter.stringToDate(date: post.createdAt) ?? Date(), commentCount: post.commentNum, isLike: post.isLike, likeCount: post.heartNum)
					}
					
					let thumnailImages = [Const.Image.imgPost1, Const.Image.imgPost2, Const.Image.imgPost3]
					
					thumnailImages.indices.forEach {
						feed[$0].thumbnailImage = thumnailImages[$0]
					}
					
					self?.headerInfo = header.first
					self?.feedThumbnails = feed
					
					self?.delegate?.reloadData()
				}
			default:
				NSLog("데이터 불러오기 실패")
			}
		}
	}
}

// MARK: -  FeedTVC

extension FeedManager {
	func getThumbnailImage(_ index: Int) -> UIImage? {
		return feedThumbnails[index].thumbnailImage
	}
	
	func getThumbnailDesc(_ index: Int) -> String {
		return feedThumbnails[index].thumbnailDesc
	}
	
	func getTitle(_ index: Int) -> String {
		return feedThumbnails[index].title
	}
	
	func getContentUpdatedAt(_ index: Int) -> String? {
		let date = feedThumbnails[index].contentUpdatedAt
		return DateFormatter.string(iso: date)
	}
	
	func getCommentCount(_ index: Int) -> String {
		return String(feedThumbnails[index].commentCount)
	}
	
	func getLikeCount(_ index: Int) -> String {
		return String(feedThumbnails[index].likeCount)
	}
	
	func getLikeStatus(_ index: Int) -> Bool {
		return feedThumbnails[index].isLike
	}
}
