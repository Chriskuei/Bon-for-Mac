//
//  NSColor+Bon.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

extension NSColor {
    class func bonTintColor() -> NSColor {
        return NSColor(red: 148/255.0, green: 141/255.0, blue: 157/255.0, alpha: 1.0)
    }
    
    // Inverse color
    var bon_inverseColor: NSColor {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return NSColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: alpha)
    }
    
    // Binary color
    var bon_binaryColor: NSColor {
        
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        
        return white > 0.92 ? NSColor.blackColor() : NSColor.whiteColor()
    }

}