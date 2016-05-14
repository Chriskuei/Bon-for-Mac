//
//  BonScrollView.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class BonScrollView: NSScrollView {
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        let layer = CALayer()
        layer.borderColor = NSColor.windowBackgroundColor().CGColor
        layer.borderWidth = 1
        layer.frame = NSRect(x: 0, y: dirtyRect.size.height - 1, width: dirtyRect.size.width, height: 1)
        self.layer?.addSublayer(layer)
    }
}

