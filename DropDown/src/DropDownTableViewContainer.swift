//
//  DropDownTableViewContainer.swift
//  DropDown
//
//  Created by Andy Au on 2020/10/5.
//  Copyright © 2020 Kevin Hirsch. All rights reserved.
//

import Foundation
import UIKit

public class DropDownTableViewContainer: UIView {

    // up arrow or down arrow
    public var direction: Direction = Direction.any { 
        didSet { setNeedsDisplay() }
    }
    // 0.0 to 1.0 (ratio) to width
    public var arrowCenter: CGFloat = 0.3 {
        didSet { setNeedsDisplay() }
    }
    // Color of container
    public var containerBackgroundColor: UIColor? {
        didSet { setNeedsDisplay() }
    }
    // fix width
    public var arrowWidth: CGFloat = DPDConstant.UI.ArrowWidth {
        didSet { setNeedsDisplay() }
    }
    // fix pixel because container height can be very long
    public var arrowHeight: CGFloat = DPDConstant.UI.ArrowHeight {
        didSet { setNeedsDisplay() }
    }
    // layer borderWidth
    public var borderWidth: CGFloat = 0.0 {
        didSet { setNeedsDisplay() }
    }
    // layer border color
    public var borderColor: UIColor? = .clear {
        didSet { setNeedsDisplay() }
    }
    // corner raidus
    public var cornerRadius: CGFloat = 0.0 {
        didSet { setNeedsDisplay() }
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .clear
        shapeLayer?.removeFromSuperlayer()
        arrowLayer?.removeFromSuperlayer()
        shapeLayer = CAShapeLayer()
        arrowLayer = CAShapeLayer()
        var center = rect.width * arrowCenter
        let aWidth = arrowWidth/2.0
        let aHeight = arrowHeight
        if (center - aWidth - cornerRadius) < 0 {
            center = aWidth + cornerRadius
        } else if (center + aWidth + cornerRadius) > rect.width {
            center = rect.width - aWidth - cornerRadius
        }
        let path = UIBezierPath()
        let arrowPath = UIBezierPath()

        switch direction {
        case .bottom:
            // Arrow path should add 1 in order to cover tableviews border
            arrowPath.move(to: CGPoint(x: center, y: 0))
            arrowPath.addLine(to: CGPoint(x: center - aWidth - 1, y: aHeight + 1))
            arrowPath.addLine(to: CGPoint(x: center + aWidth + 1, y: aHeight + 1))
            arrowPath.addLine(to:  CGPoint(x: center, y: 0))

            /*
                        .
             */
            path.move(to: CGPoint(x: center, y: 0))
            /*
                        .
                       /
             */
            path.addLine(to: CGPoint(x: center - aWidth, y: aHeight))
            /*
                        .
                _______/
             */

            path.addLine(to: CGPoint(x: cornerRadius, y: aHeight))
            // left top corner if applicable
            path.addArc(withCenter: CGPoint(x: cornerRadius, y: aHeight + cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi * 3.0/2.0 , endAngle: CGFloat.pi , clockwise: false)
            /*
                        .
                _______/
                |
                |
             */
            path.addLine(to: CGPoint(x: 0, y: rect.height - cornerRadius))
            // left bottom corner if applicable
            path.addArc(withCenter: CGPoint(x: cornerRadius, y: rect.height - cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi , endAngle: CGFloat.pi/2.0 , clockwise: false)
            /*
                        .
                _______/
                |
                |________________
             */
            path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: rect.height))
            // right bottom corner if applicable
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius), radius: cornerRadius, startAngle: CGFloat.pi/2.0 , endAngle: 0, clockwise: false)
            /*
                        .
                _______/
                |                |
                |________________|
             */
            path.addLine(to: CGPoint(x: rect.width, y: aHeight + cornerRadius))
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius, y: aHeight + cornerRadius), radius: cornerRadius, startAngle: 0 , endAngle: CGFloat.pi * 3.0/2.0 , clockwise: false)

            /*
                        .
                _______/  ________
                |                |
                |________________|
             */
            path.addLine(to: CGPoint(x: center + aWidth, y: aHeight))
            /*
                        .
                _______/ \________
                |                |
                |________________|
             */
            path.addLine(to: CGPoint(x: center , y: 0))

        case .top:
            // Arrow path should add 1 in order to cover tableviews border
            arrowPath.move(to: CGPoint(x: center, y: rect.height))
            arrowPath.addLine(to: CGPoint(x: center - aWidth - 1, y: rect.height - aHeight - 1))
            arrowPath.addLine(to: CGPoint(x: center + aWidth + 1, y: rect.height - aHeight - 1))
            arrowPath.addLine(to:  CGPoint(x: center, y: rect.height))

            path.move(to: CGPoint(x: cornerRadius, y: 0))
            path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi * 3.0/2.0 ,
                        endAngle: 0,
                        clockwise: true)
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - aHeight - cornerRadius))
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius,
                                            y: rect.height - aHeight - cornerRadius),
                        radius: cornerRadius,
                        startAngle: 0 ,
                        endAngle: CGFloat.pi/2.0,
                        clockwise: true)
            path.addLine(to: CGPoint(x: center + aWidth, y: rect.height - aHeight))
            path.addLine(to: CGPoint(x: center, y: rect.height))
            path.addLine(to: CGPoint(x: center - aWidth, y: rect.height - aHeight))
            path.addLine(to: CGPoint(x: cornerRadius, y: rect.height - aHeight))
            path.addArc(withCenter: CGPoint(x: cornerRadius,
                                            y: rect.height - aHeight - cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi/2.0 ,
                        endAngle: CGFloat.pi,
                        clockwise: true)
            path.addLine(to: CGPoint(x: 0, y: cornerRadius))
            path.addArc(withCenter: CGPoint(x: cornerRadius,
                                            y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi ,
                        endAngle: CGFloat.pi * 3.0/2.0,
                        clockwise: true)
            
        case .any:
            path.move(to: CGPoint(x: cornerRadius, y: 0))
            path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi * 3.0/2.0 ,
                        endAngle: 0,
                        clockwise: true)
            path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))
            path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius,
                                            y: rect.height - cornerRadius),
                        radius: cornerRadius,
                        startAngle: 0 ,
                        endAngle: CGFloat.pi/2.0,
                        clockwise: true)
            path.addLine(to: CGPoint(x: cornerRadius, y: rect.height ))
            path.addArc(withCenter: CGPoint(x: cornerRadius,
                                            y: rect.height - cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi/2.0 ,
                        endAngle: CGFloat.pi,
                        clockwise: true)
            path.addLine(to: CGPoint(x: 0, y: cornerRadius))
            path.addArc(withCenter: CGPoint(x: cornerRadius,
                                            y: cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi ,
                        endAngle: CGFloat.pi * 3.0/2.0,
                        clockwise: true)
        }
        path.close()
        shapeLayer?.path = path.cgPath
        shapeLayer?.fillColor = UIColor.clear.cgColor
        shapeLayer?.strokeColor = borderColor?.cgColor
        shapeLayer?.lineWidth = borderWidth

        arrowPath.close()
        arrowLayer?.path = arrowPath.cgPath
        arrowLayer?.fillColor = containerBackgroundColor?.cgColor
        arrowLayer?.strokeColor = UIColor.clear.cgColor
        arrowLayer?.lineWidth = 0
        layer.addSublayer(arrowLayer!)
        layer.addSublayer(shapeLayer!)
    }

    fileprivate var shapeLayer: CAShapeLayer?
    fileprivate var arrowLayer: CAShapeLayer?

}
