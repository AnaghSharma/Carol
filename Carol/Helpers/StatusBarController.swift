//
//  StatusBarController.swift
//  Carol
//
//  Created by Anagh Sharma on 13/10/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import AppKit

class StatusBarController
{
    var statusBar: NSStatusBar
    var statusItem: NSStatusItem
    var popover: NSPopover
    var statusBarButton: NSStatusBarButton
    
    init(_ popover: NSPopover)
    {
        statusBar = NSStatusBar.init()
        statusItem = statusBar.statusItem(withLength: 28.0)
        statusBarButton = statusItem.button!
        self.popover = popover
        
        statusBarButton.image = #imageLiteral(resourceName: "StatusBarIcon")
        statusBarButton.image?.size = NSSize(width: 24.0, height: 20.0)
        statusBarButton.image?.isTemplate = true
        
        statusBarButton.action = #selector(togglePopover(sender:))
        statusBarButton.target = self
    }
    
    @objc func togglePopover(sender: AnyObject)
    {
        if(popover.isShown)
        {
            hidePopover(sender)
        }
        else
        {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject)
    {
        popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
    }
    
    func hidePopover(_ sender: AnyObject)
    {
        popover.performClose(sender)
    }
}
