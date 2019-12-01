//
//  RangeSlider.swift
//  MMRangeSlider
//
//  Created by Mikael Melkonyan on 01.12.2019.
//  Copyright © 2019 Mikael Melkonyan. All rights reserved.
//

import UIKit

#warning("todo @IBDesignable")
final class RangeSlider: UIView {
    
    // MARK: - Track
    private var backLine: UIView!
    private var line: UIView!
    // MARK: - Left thumb
    private var leftThumbContainer: UIView!
    private var leftThumbTitle: UILabel!
    private var leftThumb: UIView!
    // MARK: - Right thumb
    private var rightThumbContainer: UIView!
    private var rightThumbTitle: UILabel!
    private var rightThumb: UIView!
    
    private var leftThumbContainerMinX: CGFloat = 0
    private var rightThumbContainerMaxX: CGFloat = 0
    private var currentLeftThumbContainerX: CGFloat = 0
    private var currentRightThumbContainerX: CGFloat = 0
    
    private var leftThumbGestureRecognizer: UIPanGestureRecognizer?
    private var rightThumbGestureRecognizer: UIPanGestureRecognizer?
    
    // MARK: - Parameters
    var trackBackground: UIColor = .secondarySystemFill // {
//        didSet {
//            backLine.backgroundColor = trackBackground
//        }
//    }
    
    var trackTint: UIColor = .systemBlue // {
//        didSet {
//            line.backgroundColor = trackTint
//        }
//    }
    
    var thumbsColor: UIColor = .label // {
//        didSet {
//            leftThumb.backgroundColor = thumbsColor
//            rightThumb.backgroundColor = thumbsColor
//        }
//    }
    
    var minimum: CGFloat = 0 // {
//        didSet {
//            #warning("todo")
//        }
//    }
        
    var maximum: CGFloat = 10 // {
//        didSet {
//            #warning("todo")
//        }
//    }
    
    var from: CGFloat = 4 // {
//        didSet {
//            if from > to {
//                to = from
//            }
//            updateView()
//        }
//    }
    
    var to: CGFloat = 8 // {
//        didSet {
//            if to < from {
//                from = to
//            }
//            updateView()
//        }
//    }
    
    var titlesFont: UIFont = .systemFont(ofSize: 15) // {
//        didSet {
//            leftThumbTitle.font = titlesFont
//            rightThumbTitle.font = titlesFont
//        }
//    }
    
    var titlesColor: UIColor = .label // {
//        didSet {
//            leftThumbTitle.textColor = titlesColor
//            rightThumbTitle.textColor = titlesColor
//        }
//    }
    
    var thumbsShadow: Shadow = .installed(opacity: 0.5, color: .systemGray, radius: 3, offset: CGSize(width: 0, height: 1.5)) // {
//        didSet {
//            updateThumbsShadows()
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateView()
    }
    
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//
//        updateView()
//    }
}

// MARK: - Private actions
private extension RangeSlider {
    
    @objc func leftThumbPan(_ sender: UIPanGestureRecognizer) {
        let translationX = sender.translation(in: self).x
        
        var newX = currentLeftThumbContainerX + translationX
        newX = max(leftThumbContainerMinX, newX)
        newX = min(rightThumbContainerMaxX, newX)
        
        switch sender.state {
        case .began, .changed:
            leftThumbContainer.frame.origin.x = newX
//            updateSliderElements(isPanEnded: false)
        case .ended:
            break
//            updateSliderElements(isPanEnded: true)
        default:
            break
        }
    }
    
    @objc func rightThumbPan(_ sender: UIPanGestureRecognizer) {
        let translationX = sender.translation(in: self).x

        var newX = currentRightThumbContainerX + translationX
        newX = max(leftThumbContainerMinX, newX)
        newX = min(rightThumbContainerMaxX, newX)
        
        switch sender.state {
        case .began, .changed:
            rightThumbContainer.frame.origin.x = newX
//            updateSliderElements(isPanEnded: false)
        case .ended:
            break
//            updateSliderElements(isPanEnded: true)
        default:
            break
        }
    }
}

// MARK: - Subviews frame
private extension RangeSlider {
    
    func updateView() {
        updateBackLineFrame()
        updateThumbsFrames()
        updateLineFrame()
    }
    
    func updateBackLineFrame() {
        let height: CGFloat = 3
        backLine.frame = CGRect(
            x: 0, y: (frame.height - height) / 2,
            width: frame.width, height: height
        )
        backLine.layer.cornerRadius = backLine.frame.height / 2
    }
    
