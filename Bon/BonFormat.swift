//
//  BonFormat.swift
//  Bon
//
//  Created by Chris on 16/5/15.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

class BonFormat {
    
    class func formatTime(_ seconds: Int) -> String {
        
        let hour = String(format: "%02d", seconds / 3600)
        let minute = String(format: "%02d", (seconds % 3600) / 60)
        let second = String(format: "%02d", seconds % 3600 % 60)
        
        let usedTime = hour + ":" + minute + ":" + second
        return usedTime
    }
    
    class func formatData(_ byte: Double) -> String {
        if byte > 1024 * 1024 * 1024 {
            let gigabyte = String(format: "%.2f", byte.byteToGigabyte()) + "G"
            return gigabyte
        }
        if byte > 1024 * 1024 {
            let megabyte = String(format: "%.2f", byte.byteToMegabyte()) + "M"
            return megabyte
        } else if byte > 1024 {
            let kilobyte = String(format: "%.2f", byte.byteToKilobyte()) + "K"
            return kilobyte
        } else {
            let byte = String(format: "%.2f", byte) + "b"
            return byte
        }
    }
    
    class func formatOnlineInfo(_ info: [String]) -> [String] {
        
        let usernameInfo = info[4]
        let usedData = Double(info[0])!
        let usedDataInfo = BonFormat.formatData(usedData)
        
    
        let seconds = Int(info[1])!
        let usedTimeInfo = BonFormat.formatTime(seconds)
        
        let balance = Double(info[2])!
        let balanceInfo = String(format: "%.2f", balance) + "G"
        
        let dailyAvailableData = getDailyAvailableData(balance, usedData: usedData)
        let dailyAvailableDataInfo = BonFormat.formatData(dailyAvailableData)
        //            let userInformation: [String: String] = {
        //                var dict = Dictionary<String, String>()
        //                for index in 0...7 {
        //                    dict[key[index]] = info[index]
        //                }
        //                return dict
        //            }()
        
        var itemsInfo = [String]()
        itemsInfo.append(usernameInfo)
        itemsInfo.append(usedDataInfo)
        itemsInfo.append(usedTimeInfo)
        itemsInfo.append(balanceInfo)
        itemsInfo.append(dailyAvailableDataInfo)
        
        return itemsInfo
    }
    
    class func getRemainingDaysOfCurrentMonth() -> Double {
        
        var date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        
        let year =  components.year
        let month = components.month
        
        let day = components.day
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        date = calendar.date(from: dateComponents)!
        
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: date)
        let numDays = range.length
        
        let remainingDaysOfCurrentMonth = numDays - day!
        return Double(remainingDaysOfCurrentMonth)
    }
    
    class func getDailyAvailableData(_ balance: Double, usedData: Double) -> Double {
        
        let remainingDaysOfCurrentMonth = getRemainingDaysOfCurrentMonth()
        
        let availableData = balance.gigabyteToByte() - usedData
        
        let dailyAvailableData = availableData / remainingDaysOfCurrentMonth
        
        return dailyAvailableData > 0 ? dailyAvailableData : 0
    }
    
}
