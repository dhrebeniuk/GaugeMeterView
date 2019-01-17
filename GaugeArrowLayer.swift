//
//  GaugeArrowLayer.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 2/26/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//

import UIKit

class GaugeArrowLayer: CALayer {

	private var arrowLayer: CALayer?
	private var circleLayer: CALayer?

	open var value: Float = 0.0 {
		didSet {
			setupRotation()
		}
	}

	open var maxValue: Float = 120.0 {
		didSet {
			setupRotation()
		}
	}
	
	var gaugeAngle: Float = 30.0 {
		didSet {
			setupRotation()
		}
	}
	
	private func setupRotation() {
		let angle = CGFloat(value*(360.0-2.0*gaugeAngle)/maxValue + gaugeAngle)*CGFloat(Float.pi/180.0) - CGFloat.pi
		let transform = CGAffineTransform(rotationAngle: angle)
		
		arrowLayer?.setAffineTransform(transform)
		circleLayer?.setAffineTransform(transform)
	}
	
	func setupArrow() {
		arrowLayer?.removeFromSuperlayer()
		circleLayer?.removeFromSuperlayer()
		
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		let radius = min(bounds.midX, bounds.midY)
		let shapeLayer = CAShapeLayer()
		shapeLayer.strokeColor = UIColor.white.cgColor
		shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.1).cgColor
		
		let path = CGMutablePath()
		let leftCenter = CGPoint(x: center.x - radius/12.0, y: center.y)
		path.move(to: leftCenter)
		path.addLine(to: CGPoint(x: radius, y: radius/3.5))
		let rightCenter = CGPoint(x: center.x + radius/12.0, y: center.y)
		path.addLine(to: rightCenter)
		
		shapeLayer.path = path
		shapeLayer.frame = bounds
		arrowLayer = shapeLayer
		addSublayer(shapeLayer)
		
		let circleRadius = CGFloat(radius/8.0)
		let newCircleLayer = CAShapeLayer()
		newCircleLayer.strokeColor = UIColor.white.cgColor
		newCircleLayer.fillColor = UIColor.darkGray.cgColor
		let circlePath = CGMutablePath()
		let circleRect = CGRect(x: center.x-circleRadius, y: center.y-circleRadius, width: circleRadius*2.0, height: circleRadius*2.0)
		circlePath.addRoundedRect(in: circleRect, cornerWidth: circleRadius, cornerHeight: circleRadius)
		newCircleLayer.path = circlePath
		newCircleLayer.frame = bounds
		circleLayer = newCircleLayer
		addSublayer(newCircleLayer)
		
		value = 0.0
	}
}
