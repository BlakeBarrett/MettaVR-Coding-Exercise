//
//  MettaItemCellView.swift
//  MettaVR Coding Exercise
//
//  Created by Blake Barrett on 6/4/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

import UIKit

class MettaItemCellView : UITableViewCell {
    var item: MettaItem?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var geographyLabelView: UILabel!
    
    @IBAction func onPlayButtonClick(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("mettaItemSelected", object: item)
    }
}
