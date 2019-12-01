//
//  RangeSlider.swift
//  MMRangeSlider
//
//  Created by Mikael Melkonyan on 01.12.2019.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import UIKit

final class RangeSlider: UIView {
    
    private var backLine: UIView!
    private var line: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        createSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        positionSubviews()
    }
}

// MARK: - Subviews frame
private extension RangeSlider {
    
    func positionSubviews() {
        updateBackLineFrame()
        updateLineFrame()
    }
    
    func updateBackLineFrame() {
        #warning("todo")
        let left: CGFloat = 0
        let right: CGFloat = 0
        let top: CGFloat = 20
        let height: CGFloat = 20
        backLine.frame = CGRect(x: left, y: top, width: frame.width - left - right, height: height)
    }
    
    func updateLineFrame() {
        #warning("todo")
        line.frame = CGRect(x: backLine.frame.minX, y: backLine.frame.minY, width: backLine.frame.width / 2, height: backLine.frame.height)
    }
}

// MARK: - Subviews creation
private extension RangeSlider {
    
    func createSubviews() {
        createBackLine()
        createLine()
    }
    
    func createBackLine() {
        backLine = UIView(frame: .zero)
        backLine.backgroundColor = .black
        addSubview(backLine)
    }
    
    func createLine() {
        line = UIView(frame: .zero)
        line.backgroundColor = .brown
        addSubview(line)
    }
}
