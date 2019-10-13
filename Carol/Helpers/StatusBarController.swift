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
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        statusBarButton = statusItem.button!
        self.popover = popover
        
        // For testing purpose
        statusBarButton.title = "Carol"
        
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
