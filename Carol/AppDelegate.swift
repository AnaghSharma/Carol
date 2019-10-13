//
//  AppDelegate.swift
//  Carol
//
//  Created by Anagh Sharma on 13/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    var storyboard = NSStoryboard.init(name: "Main", bundle: nil)
    var controller = NSViewController.init()
    var popover = NSPopover.init()
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the Status Bar Item and set the content view.
        controller = storyboard.instantiateController(identifier: "PopupController")
        popover.contentViewController = controller
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        statusBar = StatusBarController.init(popover)
    }

    func applicationWillTerminate(_ aNotification: Notification)
    {
        // Insert code here to tear down your application
    }
}

