//
//  CALayer+.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/11/14.
//

import UIKit

extension CALayer {
  func setShadow(
    color: UIColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.02),
    alpha: Float = 0.5,
    x: CGFloat = 2,
    y: CGFloat = 2,
    blur: CGFloat = 4
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 1.0
  }
}
