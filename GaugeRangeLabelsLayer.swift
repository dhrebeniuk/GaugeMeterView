//
//  GaugeRangeLabelsLayer.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 2/26/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//

import QuartzCore
import UIKit

class GaugeRangeLabelsLayer: CALayer {

	private var rangesLayers: [CALayer]?
	
	var ranges: [(value: Float, color: CGColor, title: String)]? {
		didSet {
			setupScales()
		}
	}
	
	var gaugeAngle: Float = 0.0 {
		didSet {
			setupScales()
		}
	}
	
    var gaugeArcTextColor: UIColor = UIColor.black {
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
		
		let radius = min(bounds.midX, bounds.midY)*0.95


		for index in 0..<ranges.count {
			let previosValue = index > 0 ? ranges[index-1].value : 0.0
			let range = ranges[index]
			let value = range.value;

			let layer = GaugeArcTextLayer()
			layer.font = UIFont.systemFont(ofSize: round(radius/6.5))
			layer.foregroundColor = gaugeArcTextColor
			layer.frame = bounds
			layer.string = range.title
			layer.masksToBounds = false
			layer.contentsScale = contentsScale
			let degress = 270.0 - (value + previosValue)/2.0 - gaugeAngle
			let radians = degress/180.0*Float.pi
			layer.angle = CGFloat(radians)
			
			addSublayer(layer)
			rangesLayers?.append(layer)
		}
	}
}
