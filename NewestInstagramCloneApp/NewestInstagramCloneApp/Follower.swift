//
//  Follower.swift
//  NewestInstagramCloneApp
//
//  Created by Dushko Cizaloski on 5/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation

class Follower : AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var id  : String = ""
    var follower  : String = ""
    var following   : String = ""
    
//    override init!() {
//        super.init()
//    }
    
     convenience required init(coder aDecoder: NSCoder)
     {
        self.init()
        self.id = aDecoder.decodeObject(forKey: "id") as! String

        if aDecoder.decodeObject(forKey: "id") as? String != nil {
            self.id = aDecoder.decodeObject(forKey: "id") as! String
        }
        
        if  aDecoder.decodeObject(forKey: "follower") as? String != nil {
            self.follower = aDecoder.decodeObject(forKey: "follower") as! String
        }
        
        if aDecoder.decodeObject(forKey: "following") as? String != nil {
            self.following = aDecoder.decodeObject(forKey: "following") as! String
        }
    }
    
//     init(dictionary dictionaryValue: [NSObject : AnyObject]!, error: ()) throws {
//        super.init()
//        
//        if self.dictionaryValue["id"] != nil {
//            id = self.dictionaryValue["id"] as! String
//        }
//        
//        if self.dictionaryValue["follower"] != nil {
//            follower = self.dictionaryValue["follower"] as! String
//        }
//        
//        if self.dictionaryValue["following"] != nil {
//            following = self.dictionaryValue["following"] as! String
//        }
//    }
    
    
//    required init!(coder: NSCoder!) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    class func dynamoDBTableName() -> String {
        return "Followers"
    }
    
    class func hashKeyAttribute() -> String {
        return "id"
    }
}
