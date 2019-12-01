//
//  RangeSlider.swift
//  MMRangeSlider
//
//  Created by Mikael Melkonyan on 01.12.2019.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import UIKit

@IBDesignable final class RangeSlider: UIView {
    
    // MARK: - Parameters. Track
    @IBInspectable var trackBackground: UIColor = .black {
        didSet {
            backLine.backgroundColor = trackBackground
        }
    }
    
    @IBInspectable var trackTint: UIColor = .brown {
        didSet {
            line.backgroundColor = trackTint
        }
    }
    
    var trackCorners: Corners = .rounded(.full) {
        didSet {
            updateLinesCorners()
        }
    }
    
    // MARK: - Subviews. Track
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

extension RangeSlider {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        positionSubviews()
    }
}

// MARK: - Subviews frame
private extension RangeSlider {
    
    func positionSubviews() {
        updateBackLineFrame()
        updateLineFrame()
        updateLinesCorners()
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
        line.frame = CGRect(
            x: backLine.frame.minX, y: backLine.frame.minY,
            width: backLine.frame.width / 2,
            height: backLine.frame.height
        )
    }
    
    func updateLinesCorners() {
        switch trackCorners {
        case .withoutRounding:
            backLine.layer.cornerRadius = 0
            line.layer.cornerRadius = 0
        case let .rounded(rounding):
            switch rounding {
            case .full:
                backLine.layer.cornerRadius = backLine.frame.height / 2
                line.layer.cornerRadius = line.frame.height / 2
            case let .value(radius):
                backLine.layer.cornerRadius = radius
                line.layer.cornerRadius = radius
            }
        }
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
        backLine.backgroundColor = trackBackground
        addSubview(backLine)
    }
    
    func createLine() {
        line = UIView(frame: .zero)
        line.backgroundColor = trackTint
        addSubview(line)
    }
}

// MARK: - Model
extension RangeSlider {
    
    enum Corners {
        case rounded(Rounding)
        case withoutRounding
        
        enum Rounding {
            case full
            case value(CGFloat)
        }
    }
}
