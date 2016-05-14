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
    
    var alamoFireManager = Alamofire.Manager.sharedInstance
    
//    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//    configuration.timeoutIntervalForRequest = 4 // seconds
//    configuration.timeoutIntervalForResource = 4
//    self.alamoFireManager = Alamofire.Manager(configuration: configuration)
    //    let center = NSNotificationCenter.defaultCenter()
    //    var alamoFireManager : Alamofire.Manager?
    //
    //    var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    //    //configuration.timeoutIntervalForRequest = 4 // seconds
    //    configuration.timeoutIntervalForResource = 4
    //    self.alamoFireManager = Alamofire.Manager(configuration: configuration)
    
    //    var alamofireManager : Manager?
    //    // 设置请求的超时时间
    //    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    //    config.timeoutIntervalForRequest = 5    // 秒
    //    self.alamofireManager = Manager(configuration: config)
    
    /**
     *   login function
     *   url : url
     *   params : JSON
     *   success : Request success callback function
     */
    
    static func post(parameters: [String : AnyObject]?, success: (value: String) -> Void) {
        
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
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

    
    static func post(parameters: [String : AnyObject]?, success: (value: String) -> Void, fail: (error : Any) -> Void) {
        
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
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
    
    
    /**
     *   login function
     *   url : url
     *   params : JSON
     *   success : Request success callback function
     */
    
    static func login(parameters: [String : AnyObject]?, success: (value: String) -> Void) {
        
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.POST, BIT.URL.DoLoginURL, parameters: parameters)
            .responseString{ response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
        
        
    }
    
    
    /**
     *   keepLive function
     *   parameters : JSON
     *   success : Request success callback function
     */
    
    static func keepLive(parameters: [String : AnyObject]?, success: (value: String) -> Void) {
        
        Alamofire.request(.POST, BIT.URL.KeepLiveURL, parameters: parameters)
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        }
        
    }
    
    /**
     *   logout function
     *   url : url
     *   params : JSON
     *   success : Request success callback function
     */
    
    static func logout(parameters: [String : AnyObject]?, success: (value : String) -> Void) {
        
        Alamofire.request(.POST, BIT.URL.DoLogoutURL, parameters: parameters)
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
        
    }
    
    // FIXME: It doesn't work well
    
    /**
     *   forceLogout function
     *   url : url
     *   params : JSON
     *   success : Request success callback function
     */
    
    static func forceLogout(parameters :[String : AnyObject]?, success :(value : String) -> Void) {
        
        Alamofire.request(.POST, BIT.URL.ForceLogoutURL, parameters: parameters)
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
    
    
    // MARK: Get user balance, show it on another view
    
    /**
     *   getBalance function
     *   url : url
     *   params : JSON
     *   success : Request success callback function
     */
    
    static func getBalance(parameters :[String : AnyObject]?, success :(value : AnyObject?) -> Void) {
        
        Alamofire.request(.GET, BIT.URL.UserOnlineURL, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
    
    /**
     *   getLoginState function
     *   url : url
     *   params : JSON
     *   success : Request success callback function
     */
    
    static func getLoginState(success :(value : String) -> Void) {
        
        Alamofire.request(.POST, BIT.URL.RadUserInfoURL)
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    success(value: value)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                
        }
    }
    
}