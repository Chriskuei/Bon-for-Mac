//
//  BonNetwork.swift
//  Bon
//
//  Created by Chris on 16/4/18.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation
import Alamofire

class BonNetwork: NSObject {
    
    /**
     *   post function
     *   parameters: JSON
     *   success: Request success callback function
     */
    
    static func post(parameters: [String : AnyObject]?, success: (value: String) -> Void) {
        
        Alamofire.request(.POST, BIT.URL.AuthActionURL, parameters: parameters)
            .responseString{ response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    print(error)
                }
        }
        
        
    }

    /**
     *   post function
     *   parameters: JSON
     *   success: Request success callback function
     *   fail: Request fail callback function
     */
    
    static func post(parameters: [String : AnyObject]?, success: (value: String) -> Void, fail: (error : Any) -> Void) {
        
        Alamofire.request(.POST, BIT.URL.AuthActionURL, parameters: parameters)
            .responseString{ response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    fail(error: error)
                }
        }
        
        
    }
    
    
    static func logout() {
        
        let parameters = [
            "action": "auto_logout"
        ]
        BonNetwork.post(parameters) { (value) in
        }
    }
    
    static func updateLoginState() {
        
        let parameters = [
            "action": "get_online_info"
        ]
        
        post(parameters) { (value) in
            if(value == "not_online") {
                loginState = .Offline
            } else {
                loginState = .Online
            }
            
        }

    }
}