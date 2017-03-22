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
	var touchBarController = IDETouchBarSimulatorHostWindowController.simulatorHostWindowController()!

	// MARK: - NSApplicationDelegate

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
		
		// setup: touch bar
        setupTouchBar()
		
		// setup: mini bar
		miniWindow.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
		miniWindow.level = Int(CGWindowLevelForKey(.statusWindow))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		if let window = touchBarController.window, window.isVisible {
			return false
		}
		if miniWindow.isVisible {
			return false
		}
        return true
    }
	
	// MARK: - NSWindowDelegate
	
	// MARK: - Touch Bar
	func setupTouchBar() {
		guard
			let window = touchBarController.window,
			let closeButton = window.standardWindowButton(.closeButton),
			let toolbarView = closeButton.superview
			else { return }
		
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
	}
	
	@IBAction func showTouchBar(_ sender: NSButton) {
		guard
			let window = touchBarController.window
			else { return }
		
		window.setFrameOrigin(miniWindow.frame.origin)
		window.setIsVisible(true)
		miniWindow.setIsVisible(false)
	}
	
	// MARK: - TransparencySlider
	
	func setTransparency(sender : NSSlider) {
		guard let window = touchBarController.window else { return }
		
		window.alphaValue = CGFloat(sender.doubleValue)
		UserDefaults.standard.set(sender.doubleValue, forKey: "TransparencySlider")
	}
	
	func showMini() {
		guard
			let window = touchBarController.window
			else { return }
		
		window.setIsVisible(false)
		miniWindow.setIsVisible(true)
		miniWindow.setFrameOrigin(window.frame.origin)
	}
}

