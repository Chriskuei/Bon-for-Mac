//
//  BonButton.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class BonButton: NSButton {
    
    fileprivate let cursor = NSCursor.pointingHand
    fileprivate var normalStateImage: NSImage?
    fileprivate var highlightedStateImage: NSImage?
    fileprivate var trackingArea: NSTrackingArea?
    
    override func resetCursorRects() {
        addCursorRect(bounds, cursor: cursor)
        cursor.set()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
    }
    
    func setImages(_ normalImage: String, highlitedImage: String) {
        self.setButtonType(.momentaryChange)
        
        normalStateImage = NSImage(named: NSImage.Name(rawValue: normalImage))
        highlightedStateImage = NSImage(named: NSImage.Name(rawValue: highlitedImage))
    }
    
    func resetTrackingArea() {
        trackingArea = nil
        
        if let normalStateImage = normalStateImage {
            image = normalStateImage
        }
    }
    
    fileprivate func createTrackingAreaIfNeeded() {
        if trackingArea == nil {
            trackingArea = NSTrackingArea(rect: CGRect.zero, options: [NSTrackingArea.Options.inVisibleRect, NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        }
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        createTrackingAreaIfNeeded()
        
        if !trackingAreas.contains(trackingArea!) {
            addTrackingArea(trackingArea!)
        }
    }
    
    override func mouseEntered(with theEvent: NSEvent) {
        if let highlightedImage = highlightedStateImage {
            image = highlightedImage
        }
    }
    
    override func mouseExited(with theEvent: NSEvent) {
        if let normalStateImage = normalStateImage {
            image = normalStateImage
        }
    }
}
