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
        return NSColor(calibratedRed: 148 / 255.0, green: 141 / 255.0, blue: 157 / 255.0, alpha: 1.0)
    }
    
    class func bonWhiteColor() -> NSColor {
        return NSColor.white
    }
    
    class func bonHighlightColor() -> NSColor {
        return NSColor(calibratedRed: 249 / 255.0, green: 249 / 255.0, blue: 249 / 255.0, alpha: 1.0)
    }
    
    class func bonOrangeColor() -> NSColor {
        return NSColor(calibratedRed: 228 / 255.0, green: 81 / 255.0, blue: 39 / 255.0, alpha: 1.0)
    }
    
    class func bonGrayColor() -> NSColor {
        return NSColor(calibratedRed: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.0)
    }
    
    class func bonLightGrayColor() -> NSColor {
        return NSColor(calibratedRed: 204 / 255.0, green: 204 / 255.0, blue: 208 / 255.0, alpha: 1.0)
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
        
        return white > 0.92 ? NSColor.black : NSColor.white
    }

}
