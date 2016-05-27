//
//  BonCell.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class BonCell: NSTableCellView {
    
    @IBOutlet weak var typeImageView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var infoLabel: NSTextField!
    @IBOutlet weak var circleView: NSView!
    
    private let squareWithCircleView: SquareWithCircleView = SquareWithCircleView(frame: CGRectZero)
    
    private var item: BonItem?
    
    private let cursor = NSCursor.pointingHandCursor()
    private var trackingArea: NSTrackingArea?
    private var mouseInside = false {
        didSet {
            updateUI()
        }
    }
    
    class func view(tableView: NSTableView, owner: AnyObject?, subject: AnyObject?) -> NSView {
        let view = tableView.makeViewWithIdentifier("BonCell", owner: owner) as! BonCell
        
        if let item = subject as? BonItem {
            view.setItem(item)
        }
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        wantsLayer = true
        
        typeImageView.wantsLayer = true
        typeImageView.layer?.masksToBounds = true
        typeImageView.layer?.cornerRadius = 3
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackingArea = nil
        mouseInside = false
    }
    
    override func resetCursorRects() {
        addCursorRect(bounds, cursor: cursor)
        cursor.set()
    }
    
    private func setItem(item: BonItem?) {
        guard let item = item else {
            return
        }
        
        self.item = item
        
        updateUI()
    }
    
    private func updateUI() {
        guard let item = item else {
            return
        }
        
        layer?.backgroundColor = mouseInside ? NSColor.bonHighlightColor().CGColor : NSColor.bonWhiteColor().CGColor
        
        nameLabel.stringValue = item.nameText
        infoLabel.stringValue = item.infoText
        //circleView.layer?.backgroundColor = NSColor.bonTintColor().CGColor
        
        circleView.addSubview(squareWithCircleView)
        squareWithCircleView.frame = circleView.bounds
        //squareWithCircleView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        //typeImageView.image = NSImage(named: item.imageType)
    }
    
    private func createTrackingAreaIfNeeded() {
        if trackingArea == nil {
            trackingArea = NSTrackingArea(rect: CGRect.zero, options: [NSTrackingAreaOptions.InVisibleRect, NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveAlways], owner: self, userInfo: nil)
        }
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        createTrackingAreaIfNeeded()
        
        if !trackingAreas.contains(trackingArea!) {
            addTrackingArea(trackingArea!)
        }
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        mouseInside = true
    }
    
    override func mouseExited(theEvent: NSEvent) {
        mouseInside = false
    }
}

class SquareWithCircleView: NSView{
    override func drawRect(dirtyRect: NSRect)
    {
        let circleFillColor = NSColor.bonTintColor()
        let circleRect = NSMakeRect(dirtyRect.size.width/4, dirtyRect.size.height/4, dirtyRect.size.width/2, dirtyRect.size.height/2)
        let cPath: NSBezierPath = NSBezierPath(ovalInRect: circleRect)
        circleFillColor.set()
        cPath.fill()
    }
}