//
//  GaugeRangesLayer.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 2/26/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//

import QuartzCore

class GaugeRangesLayer: CALayer {

	private var rangesLayers: [CALayer]?
	
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
	
    var gaugleRaudioScale: Float = 0.95 {
        didSet {
            setupScales()
        }
    }
    
	private func setupScales() {
		if let rangeLayers = rangesLayers {
			for rangeLayer in rangeLayers {
				rangeLayer.removeFromSuperlayer()
			}
		}
		
        rangesLayers = [CALayer]()

        guard let ranges = ranges else {
            return
        }
		
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		let radius = min(bounds.midX, bounds.midY)*CGFloat(gaugleRaudioScale)
		let gaugeMeterOffset = CGFloat((gaugeAngle + 90.0)*Float.pi/180.0)
		
		var previosRange = Float(0.0)
		
		for range in ranges {
			let shapeLayer = CAShapeLayer()
			shapeLayer.fillColor = nil
			
			let value = range.value/180.0*Float.pi
			
			shapeLayer.lineWidth = radius/5.0
			shapeLayer.strokeColor = range.color
			
			let path = CGMutablePath()
			path.addArc(center: center, radius: radius, startAngle: gaugeMeterOffset +  CGFloat(previosRange), endAngle: gaugeMeterOffset + CGFloat(value), clockwise: false)
			
			shapeLayer.path = path
			
			addSublayer(shapeLayer)
			rangesLayers?.append(shapeLayer)
			
			previosRange = value
		}
	}
	
}
