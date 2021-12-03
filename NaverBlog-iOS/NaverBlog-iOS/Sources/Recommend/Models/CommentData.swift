//
//  CommentData.swift
//  NaverBlog-iOS
//
//  Created by 배은서 on 2021/12/03.
//

struct CommentData: Codable {
    let commentNum: String
    let secretCommentNum: Int
    let comments: [Comment]
}
