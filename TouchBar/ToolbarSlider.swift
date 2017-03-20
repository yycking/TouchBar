//
//  ToolbarSlider.swift
//  TouchBar
//
//  Created by Wayne Yeh on 2017/3/20.
//  Copyright © 2017年 YehYungCheng. All rights reserved.
//

import Cocoa

private class ToolbarSliderCell: NSSliderCell {
	
	static var knob: NSImage = {
		let frame = NSRect(x: 0, y: 0, width: 32, height: 32)
		
		let image = NSImage(size: frame.size)
		image.lockFocus()
		
		// draw a rounded Rectangle
		let path = NSBezierPath(roundedRect: frame, xRadius: 8, yRadius: 12)
		NSColor.lightGray.set()
		path.fill()
		
		// draw edge
		NSColor.black.set()
		path.lineWidth = 2
		path.stroke()
		
		image.unlockFocus()
		return image
	}()
	
	override func drawKnob(_ knobRect: NSRect) {
		ToolbarSliderCell.knob.draw(in: knobRect.insetBy(dx: 3, dy: 6.5))
	}

}

class ToolbarSlider: NSSlider {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addBehavior()
	}

	convenience init() {
		self.init(frame: CGRect.zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addBehavior() {
		self.cell = ToolbarSliderCell()
	}
}
