//
//  MainViewController.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

import Cocoa

class MainViewController: NSViewController {
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    override func awakeFromNib() {
        if let button = statusItem.button {
            let icon = NSImage(named: "icon_status")
            //icon?.template = false
            button.image = icon
            button.action = #selector(self.togglePopover(_:))
        }

        popover.behavior = .Transient
        popover.contentViewController = BonViewController(nibName: "BonViewController", bundle: nil)
        popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
        popover.behavior = .Transient
        
        eventMonitor = EventMonitor(mask: [.LeftMouseDownMask, .RightMouseDownMask]) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("Reload", object: nil)
        
        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func quit() {
        NSApplication.sharedApplication().terminate(self)
    }
}
