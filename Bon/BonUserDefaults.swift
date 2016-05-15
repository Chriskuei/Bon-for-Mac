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

//Get balance success with string: {
//    "buy_mbytes" = "0.00";
//    "buy_minutes" = "<null>";
//    charge = "10.00";
//    client = WEB;
//    fid = 1304;
//    "flux_long" = "9.50G";
//    "flux_long1" = B;
//    "flux_long6" = B;
//    "free_in_bytes" = 1B;
//    "free_out_bytes" = 0B;
//    ipv = 4;
//    limit = 0;
//    "month_fee" = "10.00";
//    "remain_fee" = "1.53";
//    "remain_flux" = "2,030.82M";
//    "remain_timelong" = "<null>";
//    speed = 0;
//    "time_long" = 0;
//    "time_long1" = 0;
//    "time_long6" = 0;
//    uid = 44064;
//    "user_balance" = "11.53";
//    "user_in_bytes" = "22.98KB";
//    "user_ip" = "10.194.182.53";
//    "user_login_name" = 1120141755;
//    "user_login_time" = "2016-04-19 18:27:22";
//    "user_out_bytes" = "25.10KB";
//}

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