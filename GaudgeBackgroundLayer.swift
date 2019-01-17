//
//  GaudgeBackgroundLayer.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 4/17/17.
//  Copyright © 2017 Dmytro Hrebeniuk. All rights reserved.
//

import QuartzCore

class GaudgeBackgroundLayer: CALayer {
	
	override func draw(in context: CGContext) {
		super.draw(in: context)
		let gradLocationsCount = 2
		let gradLocations = [0.0, 1.0] as [CGFloat]
	
		let darkColor = CGFloat(26.0/255.0)
		let gradColors = [0.25, 0.25, 0.35, 1.0, darkColor, darkColor, darkColor, 1.0] as [CGFloat]
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		
		let gradCenter = CGPoint(x: bounds.midX, y: bounds.midY)
		let gradRadius = min(bounds.size.width, bounds.size.height) / 2.0
	
		if let gradient = CGGradient(colorSpace: colorSpace, colorComponents: gradColors, locations: gradLocations, count: gradLocationsCount) {
			context.drawRadialGradient(gradient, startCenter: gradCenter, startRadius: 0.0, endCenter: gradCenter, endRadius: gradRadius, options: .drawsBeforeStartLocation)
		}
	}
}
