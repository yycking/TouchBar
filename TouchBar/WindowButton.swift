//
//  WindowButton.swift
//  TouchBar
//
//  Created by Wayne Yeh on 2017/3/22.
//  Copyright © 2017年 YehYungCheng. All rights reserved.
//

import Cocoa

class WindowButton: NSButton {
	var enterImage: NSImage?
	var exitImage: NSImage?
	
	func drawIcon(function: ()->Swift.Void) {
		let frame = NSRect(x: 0, y: 0, width: 13, height: 13)
		
		let image = NSImage(size: frame.size)
		image.lockFocus()
		
		// draw a circle
		let path = NSBezierPath(ovalIn: frame.insetBy(dx: 0.5, dy: 0.5))
		NSColor(white: 1.0, alpha: 0.85).set()
		path.fill()
		
		function()
		
		image.unlockFocus()
		
		enterImage = image
		
		let image2 = NSImage(size: frame.size)
		image2.lockFocus()
		image.draw(in: frame, from: NSRect.zero, operation: .sourceOver, fraction: 0.741)
		image2.unlockFocus()
		
		exitImage = image2
		
		self.image = exitImage
		self.isBordered = false
		self.imagePosition = .imageOnly
		self.imageScaling = .scaleAxesIndependently
		
		let trackingArea = NSTrackingArea(rect: self.bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self, userInfo: nil)
		self.addTrackingArea(trackingArea)
	}
	
	override func mouseEntered(with event: NSEvent) {
		self.image = enterImage
	}
	
	override func mouseExited(with event: NSEvent) {
		self.image = exitImage
	}
	
}

