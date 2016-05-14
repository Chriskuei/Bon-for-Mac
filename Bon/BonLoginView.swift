//
//  BonLoginView.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

enum LoginState {
    case usernameError, passwordError, Success, Error
}

class BonLoginView: NSView {
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var loadingIndicator: NSProgressIndicator! // 进度圈
    @IBOutlet weak var alertLabel: NSTextField! // 提示信息
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    func showState(loginState: LoginState) {
        switch loginState {
        case .usernameError:
            hidden = false
            loadingIndicator.hidden = false
            loadingIndicator.startAnimation(nil)
            alertLabel.stringValue = "客官，请稍等..."
            //currentState = .Loading
            
        case .passwordError:
            hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.stringValue = "客官，出错啦!!!"
            //currentState = .Error
            
        case .Error:
            hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.stringValue = "客官，没货啦..."
            //currentState = .Empty
            
        case .Success:
            hidden = true
            loadingIndicator.stopAnimation(nil)
            //currentState = .Idle
        }
    }
    
}
