//
//  TADFlashlightDetector.h
//  javascriptCall
//
//  Created by Kuan-Wei on 2016/6/28.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TADFlashlightDetector : NSObject

+ (instancetype)defaultDetector;
- (void)turnFlashlightOn;
- (void)turnFlashlightOff;
- (void)FlashlightOnOffSwitch;
- (void)startFlashlightWithTimeInterval:(float)second times:(int)times;
- (void)stopFlashlightAndTimer;

@end
