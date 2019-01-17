//
//  GaugeMeterView.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 2/21/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//

import UIKit

public class GaugeMeterView: UIView {

	private var backgroudLayer: GaudgeBackgroundLayer?
	private var rangesLayer: GaugeRangesLayer?
	private var rangeLabelsLayer: GaugeRangeLabelsLayer?
	private var decorRangesLayer: GaugeDecorRangesLayer?
	private var rangeValuesLayer: GaugeRangeValuesLayer?
	private var arrowLayer: GaugeArrowLayer?
	
	public var ranges: [(value: Float, color: UIColor, title: String)]? {
		didSet {
			updateUI()
		}
	}
	
	public var gaugeAngle: Float = 0.0 {
		didSet {
			updateUI()
		}
	}
	
	public var value: Float = 0.0 {
		didSet {
			arrowLayer?.value = value
		}
	}
    
    public var gaugeValuesScale: Float = 1.0 {
        didSet {
            updateUI()
        }
    }
    
    public var gaugeArcTextColor: UIColor = UIColor.black {
        didSet {
            updateUI()
        }
    }
    
    public var gaugeRangeValuesColor: UIColor = UIColor.white {
        didSet {
            updateUI()
        }
    }
    
    override public func layoutSubviews() {
		super.layoutSubviews()
		
		updateUI()
	}
	
	private func updateUI() {
		backgroudLayer?.removeFromSuperlayer()
		backgroudLayer = GaudgeBackgroundLayer()
		backgroudLayer?.frame = layer.bounds
        backgroudLayer.map { layer.addSublayer($0) }
		backgroudLayer?.setNeedsLayout()
        
		setupArrow()
		
		setupScales()
	}
	
	private func setupScales() {
		var layerRanges = [(value: Float, color: CGColor)]()
		if let ranges = ranges {
			for range in ranges {
				layerRanges.append((value: range.value, color: range.color.cgColor))
			}
		}
		
		rangesLayer?.removeFromSuperlayer()
		rangesLayer = GaugeRangesLayer()
		rangesLayer?.frame = layer.bounds
		rangesLayer?.ranges = layerRanges
		rangesLayer?.gaugeAngle = gaugeAngle
        rangesLayer.map { layer.addSublayer($0) }
		
		decorRangesLayer?.removeFromSuperlayer()
		decorRangesLayer = GaugeDecorRangesLayer()
		decorRangesLayer?.frame = layer.bounds
		decorRangesLayer?.gaugeAngle = gaugeAngle
		decorRangesLayer?.ranges = layerRanges
        decorRangesLayer.map { layer.addSublayer($0) }
        
		rangeValuesLayer?.removeFromSuperlayer()
		rangeValuesLayer = GaugeRangeValuesLayer()
		rangeValuesLayer?.frame = layer.bounds
		rangeValuesLayer?.contentsScale = UIScreen.main.scale
		rangeValuesLayer?.gaugeAngle = gaugeAngle
		rangeValuesLayer?.setupRangeValues()
        rangeValuesLayer?.gaugeValuesScale = gaugeValuesScale
        rangeValuesLayer?.gaugeRangeValuesColor = gaugeRangeValuesColor
        rangeValuesLayer.map { layer.addSublayer($0) }
        
		var layerLabelRanges = [(value: Float, color: CGColor, title: String)]()
		if let ranges = ranges {
			for range in ranges {
				layerLabelRanges.append((value: range.value, color: range.color.cgColor, title: range.title))
			}
		}
		
		rangeLabelsLayer?.removeFromSuperlayer()
		rangeLabelsLayer = GaugeRangeLabelsLayer()
		rangeLabelsLayer?.frame = layer.bounds
		rangeLabelsLayer?.masksToBounds = false
		rangeLabelsLayer?.contentsScale = UIScreen.main.scale
		rangeLabelsLayer?.gaugeAngle = gaugeAngle
		rangeLabelsLayer?.ranges = layerLabelRanges
        rangeLabelsLayer?.gaugeArcTextColor = gaugeArcTextColor
        rangeLabelsLayer.map { layer.addSublayer($0) }
	}
	
	private func setupArrow() {
		arrowLayer?.removeFromSuperlayer()
		arrowLayer = GaugeArrowLayer()
		arrowLayer?.frame = layer.bounds
		arrowLayer?.gaugeAngle = gaugeAngle
		arrowLayer?.setupArrow()
        arrowLayer.map { layer.addSublayer($0) }
	}
}
