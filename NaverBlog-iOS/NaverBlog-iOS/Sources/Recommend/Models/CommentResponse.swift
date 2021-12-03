//
//  CommentResponse.swift
//  NaverBlog-iOS
//
//  Created by 배은서 on 2021/12/03.
//

struct CommentResponse: Codable {
    let success: Bool
    let message: String
    let data: CommentData?
}
