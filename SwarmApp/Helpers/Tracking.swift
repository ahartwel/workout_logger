//
//  Tracking.swift
//  SwarmApp
//
//  Created by Alex Hartwell on 1/4/17.
//  Copyright © 2017 SWARM NYC. All rights reserved.
//

import Foundation


class Tracker {
    
    static var shared: Tracker = Tracker();
    
    
    func trackScreenView(screenName: String) {
        let tracker = GAI.sharedInstance().defaultTracker;
        tracker?.set(kGAIScreenName, value: "\(screenName):\(Configuration.shared.environment)");
        let builder: NSObject = GAIDictionaryBuilder.createScreenView().build();
        tracker?.send(builder as! [NSObject: AnyObject]);
    }
    
    
    
    func trackEvent(category: String, action: String, label: String?) {
        let tracker = GAI.sharedInstance().defaultTracker;
        let builder = GAIDictionaryBuilder.createEvent(withCategory: "\(category):\(Configuration.shared.environment)", action: action, label: label, value: nil).build() as [NSObject : AnyObject];
        tracker?.send(builder);
        
    }
    
    
    
}
