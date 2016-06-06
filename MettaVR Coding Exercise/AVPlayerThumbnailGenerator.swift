//
//  AVPlayerThumbnailGenerator.swift
//  MettaVR Coding Exercise
//
//  Created by Blake Barrett on 6/6/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

import AVFoundation

extension AVPlayerItem {

    // This approach is quite expensive, but I only have one hour left to add a fancy feature
    // Lifted this function straight from here:
    //   https://github.com/BlakeBarrett/wndw/blob/master/wtrmrkr/VideoMaskingUtils.swift#L19
    func getThumbnailFor(time: CMTime) -> UIImage? {
        
        let imageGenerator = AVAssetImageGenerator(asset: self.asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        do {
            let imageRef = try imageGenerator.copyCGImageAtTime(time, actualTime: nil)
            return UIImage(CGImage: imageRef)
        } catch let error as NSError
        {
            print("AVPlayerItem(Extension):: Error: \(error)")
            return nil
        }
    }
    
}