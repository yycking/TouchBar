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
	
	// MARK: - Touch Bar
	func setupTouchBar() {
		let window = touchBarController.window!
		let closeButton = window.standardWindowButton(.closeButton)!
		let toolbarView = closeButton.superview!
		
		closeButton.target = self
		closeButton.action = #selector(showMini)
		
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
		
		if window.contentView == touchBarView {
			let toolbarView = window.standardWindowButton(.closeButton)!.superview!
			
			let button = NSButton()
			button.image = NSImage(named: "AppIcon")
			button.isBordered = false
			button.imagePosition = .imageOnly
			button.imageScaling = .scaleAxesIndependently
			button.target = self
			button.action = #selector(showTouchBar)
			window.contentView = button
			
			var frame = window.frame
			frame.size.width = frame.size.height - toolbarView.frame.size.height
			button.frame = NSRect(origin: CGPoint.zero, size: frame.size)
			window.setFrame(frame, display: true, animate: true)
		} else {
			window.close()
		}
	}
	
	func showTouchBar() {
		let window = touchBarController.window!
		
		window.contentView = touchBarView
	}
}

