//
//  SwarmDataManager.swift
//  WorkoutLogger
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
    
    
    func getSwarms(callback: @escaping ([Swarm]) -> ()) {
        //TODO add example of request with spine
        callback([]);
        
        let networkClient = HTTPClient()
        let spine = Spine(baseURL: Configuration.shared.serverUrl, networkClient: networkClient)
        spine.registerResource(Swarm.self)
        let query = Query(resourceType: Swarm.self)
        spine.find(query).onSuccess { resources, meta, jsonapi in
            guard let swarms = resources.resources as? [Swarm] else {
                print("there was an error getting the Swarms")
                callback([]);
                return
            }
            callback(swarms);
            
            }
            .onFailure { (error) in
                print("ERROR GETTING swarms: \(error)")
                callback([]);
        }
        
        
    }
    

}
