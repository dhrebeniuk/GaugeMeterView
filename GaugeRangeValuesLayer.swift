//
//  GaugeRangeValuesLayer.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 2/27/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//

import UIKit

class GaugeRangeValuesLayer: CALayer {

	private var rangesLayers: [CALayer]?
	
	var ranges: [(value: Float, color: CGColor)]? {
		didSet {
			setupRangeValues()
		}
	}
	
	var gaugeAngle: Float = 0.0 {
		didSet {
			setupRangeValues()
		}
	}
    
    var gaugeValuesScale: Float = 1.0 {
        didSet {
            setupRangeValues()
        }
    }

    var gaugeValuesOffset: Float = 0.0 {
        didSet {
            setupRangeValues()
        }
    }
    
    var gaugeRangeValuesColor: UIColor = UIColor.white {
        didSet {
            setupRangeValues()
        }
    }
	
	func setupRangeValues() {
		if let rangeLayers = rangesLayers {
			for rangeLayer in rangeLayers {
                rangeLayer.removeFromSuperlayer()
			}
		}
		
		let radius = min(bounds.midX, bounds.midY) - 8.0

        rangesLayers = [CALayer]()
		
		let maxRangeValue = Int(ranges?.last?.value ?? 300.0)
		let labelsCount = maxRangeValue/25
		
		for index in 0..<(labelsCount+1) {
			let value = (maxRangeValue*index)/labelsCount
			
			let layer = CATextLayer()
			layer.font = CTFontCreateUIFontForLanguage(.system, radius/30.0, nil)
			layer.fontSize = radius/10.0
			layer.contentsScale = contentsScale
			layer.foregroundColor = gaugeRangeValuesColor.cgColor
			layer.frame = bounds.insetBy(dx: +radius/3.5, dy: +radius/3.5)
            layer.string = "\(Int(Float(value) / gaugeValuesScale + gaugeValuesOffset))"
            layer.alignmentMode = CATextLayerAlignmentMode.center
 
			let degress = Float(value) + gaugeAngle + 180.0
			let radians = degress/180.0*Float.pi
			
			let transform = CGAffineTransform(rotationAngle: CGFloat(radians))
			layer.setAffineTransform(transform)
			
			addSublayer(layer)
			rangesLayers?.append(layer)
		}
	}
}
