//
//  User.swift
//  SwarmApp
//
//  Created by SWARM on 9/6/16.
//  Copyright © 2016 SWARM. All rights reserved.
//

import Spine

class User : Resource {

    var name : String?
    var email : String?
    var password : String?
    var instagram : String?
    var hometown : String?          // could be a Location
    var bio : String?
    var website : String?
    var token : String?             // Tiplr API token
    var instagramToken : String?
    var avatarImageURL : String?
    var coverImageURL : String?
    var locationSettings : String?  // not sure what this is yet
    
    var swarms : LinkedResourceCollection?              // [Swarm]

    var flagged = false     // set if the user has this explorer flagged

    required init() {
        super.init()
        swarms = LinkedResourceCollection(resourcesURL: nil, linkURL: nil, linkage: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var resourceType : ResourceType {
        return "users"
    }

    override class var fields : [Field] {
        return fieldsFromDictionary([
            "name" : Attribute(),
            "instagram" : Attribute(),
            "token" : Attribute(),
            "bio" : Attribute(),
            "website" : Attribute(),
            "instagramToken" : Attribute(),
            "avatarImageURL" : Attribute(),
            "swarms" : ToManyRelationship(Swarm.self)
            ])
    }
        
    func hasSwarmInSwarms(_ swarm:Swarm) -> Bool {
        if swarms!.linkage == nil {
            return false
        }
        for resource in swarms!.linkage! {
            if getResourceIdentifierID(lhs: resource) == swarm.id! {
                return true
            }
        }
        return false
    }
}
