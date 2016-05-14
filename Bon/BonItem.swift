//
//  BonItem.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

class BonItem {
    
    var name: String
    var info: String
    
    init(name: String, info: String) {
        self.name = name
        self.info = info
    }
    
}

extension BonItem {
    
    var nameText: String {
        return self.name == "" ? "BIT" : self.name
    }
    
    var infoText: String {
        return self.name == "" ? "BIT" : self.info
    }
    
}

extension BonItem: CustomStringConvertible {
    var description: String {
        return "{name=\(name), info=\(info)}"
    }
}
