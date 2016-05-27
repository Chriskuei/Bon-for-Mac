//
//  BonUserDefaults.swift
//  Bon
//
//  Created by Chris on 16/4/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

var loginState: LoginState = .Offline

let usernameKey = "username"
let passwordKey = "password"
let balanceKey = "balance"
let usedDataKey = "usedData"
let secondsKey = "seconds"

class BonUserDefaults {
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    class func saveUserDefaults(username: String, password: String, uid: String) {
        
        defaults.setValue(username, forKey: usernameKey)
        defaults.setValue(password, forKey: passwordKey)
        defaults.synchronize()
        
        defaults.synchronize()
    }
    
    class func cleanAllUserDefaults() {
        
        defaults.removeObjectForKey(usernameKey)
        defaults.removeObjectForKey(passwordKey)
        
        defaults.synchronize()
    }
    
    static var username: String = {
        let savedUsername = defaults.stringForKey(usernameKey)
        if let username = savedUsername {
            return username
        } else {
            return ""
        }
        }() {
        didSet {
            defaults.setValue(username, forKey: usernameKey)
            defaults.synchronize()
        }
    }
    
    static var password: String = {
        let savedPassword = defaults.stringForKey(passwordKey)
        if let password = savedPassword {
            return password
        } else {
            return ""
        }
        }() {
        didSet {
            defaults.setValue(password, forKey: passwordKey)
            defaults.synchronize()
        }
    }
    
    static var balance: Double = {
        let balance = defaults.doubleForKey(balanceKey)
        return balance
        }() {
        didSet {
            defaults.setValue(balance, forKey: balanceKey)
            defaults.synchronize()
        }
    }
    
    static var seconds: Int = {
        let seconds = defaults.integerForKey(secondsKey)
        return seconds
        }() {
        didSet {
            defaults.setInteger(seconds, forKey: secondsKey)
            defaults.synchronize()
        }
    }
    
    static var usedData: Double = {
        let usedData = defaults.doubleForKey(usedDataKey)
        return usedData
        }() {
        didSet {
            defaults.setDouble(usedData, forKey: usedDataKey)
            defaults.synchronize()
        }
    }

}