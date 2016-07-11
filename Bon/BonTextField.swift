//
//  BonTextField.swift
//  Bon
//
//  Created by Chris on 16/7/11.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class BonTextField: NSTextField {
    
    override func becomeFirstResponder() -> Bool {
        let source = CGEventSourceCreate(CGEventSourceStateID.HIDSystemState)
        let tapLocation = CGEventTapLocation.CGHIDEventTap
        let cmdA = CGEventCreateKeyboardEvent(source, 0x00, true)
        CGEventSetFlags(cmdA, CGEventFlags.MaskCommand)
        CGEventPost(tapLocation, cmdA)
        return true
    }
    
}