    func updateThumbsFrames() {
        let containerWidth: CGFloat = 56
        let thumbWidthHeight: CGFloat = 28
        
        #warning("todo maximum / minimum, check on Null")
        let from = self.from / (maximum - minimum)
        let to = self.to / (maximum - minimum)
        
        let interval = backLine.frame.width - containerWidth
        
        let leftX = from * interval - thumbWidthHeight / 2
        let rightX = to * interval + thumbWidthHeight / 2
        
        leftThumbContainer.frame = CGRect(x: leftX, y: 0, width: containerWidth, height: frame.height)
        rightThumbContainer.frame = CGRect(x: rightX, y: 0, width: containerWidth, height: frame.height)
        
        leftThumbContainerMinX = -thumbWidthHeight / 2
        rightThumbContainerMaxX = interval + thumbWidthHeight / 2
        
        currentLeftThumbContainerX = leftX
        currentRightThumbContainerX = rightX
        
        leftThumb.frame = CGRect(
            x: (leftThumbContainer.frame.width - thumbWidthHeight) / 2,
            y: (leftThumbContainer.frame.height - thumbWidthHeight) / 2,
            width: thumbWidthHeight, height: thumbWidthHeight
        )
        rightThumb.frame = CGRect(
            x: (leftThumbContainer.frame.width - thumbWidthHeight) / 2,
            y: (leftThumbContainer.frame.height - thumbWidthHeight) / 2,
            width: thumbWidthHeight, height: thumbWidthHeight
        )
        
        leftThumb.layer.cornerRadius = leftThumb.frame.height / 2
        rightThumb.layer.cornerRadius = rightThumb.frame.height / 2
        
//        leftThumbTitle.frame = CGRect(x: 0, y: 0, width: leftThumbContainer.frame.width, height: 22)
//        rightThumbTitle.frame = CGRect(x: 0, y: 0, width: rightThumbContainer.frame.width, height: 22)
    }
    
    func updateLineFrame() {
        let start = leftThumbContainer.frame.minX + leftThumb.frame.midX
        let end = rightThumbContainer.frame.minX + rightThumb.frame.midX
        line.frame = CGRect(
            x: min(start, end),
            y: backLine.frame.minY,
            width: (start - end) * ((start > end) ? 1 : -1),
            height: backLine.frame.height
        )
        line.layer.cornerRadius = line.frame.height / 2
    }
}

// MARK: - Subviews creation
private extension RangeSlider {
    
    func setupView() {
        setupBackLine()
        setupLine()
        setupLeftThumbContainer()
        setupRightThumbContainer()
        updateThumbsShadows()
        setupGestures()
    }
    
    func setupBackLine() {
        backLine = UIView()
        backLine.backgroundColor = trackBackground
        addSubview(backLine)
    }
    
    func setupLine() {
        line = UIView()
        line.backgroundColor = trackTint
        addSubview(line)
    }
    
    func setupLeftThumbContainer() {
        leftThumbContainer = UIView()
        leftThumbContainer.backgroundColor = .clear
        addSubview(leftThumbContainer)
        setupLeftThumbTitle()
        setupLeftThumb()
    }
    
    func setupLeftThumbTitle() {
        leftThumbTitle = UILabel()
        leftThumbTitle.font = titlesFont
        leftThumbTitle.textColor = titlesColor
        leftThumbTitle.text = "Test left"
        leftThumbContainer.addSubview(leftThumbTitle)
    }
    
    func setupLeftThumb() {
        leftThumb = UIView()
        leftThumb.backgroundColor = thumbsColor
        leftThumbContainer.addSubview(leftThumb)
    }
    
    func setupRightThumbContainer() {
        rightThumbContainer = UIView()
        rightThumbContainer.backgroundColor = .clear
        addSubview(rightThumbContainer)
        setupRightThumbTitle()
        setupRightThumb()
    }
    
    func setupRightThumbTitle() {
        rightThumbTitle = UILabel()
        rightThumbTitle.font = titlesFont
        rightThumbTitle.textColor = titlesColor
        rightThumbTitle.text = "Test right"
        rightThumbContainer.addSubview(rightThumbTitle)
    }
    
    func setupRightThumb() {
        rightThumb = UIView()
        rightThumb.backgroundColor = thumbsColor
        rightThumbContainer.addSubview(rightThumb)
    }
    
    func updateThumbsShadows() {
        switch thumbsShadow {
        case .none:
            leftThumb.removeShadow()
            rightThumb.removeShadow()
        case let .installed(opacity, color, radius, offset):
            leftThumb.setShadow(opacity: opacity, color: color, radius: radius, offset: offset)
            rightThumb.setShadow(opacity: opacity, color: color, radius: radius, offset: offset)
        }
    }
    
    func setupGestures() {
        leftThumbGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(leftThumbPan(_:)))
        leftThumbContainer.addGestureRecognizer(leftThumbGestureRecognizer!)
        rightThumbGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(rightThumbPan(_:)))
        rightThumbContainer.addGestureRecognizer(rightThumbGestureRecognizer!)
    }
}

// MARK: - Model
extension RangeSlider {
    
    enum Shadow {
        case none
        case installed(opacity: Float, color: UIColor, radius: CGFloat, offset: CGSize?)
    }
}

