//
//  Post.swift
//  NewestInstagramCloneApp
//
//  Created by Dushko Cizaloski on 5/7/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation

class Post : AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var id: String = ""
    var message: String? = nil
    var userId: String = ""
    var bucket: String = ""
    var filename: String = ""
    
//    override init!() {
//        super.init()
//    }
    
    
    convenience required init(coder aDecoder: NSCoder) {
        self.init()
        
        if aDecoder.decodeObject(forKey: "id") as? String != nil {
            self.id = aDecoder.decodeObject(forKey: "id") as! String
        }
        
        if aDecoder.decodeObject(forKey: "bucket") as? String != nil {
            self.bucket = aDecoder.decodeObject(forKey: "bucket") as! String
        }
        
        if aDecoder.decodeObject(forKey: "filename") as? String != nil {
            self.filename = aDecoder.decodeObject(forKey: "filename") as! String
        }
        
        if aDecoder.decodeObject(forKey: "userId") as? String != nil {
            self.userId = aDecoder.decodeObject(forKey: "userId") as! String
        }
        
        self.message = aDecoder.decodeObject(forKey: "message") as? String != nil ? aDecoder.decodeObject(forKey: "message") as? String : ""
    }
    
    
//    required init!(coder: NSCoder!) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    class func dynamoDBTableName() -> String {
        return "Posts"
    }
    
    class func hashKeyAttribute() -> String {
        return "id"
    }
}
