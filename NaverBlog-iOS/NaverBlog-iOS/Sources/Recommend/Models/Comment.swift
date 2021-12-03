//
//  CommentDataModel.swift
//  NaverBlog-iOS
//
//  Created by 배은서 on 2021/11/18.
//
import Foundation

struct Comment: Codable {
    let commentId: Int
    let groupId: Int
    let userName: String
    let isOwner: Bool
    let content: String
    let heartNum: Int
    let isLike: Bool
    let createdAt: String
    let reply: [ReplyComment]
    
    var isOpen: Bool? = false
}
