//
//  FeedManager.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/25.
//

import Foundation
import UIKit

struct FeedManager {
	
	/// single ton
	
	static let shared = FeedManager()
	private init() { }
	
	var headerInfo = FeedHeader(todayCount: 0, totalCount: 2807, neighborCount: 38, blogTitle: "Dear", userName: "솝트디자인", category: "일상•생각", neighborBadge: Const.Image.icStatus)
	
	var feedThumbnails = [
		FeedContent(thumbnailImage: Const.Image.imgPost1, thumbnailDesc: "[1월 1일] 평소랑 다를 거 없는 아침인데 새해 첫날이니까 괜히 의미 부여하기 빛도…", title: "1월도 안녕", contentUpdatedAt: DateFormatter.stringToDate(date: "2021-02-02 13:09") ?? Date(), commentCount: 8, likeCount: 7),
		FeedContent(thumbnailImage: Const.Image.imgPost2, thumbnailDesc: "2020의 끝 ! 가장 신났어야 할 12월이 소소하게 지나갔다. 1. 미술사 종강 패키…", title: "막학기 대학생 일상", contentUpdatedAt: DateFormatter.stringToDate(date: "2021-02-06 14:10") ?? Date(), commentCount: 9, likeCount: 3),
		FeedContent(thumbnailImage: Const.Image.imgPost3, thumbnailDesc: "11.03 오전 수업에는 아아 토끼 같은 고냥이 패키지 디쟌 컨펌받고 술 먹으러 갔다…", title: "우리만의", contentUpdatedAt: DateFormatter.stringToDate(date: "2021-02-10 15:11") ?? Date(), commentCount: 9, likeCount: 2)
	]
}

///  FeedTVC

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
}
