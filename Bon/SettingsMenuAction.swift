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
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(delegate.quit), keyEquivalent: "q"))
        
        NSMenu.popUpContextMenu(menu, withEvent: NSApp.currentEvent!, forView: sender)
    }
    
}
