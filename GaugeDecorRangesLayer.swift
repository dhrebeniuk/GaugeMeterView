//
//  GaugeDecorRangesLayer.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 2/26/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//

import QuartzCore

class GaugeDecorRangesLayer: CALayer {
	var ranges: [(value: Float, color: CGColor)]? {
		didSet {
			setupScales()
		}
	}
	
	var gaugeAngle: Float = 0.0 {
		didSet {
			setupScales()
		}
	}
	
	private var decorRangesLayers: [CALayer]?

	private func setupScales() {
		if let decorRangesLayers = decorRangesLayers {
			for decorRangesLayer in decorRangesLayers {
				decorRangesLayer.removeFromSuperlayer()
			}
		}
		
		guard let ranges = ranges else {
			return
		}
		
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		let radius = min(bounds.midX, bounds.midY)
		var previosRange = Float(0.0)
		let maxValue = Int(ranges.last?.value ?? 360.0)

		for range in ranges {
			
			let value = range.value/180.0*Float.pi
			
			let decorScalesPath = CGMutablePath()
			for index in Int(previosRange*Float(180.0/Float.pi))...Int(value*Float(180.0/Float.pi)) {
				let linePath = CGMutablePath()
				linePath.move(to: CGPoint(x: radius - radius/4.0 + radius/60.0, y: 0.0))
				
				if index % (maxValue/12) == 0 {
					linePath.move(to: CGPoint(x: radius - radius/4.0, y: 0.0))
				}
				else if index % (maxValue/24) == 0 {
					linePath.move(to: CGPoint(x: radius - radius/4.0 + radius/30.0, y: 0.0))
				}
				else {
					linePath.move(to: CGPoint(x: radius - radius/4.0 + radius/30.0, y: 0.0))
				}
				
				linePath.addLine(to: CGPoint(x: radius - radius/4.0 + radius/15.0, y: 0.0))
				
				let transform = CGAffineTransform(rotationAngle: (CGFloat(index) + 90.0 + CGFloat(gaugeAngle))*CGFloat(Float.pi/180.0))
				decorScalesPath.addPath(linePath, transform: transform)
			}
			
			let decorShapeLayer = CAShapeLayer()
			decorShapeLayer.setAffineTransform(CGAffineTransform(translationX: center.x, y: center.y))
			decorShapeLayer.strokeColor = range.color
			decorShapeLayer.path = decorScalesPath
			decorShapeLayer.lineWidth = 2.0
			addSublayer(decorShapeLayer)
			decorRangesLayers?.append(decorShapeLayer)
			
			previosRange = value
		}
	}
	
}
