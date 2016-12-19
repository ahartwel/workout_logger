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
    
    // data model dictionary of ID -> Swarm
    var swarms = [String:Swarm]()
    
    var sortedswarms : [Swarm] {
        get {
            let swarmsarray = Array(swarms.values)
            // sort them based on buisiness logic
            return swarmsarray
        }
    }

    static let shared = SwarmDataManager()
    fileprivate init() {
    }
    

}
