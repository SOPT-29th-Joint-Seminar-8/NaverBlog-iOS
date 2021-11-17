//
//  MyPageDetailDataModel.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/16.
//

import Foundation

struct MyPageDetailDataModel {
    var userImage: String
    var userName: String
    var comment: String
    var time: String
    var likeCount: Int
    
    var isOpen: Bool
    
    var reply: [ReplyDataModel]
    
    mutating func dateFormat() -> String {
        guard let s = self.time.split(separator: " ").first else { return "??" }
        return String(s)
    }
}

struct ReplyDataModel {
    var userImage: String
    var userName: String
    var comment: String
    var time: String
    var likeCount: Int
}
