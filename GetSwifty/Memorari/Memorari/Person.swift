//
//  Person.swift
//  Memorari
//
//  Created by Mandy Cho on 6/26/16.
//  Copyright © 2016 Obsendian. All rights reserved.
//

import UIKit

// NSCoding requires inheritance from NSObject in order to use protocols
class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image:String){
        self.name = name
        self.image = image
    }
    
    // Reading from disc
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        image = aDecoder.decodeObjectForKey("image") as! String
    }
    
    // Writing to disc
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(image, forKey: "image")
    }
}
