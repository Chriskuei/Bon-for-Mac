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
    
    /// post function
    ///
    /// - parameter parameters: JSON
    /// - parameter success:    Request success callback function
    static func post(_ parameters: [String : String]?, success: @escaping (_ value: String) -> Void) {
        
        Alamofire.request(BIT.URL.AuthActionURL, method: .post, parameters: parameters)
            .responseString{ response in
                switch response.result {
                case .success(let value):
                    success(value)
                    
                case .failure(let error):
                    print(error)
                }
        }
        
        
    }
    
    /// post function
    ///
    /// - parameter parameters: JSON
    /// - parameter success:    Request success callback function
    /// - parameter fail:       Request failure callback function
    static func post(_ parameters: [String : String]?, success: @escaping (_ value: String) -> Void, fail: @escaping (_ error : Any) -> Void) {
        
        Alamofire.request(BIT.URL.AuthActionURL, method: .post, parameters: parameters)
            .responseString{ response in
                switch response.result {
                case .success(let value):
                    success(value)
                    
                case .failure(let error):
                    fail(error: error)
                }
        }
        
        
    }
    
    
    static func logout() {
        
        let parameters = [
            "action": "auto_logout"
        ]
        BonNetwork.post(parameters as [String : String]?) { (value) in
        }
    }
    
    static func updateLoginState() {
        
        let parameters = [
            "action": "get_online_info"
        ]
        
        post(parameters as [String : String]?) { (value) in
            if(value == "not_online") {
                loginState = .offline
            } else {
                loginState = .online
            }
            
        }

    }
}
