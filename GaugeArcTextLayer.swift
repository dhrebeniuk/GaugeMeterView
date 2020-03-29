//
//  GaugeArcTextLayer.swift
//  GaugeMeter
//
//  Created by Dmytro Hrebeniuk on 3/18/18.
//  Copyright © 2018 Dmytro Hrebeniuk. All rights reserved.
//

import QuartzCore
import CoreText
import UIKit

class GaugeArcTextLayer: CALayer {

	var angle: CGFloat = 0.0 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var foregroundColor: UIColor?
	var font: UIFont?
	var string: String?
	
	override func draw(in context: CGContext) {
		context.saveGState()

        string.map {
            centreArcPerpendicularText(string: String($0.reversed()), context: context, radius: bounds.width / 2.1, angle: angle)
        }
		context.restoreGState()
	}
	
	func centreArcPerpendicularText(string: String, context: CGContext, radius: CGFloat, angle theta: CGFloat) {
		
		var characters = [String]()
		var arcs = [CGFloat]()
		var totalArc = CGFloat(0.0)
		
		for index in 0 ..< string.count {
			let stringCharacter = String(string[string.index(string.startIndex, offsetBy: index)])
			let width = stringCharacter.size(withAttributes: textAttributes).width
			characters.append(stringCharacter)
			
			arcs += [chordToArc(chord: width, radius: radius)]
			totalArc += arcs[index]
		}
		
		let slantCorrection = CGFloat(.pi/2.0)
		var totalTheta = theta - totalArc / 2
		
		for index in 0 ..< string.count {
			totalTheta += arcs[index] / 2
			centreText(string: characters[index], context: context, radius: radius, angle: totalTheta, slantAngle: totalTheta + slantCorrection)
			totalTheta += arcs[index] / 2
		}
	}
	
	func chordToArc(chord: CGFloat, radius: CGFloat) -> CGFloat {
		return 2.0 * asin(chord / (2.0 * radius))
	}
	
    var textAttributes: [NSAttributedString.Key: Any] {
		let color = foregroundColor ?? UIColor.black
        var attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
		font.map() {
			attributes[.font] = $0
		}
		
		return attributes
	}
	
	func centreText(string: String, context: CGContext, radius r:CGFloat, angle theta: CGFloat, slantAngle: CGFloat) {

		context.saveGState()
		
		let textSize = string.size(withAttributes: textAttributes)
		context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
		context.translateBy(x: bounds.width/2, y: bounds.height/2)

		let attrString = NSAttributedString(string: string, attributes: textAttributes)
		
        context.rotate(by: -slantAngle - .pi)

		context.translateBy(x: -textSize.width/2.0, y: -textSize.height/2.0)

        UIGraphicsPushContext(context)
        
        attrString.draw(at: .zero)
        
        UIGraphicsPopContext()
		
		context.restoreGState()
	}
	
}
