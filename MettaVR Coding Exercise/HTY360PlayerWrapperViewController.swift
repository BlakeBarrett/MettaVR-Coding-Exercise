//
//  HTY360PlayerWrapperViewController.swift
//  MettaVR Coding Exercise
//
//  Created by Blake Barrett on 6/6/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

import Foundation

class HTY360PlayerWrapperViewController: HTY360PlayerVC {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(url: NSURL) {
        // UIImage* thumbnailAtTime = _playerItem.getThumbnailForTime(cmTime);
        super.init(nibName: "HTY360PlayerVC", bundle: NSBundle.mainBundle(), url: url)
    }
    
    override func showThumbnailFor(scrubber: UISlider!, atTime time: CMTime, withPlayerItem player: AVPlayerItem!) {
        let thumbnail = player.getThumbnailFor(time)
        self.thumbnailImageView.image = thumbnail
        self.thumbnailImageView.alpha = 1.0
    }
    
    override func hideThumbnail() {
        self.thumbnailImageView.alpha = 0.0
    }
}