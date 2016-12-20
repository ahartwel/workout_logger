//
//  SwarmDataManager.swift
//  SwarmApp
//
//  Created by Gary Herman on 12/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import Alamofire
import Spine

class SwarmDataManager {
    
    // data model dictionary of ID -> Swarm ??? does this act as a cache?
    var swarms = [String:Swarm]()
    
    var sortedswarms : [Swarm] { // Sorted for what?
        get {
            let swarmsarray = Array(swarms.values)
            // sort them based on buisiness logic
            return swarmsarray
        }
    }

    static let shared = SwarmDataManager()
    fileprivate init() {
    }
    
    
    func getSwarms(callback: ([Swarm]) -> ()) {
        callback([]);
    }
    

}
