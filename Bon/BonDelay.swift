//
//  BonDelay.swift
//  Bon
//
//  Created by Chris on 16/4/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Foundation

typealias Task = (cancel : Bool) -> Void

func delay(time: NSTimeInterval, task: ()->()) ->  Task? {
    
    func dispatch_later(block: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(),
            block)
    }
    
    var closure: dispatch_block_t? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), internalClosure);
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(cancel: false)
        }
    }
    
    return result;
}

func cancel(task: Task?) {
    task?(cancel: true)
}

//// Function to create a delay method that is easy to re-use
//func delay(delay:Double, closure:()->()) {
//    dispatch_after(
//        dispatch_time(
//            DISPATCH_TIME_NOW,
//            Int64(delay * Double(NSEC_PER_SEC))
//        ),
//        dispatch_get_main_queue(), closure)
//}
