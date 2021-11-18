//
//  CommentDataModel.swift
//  NaverBlog-iOS
//
//  Created by 배은서 on 2021/11/18.
//

import Foundation

struct CommentDataModel {
    let userProfileImage: String
    let userName: String
    let comment: String
    let date: Date
    let likeCount: Int
    let replyCommentData: [ReplyCommentDataModel]
    
    var isOpen: Bool
}
