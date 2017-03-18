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

    @IBOutlet weak var window: NSWindow!
    let controller = IDETouchBarSimulatorHostWindowController.simulatorHostWindowController()!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        controller.window?.delegate = self
        
        addTransparencySlider()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func addTransparencySlider() {
        let toolbarView = controller.window!.standardWindowButton(.closeButton)!.superview!
        let slider = NSSlider()
        slider.frame = CGRect(x: toolbarView.frame.width - 120, y: 4, width: 120, height: 11)
        slider.action = #selector(settTransparency(sender:))
        toolbarView.addSubview(slider)
        
        var transparency = UserDefaults.standard.double(forKey: "TransparencySlider")
        if transparency == 0 {
            transparency = 0.75
        }
        slider.minValue = 0.5
        slider.doubleValue = transparency
        controller.window!.alphaValue = CGFloat(slider.doubleValue)
    }
    
    func settTransparency(sender : NSSlider) {
        controller.window!.alphaValue = CGFloat(sender.doubleValue)
        UserDefaults.standard.set(sender.doubleValue, forKey: "TransparencySlider")
    }
}

