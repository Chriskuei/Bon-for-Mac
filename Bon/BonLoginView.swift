//
//  BonLoginView.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

enum LogMessage {
    case Loading
    case UsernameError
    case PasswordError
    case Timeout
    case Error
    case LoginSuccess
    case LogoutSuccess
}

class BonLoginView: NSView {
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    @IBOutlet weak var alertLabel: NSTextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadingIndicator.hidden = true
        alertLabel.hidden = true
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    func show(logMessage: LogMessage) {
        
        switch logMessage {
        case .Loading:
            hidden = false
            loadingIndicator.hidden = false
            loadingIndicator.startAnimation(nil)
            
        case .UsernameError:
            hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.hidden = false
            alertLabel.stringValue = "User not found."
            delay(2) {
                self.alertLabel.hidden = true;
            }
            
        case .PasswordError:
            hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.hidden = false
            alertLabel.stringValue = "Password is incorrect."
            delay(2) {
                self.alertLabel.hidden = true;
            }
            
        case .Timeout:
            hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.hidden = false
            alertLabel.stringValue = "Time out."
            delay(2) {
                self.alertLabel.hidden = true;
            }

            
        case .Error:
            hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.hidden = false
            alertLabel.stringValue = "Login error."
            delay(2) {
                self.alertLabel.hidden = true;
            }
            
        case .LoginSuccess:
            hidden = true
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            
        case .LogoutSuccess:
            hidden = false
            loadingIndicator.hidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.hidden = false
            alertLabel.stringValue = "Logout ok."
            delay(2) {
                self.alertLabel.hidden = true;
            }
        }
    }
    
}
