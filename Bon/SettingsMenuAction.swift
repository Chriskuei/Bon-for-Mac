//
//  SettingsMenuAction.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa
import Foundation

class SettingsMenuAction {
    
    class func makeSettingsMenu(sender: NSView) {
        let delegate = NSApplication.sharedApplication().delegate as! MainViewController
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Logout", action: #selector(BonNetwork.logout), keyEquivalent: "l"))
        menu.addItem(NSMenuItem(title: "Github", action: #selector(delegate.openGithub), keyEquivalent: "g"))
        menu.addItem(NSMenuItem(title: "Weibo", action: #selector(delegate.openWeibo), keyEquivalent: "b"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(delegate.quit), keyEquivalent: "q"))
        
        NSMenu.popUpContextMenu(menu, withEvent: NSApp.currentEvent!, forView: sender)
    }
    
}
