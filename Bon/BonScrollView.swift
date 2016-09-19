//
//  BonScrollView.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class BonScrollView: NSScrollView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let layer = CALayer()
        layer.borderColor = NSColor.windowBackgroundColor.cgColor
        layer.borderWidth = 1
        layer.frame = NSRect(x: 0, y: dirtyRect.size.height - 1, width: dirtyRect.size.width, height: 1)
        self.layer?.addSublayer(layer)
    }
}

