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
    //@IBOutlet weak var circleView: NSView!
    
    fileprivate let squareWithCircleView: SquareWithCircleView = SquareWithCircleView(frame: CGRect.zero)
    
    fileprivate var item: BonItem?
    
    fileprivate let cursor = NSCursor.pointingHand
    fileprivate var trackingArea: NSTrackingArea?
    fileprivate var mouseInside = false {
        didSet {
            updateUI()
        }
    }
    
    class func view(_ tableView: NSTableView, owner: AnyObject?, subject: AnyObject?) -> NSView {
        let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BonCell"), owner: owner) as! BonCell
        
        if let item = subject as? BonItem {
            view.setItem(item)
        }
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    fileprivate func commonInit() {
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
    
    fileprivate func setItem(_ item: BonItem?) {
        guard let item = item else {
            return
        }
        
        self.item = item
        
        updateUI()
    }
    
    fileprivate func updateUI() {
        guard let item = item else {
            return
        }
        
        layer?.backgroundColor = mouseInside ? NSColor.bonHighlight().cgColor : NSColor.bonWhite().cgColor
        
        nameLabel.stringValue = item.nameText
        infoLabel.stringValue = item.infoText
        //circleView.layer?.backgroundColor = NSColor.bonTintColor().CGColor
        
        //circleView.addSubview(squareWithCircleView)
        //squareWithCircleView.frame = circleView.bounds
        //squareWithCircleView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        //typeImageView.image = NSImage(named: item.imageType)
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
        mouseInside = true
    }
    
    override func mouseExited(with theEvent: NSEvent) {
        mouseInside = false
    }
}

class SquareWithCircleView: NSView{
    override func draw(_ dirtyRect: NSRect)
    {
        let circleFillColor = NSColor.bonTint()
        let circleRect = NSMakeRect(dirtyRect.size.width/4, dirtyRect.size.height/4, dirtyRect.size.width/2, dirtyRect.size.height/2)
        let path: NSBezierPath = NSBezierPath(ovalIn: circleRect)
        circleFillColor.set()
        path.fill()
    }
}
