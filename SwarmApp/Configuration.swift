//
//  Configuration.swift
//  SwarmApp
//
//  Created by Alex Hartwell on 12/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import Foundation


class Configuration {
    
    static var shared: Configuration = Configuration();
    
    var serverUrl: URL {
        get {
            #if DEV
                return URL(string: "https://swarmnyc.com")!;
            #elseif QA
                return URL(string: "https://swarmnyc.com")!;
            #elseif PROD
                return URL(string: "https://swarmnyc.com")!;
            #endif
        }
    }
    
    
    
    
}
