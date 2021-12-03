//
//  MyPageResponse.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/12/03.
//

import Foundation

struct MyPageResponseModel: Codable {
    let success: Bool
    let message: String
    let data: MyPageResponse?
}

struct MyPageResponse: Codable {
    let banner: [MyPageBanner]
    let posts: [MyPagePost]
}

struct MyPageBanner: Codable {
    let blogID: Int
    let bannerImage: String
    let todayCount, totalCount: Int
    let blogName, profileName, blogCategory: String
    let neighborNum: Int

    enum CodingKeys: String, CodingKey {
        case blogID = "blogId"
        case bannerImage, todayCount, totalCount, blogName, profileName, blogCategory, neighborNum
    }
}

struct MyPagePost: Codable {
    let postID: Int
    let title, content: String
    let heartNum, secretCommentNum: Int
    let isLike: Bool
    let createdAt, commentNum: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case title, content, heartNum, secretCommentNum, isLike, createdAt, commentNum
    }
}

