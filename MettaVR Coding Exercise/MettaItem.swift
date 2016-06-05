//
//  MetaItem.swift
//  MettaVR Coding Exercise
//
//  Created by Blake Barrett on 6/4/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

import Foundation

class MettaItem {
    
    var title: String?
    var description: String?
    var copies: [MettaVideoItem]?
    var previewUrl: NSURL?
    
    init(info: NSDictionary) {
        
        self.title = info["title"] as? String
        self.description = info["description"] as? String
        if let url = info["previewUrl"] as? String {
            self.previewUrl = NSURL(string: url)
        }
        
        if let copiesDictionary = info["copies"] as? NSDictionary {
            copiesDictionary.allKeys.forEach({ (key:AnyObject) in
                let item = copiesDictionary.valueForKey(key as! String) as! NSDictionary
                let video = MettaVideoItem(info: item)
                copies?.append(video)
            })
            
        }
    }
    
}