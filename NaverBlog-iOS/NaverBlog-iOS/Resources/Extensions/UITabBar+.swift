//
//  UITabBar+.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/15.
//

import UIKit

extension UITabBar {
    // 기본 그림자 스타일을 초기화 해야 커스텀 스타일 적용 가능 
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
