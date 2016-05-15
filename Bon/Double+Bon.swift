//
//  Double+Bon.swift
//  Bon
//
//  Created by Chris on 16/5/7.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

extension Double {
    
    func byteToKilobyte() -> Double {
        return self / (1024)
    }

    func byteToMegabyte() -> Double {
        return self / (1024 * 1024)
    }
    
    func byteToGigabyte() -> Double {
        return self / (1024 * 1024 * 1024)
    }
    
    func gigabyteToByte() -> Double {
        return self * (1024 * 1024 * 1024)
    }
    
}