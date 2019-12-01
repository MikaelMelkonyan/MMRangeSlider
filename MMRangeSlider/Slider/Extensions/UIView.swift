//
//  UIView.swift
//  MMRangeSlider
//
//  Created by Mikael Melkonyan on 01.12.2019.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import UIKit

extension UIView {
    
    func setShadow(opacity: Float, color: UIColor, radius: CGFloat, offset: CGSize? = nil) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset ?? .zero
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
