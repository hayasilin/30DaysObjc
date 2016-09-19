//
//  TADMicrophoneDetector.h
//  javascriptCall
//
//  Created by Kuan-Wei on 2016/6/28.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TADMicrophoneDetector : NSObject

@property (nonatomic) int currentDecibel;
@property (nonatomic) int maxDecibel;

+ (instancetype)defaultDetector;
- (void)startSoundDetector;
- (void)startSoundDetectorWithSecond:(float)second;
- (void)closeSoundDetector;

@end
