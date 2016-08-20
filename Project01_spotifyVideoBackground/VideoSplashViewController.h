//
//  VideoSplashViewController.h
//  spotifyVideoBackground
//
//  Created by Kuan-Wei Lin on 4/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@import AVKit;

enum ScalingMode {
    Resize = 0,
    ResizeAspect,
    ResizeAspectFill
};


@interface VideoSplashViewController : UIViewController

@end
