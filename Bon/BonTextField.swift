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
        let source = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
        let tapLocation = CGEventTapLocation.cghidEventTap
        let cmdA = CGEvent(keyboardEventSource: source, virtualKey: 0x00, keyDown: true)
        cmdA?.flags = CGEventFlags.maskCommand
        cmdA?.post(tap: tapLocation)
        return true
    }
    
}
