//
//  MainViewController.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    var refreshTimer: Timer?
    
    override func awakeFromNib() {
        if let button = statusItem.button {
            let icon = NSImage(named: "icon_status")
            icon?.isTemplate = false
            button.image = icon
            button.action = #selector(self.togglePopover(_:))
        }

        popover.behavior = .transient
        popover.contentViewController = BonViewController(nibName: "BonViewController", bundle: nil)
        popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
        popover.behavior = .transient
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
        
        refreshTimer = Timer.every(3.minutes) {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: BonConfig.BonNotification.GetOnlineInfo), object: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        
        eventMonitor?.start()
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func openGithub() {
        let path = "https://github.com/Chriskuei"
        let url = URL(string: path)!
        NSWorkspace.shared().open(url)
    }
    
    func openWeibo() {
        let path = "https://weibo.com/chenjiangui"
        let url = URL(string: path)!
        NSWorkspace.shared().open(url)
    }
    
    func quit() {
        NSApplication.shared().terminate(self)
    }

}
