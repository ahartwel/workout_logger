//
// Created by Alex Hartwell on 12/1/15.
// Copyright (c) 2015 SWARM NYC. All rights reserved.
//

import Foundation


open class Background {
    
    
    
    static public func runInBackground(_ inBackground: @escaping (() -> ())) {
        let priority = DispatchQueue.GlobalQueuePriority.background;
        DispatchQueue.global(priority: priority).async {
            inBackground();
        }
        
    }
    
    static public func runInBackgroundAndCallback(_ inBackground: @escaping (() -> ()), callback: @escaping (() -> ())) {
        let priority = DispatchQueue.GlobalQueuePriority.background;
        DispatchQueue.global(priority: priority).async {
            inBackground();
            DispatchQueue.main.async {
                callback();
            }
            
        }
        
        
    }
    
    static public func runInBackgroundHighPriorityNoCallback(_ inBackground: @escaping (() -> ())) {
        let priority = DispatchQueue.GlobalQueuePriority.background;
        DispatchQueue.global(priority: priority).async {
            inBackground();
        }
        
    }
    
    
    static public func runInBackgroundHighPriority(_ inBackground: @escaping (( (() -> ()) ) -> ()), callback: @escaping (() -> ())) {
        let priority = DispatchQoS.QoSClass.userInitiated;
        DispatchQueue.global(qos: priority).async {
            inBackground({
                
                DispatchQueue.main.async {
                    callback();
                }
            });
            
            
        };
        
    }
    
    static public func runInBackgroundAsyncAndCallback(_ inBackground: @escaping (( (@escaping () -> Void) ) -> ()), callback: @escaping (() -> ())) {
        let priority = DispatchQueue.GlobalQueuePriority.background;
        DispatchQueue.global(priority: priority).async {
            inBackground({
                
                DispatchQueue.main.async {
                    callback();
                }
            });
            
            
        };
        
        
    }
    
    static public func runInMainThread(_ closure: @escaping (() -> ())) {
        DispatchQueue.main.async(execute: closure);
    }
    
    
    
}
