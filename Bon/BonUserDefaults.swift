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
    
    static let defaults = UserDefaults.standard
    
    class func saveUserDefaults(_ username: String, password: String, uid: String) {
        
        defaults.setValue(username, forKey: usernameKey)
        defaults.setValue(password, forKey: passwordKey)
        defaults.synchronize()
        
        defaults.synchronize()
    }
    
    class func cleanAllUserDefaults() {
        
        defaults.removeObject(forKey: usernameKey)
        defaults.removeObject(forKey: passwordKey)
        
        defaults.synchronize()
    }
    
    static var username: String = {
        let savedUsername = defaults.string(forKey: usernameKey)
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
        let savedPassword = defaults.string(forKey: passwordKey)
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
        let balance = defaults.double(forKey: balanceKey)
        return balance
        }() {
        didSet {
            defaults.setValue(balance, forKey: balanceKey)
            defaults.synchronize()
        }
    }
    
    static var seconds: Int = {
        let seconds = defaults.integer(forKey: secondsKey)
        return seconds
        }() {
        didSet {
            defaults.set(seconds, forKey: secondsKey)
            defaults.synchronize()
        }
    }
    
    static var usedData: Double = {
        let usedData = defaults.double(forKey: usedDataKey)
        return usedData
        }() {
        didSet {
            defaults.set(usedData, forKey: usedDataKey)
            defaults.synchronize()
        }
    }

}
