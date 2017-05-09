//
//  User.swift
//  NewestInstagramCloneApp
//
//  Created by Dushko Cizaloski on 5/1/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation

class User : AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var id  : String = ""
    var name   : String = ""
    
//    override init!() {
//        super.init()
//    }
    
    convenience required init(coder aDecoder: NSCoder) {
        self.init()
        self.id = aDecoder.decodeObject(forKey: "id") as! String
           // self.dictionaryValue["id"] as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
            //self.dictionaryValue["name"] as! String

    }
//     init(dictionary dictionaryValue: [NSObject : AnyObject]!) throws {
//            }
//    
    
//    required init!(coder: NSCoder!) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    class func dynamoDBTableName() -> String {
        return "Users"
    }
    
    class func hashKeyAttribute() -> String {
        return "id"
    }
}
