//
//  NetworkResult.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/12/02.
//

import Foundation

enum NetworkResult<T> {
	case success(T)
	case requestErr(T)
	case pathErr
	case serverErr
	case networkFail
}
