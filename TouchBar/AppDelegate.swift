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
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

