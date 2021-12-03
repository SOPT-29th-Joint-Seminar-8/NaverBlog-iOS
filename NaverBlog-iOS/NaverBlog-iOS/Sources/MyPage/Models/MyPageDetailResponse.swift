//
//  MyPageDetailResponse.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/12/03.
//

import Foundation

struct MyPageDetailResponseModel: Codable {
    let success: Bool
    let message: String
    let data: MyPageDetailResponse?
}

struct MyPageDetailResponse: Codable {
    let commentNum: String
    let secretCommentNum: Int
    let comments: [MyPageComment]
}

struct MyPageComment: Codable {
    let commentID, groupID: Int
    let userName: String
    let isOwner: Bool
    let content: String
    let heartNum: Int
    let isLike: Bool
    let createdAt: String
    let reply: [MyPageComment]?

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case groupID = "groupId"
        case userName, isOwner, content, heartNum, isLike, createdAt, reply
    }
}
