//
//  BonLoginView.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

enum LogMessage {
    case loading
    case usernameError
    case passwordError
    case inArrearsError
    case timeout
    case error
    case loginSuccess
    case logoutSuccess
}

class BonLoginView: NSView {
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    @IBOutlet weak var alertLabel: NSTextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadingIndicator.isHidden = true
        alertLabel.isHidden = true
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
    }
    
    func show(_ logMessage: LogMessage) {
        
        switch logMessage {
        case .loading:
            isHidden = false
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimation(nil)
            
        case .usernameError:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "User not found."
            delay(2) {
                self.alertLabel.isHidden = true;
            }
            
        case .passwordError:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "Password is incorrect."
            delay(2) {
                self.alertLabel.isHidden = true;
            }
            
        case .inArrearsError:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "You are in arrears."
            delay(2) {
                self.alertLabel.isHidden = true;
            }
            
        case .timeout:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "Time out."
            delay(2) {
                self.alertLabel.isHidden = true;
            }

            
        case .error:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "Login error."
            delay(2) {
                self.alertLabel.isHidden = true;
            }
            
        case .loginSuccess:
            isHidden = true
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            
        case .logoutSuccess:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "Logout ok."
            delay(2) {
                self.alertLabel.isHidden = true;
            }
        }
    }
    
    func showLoginState(_ loginState: LoginState) {
        switch loginState {
        case .Online:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "You are online now."
            delay(2) {
                self.alertLabel.isHidden = true;
            }
        case .Offline:
            isHidden = false
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimation(nil)
            alertLabel.isHidden = false
            alertLabel.stringValue = "You are offline."
            delay(2) {
                self.alertLabel.isHidden = true;
            }
        }
        
    }
    
}
