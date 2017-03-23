//
//  AppDelegate.swift
//  TouchBar
//
//  Created by YehYungCheng on 2017/3/18.
//  Copyright © 2017年 YehYungCheng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    @IBOutlet weak var miniWindow: NSWindow!
	var touchBarView: NSView!
	var touchBarController = IDETouchBarSimulatorHostWindowController.simulatorHostWindowController()!

	// MARK: - NSApplicationDelegate

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
		
		// setup: touch bar
        setupTouchBar()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
	
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
	
	// MARK: - NSWindowDelegate
	
//	func windowShouldClose(_ sender: Any) -> Bool {
//		return true
//	}
	
	// MARK: - Touch Bar
	func setupTouchBar() {
		let window = touchBarController.window!
		let closeButton = window.standardWindowButton(.closeButton)!
		let toolbarView = closeButton.superview!
		
		window.delegate = self
		
		let button = WindowButton(title: "x", target: self, action: #selector(showMini))
		button.frame = NSRect(x: 21, y: 3, width: 13, height: 13)
		button.drawIcon {
			let path = NSBezierPath(rect: NSRect(x: 2.25, y: 5.75, width: 8, height: 2))
			NSColor.black.setFill()
			path.fill()
		}
		toolbarView.addSubview(button)
		
		let slider = ToolbarSlider()
		slider.frame = CGRect(x: toolbarView.frame.width - 120, y: 4, width: 120, height: 11)
		slider.action = #selector(setTransparency)
		toolbarView.addSubview(slider)
		
		var transparency = UserDefaults.standard.double(forKey: "TransparencySlider")
		if transparency == 0 {
			transparency = 0.75
		}
		slider.minValue = 0.5
		slider.doubleValue = transparency
		window.alphaValue = CGFloat(slider.doubleValue)
		
		touchBarView = window.contentView
	}
	
	// MARK: - TransparencySlider
	
	func setTransparency(sender : NSSlider) {
		touchBarController.window!.alphaValue = CGFloat(sender.doubleValue)
		UserDefaults.standard.set(sender.doubleValue, forKey: "TransparencySlider")
	}
	
	func showMini() {
		let window = touchBarController.window!
		window.titleVisibility = .hidden
		window.titlebarAppearsTransparent = true
		
		let toolbarView = window.standardWindowButton(.closeButton)!.superview!
		toolbarView.isHidden = true
		
		var frame = window.frame
		frame.size.width = frame.size.height
		window.contentView = NSView(frame: NSRect(origin: CGPoint.zero, size: frame.size))
		window.setFrame(frame, display: true, animate: true)
		
		let button = NSButton()
		button.image = NSImage(named: "AppIcon")
		button.isBordered = false
		button.imagePosition = .imageOnly
		button.imageScaling = .scaleAxesIndependently
		button.target = self
		button.action = #selector(showTouchBar)
		window.contentView = button
		button.frame = NSRect(origin: CGPoint.zero, size: frame.size)
	}
	
	func showTouchBar() {
		let window = touchBarController.window!
		let toolbarView = window.standardWindowButton(.closeButton)!.superview!
		
		toolbarView.isHidden = false
		window.contentView = touchBarView
	}
}

