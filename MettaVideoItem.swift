//
//  MetaVideoItem.swift
//  MettaVR Coding Exercise
//
//  Created by Blake Barrett on 6/4/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

import Foundation

class MettaVideoItem {
    
    var url: NSURL?
    var height: Int?
    
    init(info: NSDictionary) {
        self.url = NSURL(string: info["url"] as! String)
//        self.height = info.valueForKey("height")!
    }
    
}