//
//  Swarm.swift
//  WorkoutLogger
//
//  Created by Gary Herman on 11/19/16.
//  Copyright © 2016 SWARM NYC. All rights reserved.
//

import UIKit
import Spine
import AFDateHelper

class Swarm : Resource {
    
    var owner : User?
    var location : NSArray?
    var locationName : String?
    var title : String?
    var body : String?
    var photoURL : String?
    var tags : LinkedResourceCollection?

    var featured : Date?
    var isFeatured = false
    var likes : Int = 0
    var created : Date?
    var updated : Date?
    
    var flagged = false
    var draft = true
    
    override class var resourceType : ResourceType {
        return "swarms"
    }
    
    override class var fields : [Field] {
        return fieldsFromDictionary([
            "created" : DateAttribute().serializeAs("created-at"),
            "updated" : DateAttribute().serializeAs("updated-at"),
            "featured" : DateAttribute(),
            "title" : Attribute(),
            "body" : Attribute(),
            "draft" : Attribute(),
            "location" : Attribute(),
            "locationName" : Attribute().serializeAs("locationname"),
            "photoURL" : Attribute().serializeAs("image"),
            "owner" : ToOneRelationship(User.self)
            ])
    }
    
    required init() {
        super.init()
        tags = LinkedResourceCollection(resourcesURL: nil, linkURL: nil, linkage: nil)
        created = Date()
        featured = Date().dateBySubtractingDays(1000)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

