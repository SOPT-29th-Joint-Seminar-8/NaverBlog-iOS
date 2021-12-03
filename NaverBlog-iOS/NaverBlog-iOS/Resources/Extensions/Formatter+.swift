//
//  DateFormatter+.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/11/25.
//

import Foundation

extension Formatter {
	static func string(iso date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.M.d"
		
		return dateFormatter.string(from: date)
	}
	
	static func stringToDate(date: String) -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.M.d."
		
		return dateFormatter.date(from: date)
	}
}
