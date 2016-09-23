//
//  BIT.swift
//  Bon
//
//  Created by Chris on 16/4/17.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

public enum LoginState: String, CustomStringConvertible {
    case online = "online"
    case offline = "offline"
    
    public var description: String {
        return self.rawValue
    }
}

class BIT {
    
    struct URL {
        static let AuthActionURL = "http://10.0.0.55:801/include/auth_action.php"
        static let HelpCenter = "http://10.0.0.55:8800"
    }
}
