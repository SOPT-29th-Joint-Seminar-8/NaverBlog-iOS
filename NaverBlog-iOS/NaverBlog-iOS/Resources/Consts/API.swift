//
//  API.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/12/02.
//

import Foundation

extension Const {
	struct API {
		
		// MARK: - Naver Blog API BASE URL
		
		static let baseURL = "https://asia-northeast3-naverblog-server.cloudfunctions.net/api"
		
		// MARK: - Feature: get main feed data W/ GET
		
		static let getMainFeedURL = baseURL + "/post/main"
		
		// MARK: - Get Post's Comments W/ GET
		
		static func getPostCommentsURL(postId: String) -> String {
			return baseURL + "/comment/\(postId)"
		}
		
		// MARK: - Send Like to Post W/ PETCH
		
		static func sendLikeToPostURL(postId: Int, state: Bool) -> String {
			return baseURL + "/post/\(postId)/like?state=\(state)"
		}
		
		// MARK: - Send Like to Comment W/ PETCH
		
		static func sendLikeToCommentURL(commentId: String, state: Bool) -> String {
			return baseURL + "/comment/\(commentId)/like?state=\(state)"
		}
		
		// MARK: - Post Comment W/ POST
		
		static let postCommentURL = baseURL + "/comment"
		
	}
}
