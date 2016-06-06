//
//  HTY360PlayerVC.h
//  HTY360Player
//
//  Created by  on 11/8/15.
//  Copyright © 2015 Hanton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HTY360PlayerVC : UIViewController

@property (strong, nonatomic) NSURL *videoURL;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSURL*)url;
- (CVPixelBufferRef)retrievePixelBufferToDraw;
- (void)toggleControls;

// to be implemented in subclass
-(void)showThumbnailFor:(UISlider*)scrubber atTime:(CMTime)time withPlayerItem:(AVPlayerItem*)player;
-(void)hideThumbnail;

@end
