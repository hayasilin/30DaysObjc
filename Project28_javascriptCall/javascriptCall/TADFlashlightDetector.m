//
//  TADFlashlightDetector.m
//  javascriptCall
//
//  Created by Kuan-Wei on 2016/6/28.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "TADFlashlightDetector.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TADFlashlightDetector ()

//設定Timer
@property (weak, nonatomic) NSTimer *timer;
//重複Counting
@property (nonatomic) int loopCount;
//閃爍間隔時間
@property (nonatomic) float second;
//閃爍次數
@property (nonatomic) int times;

@end

@implementation TADFlashlightDetector

+ (instancetype)defaultDetector {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Flashlight

- (void)turnFlashlightOn {
    if ([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]){
        NSLog(@"此裝置有背面閃光燈");
        AVCaptureDevice *flashlight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([flashlight isTorchAvailable] && [flashlight isTorchModeSupported:AVCaptureTorchModeOn]) {
            BOOL success = [flashlight lockForConfiguration:nil];
            if (success) {
                [flashlight setTorchMode:AVCaptureTorchModeOn];
                [flashlight unlockForConfiguration];
            }
        }
    }else{
        NSLog(@"此裝置無閃光燈功能");
    }
}

- (void)turnFlashlightOff {
    if ([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]){
        AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn]){
            BOOL success = [flashLight lockForConfiguration:nil];
            if(success){
                [flashLight setTorchMode:AVCaptureTorchModeOff];
                [flashLight unlockForConfiguration];
            }
        }
    }else{
        NSLog(@"此裝置無閃光燈功能");
    }
}

- (void)FlashlightOnOffSwitch {
    
    self.loopCount++;
    if (self.loopCount >= (self.times * 2)) {
        [self stopFlashlightAndTimer];
        self.loopCount = 0;
    }else{
        if ([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]){
            AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if ([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn]){
                BOOL success = [flashLight lockForConfiguration:nil];
                if (success){
                    if ([flashLight torchMode] == 1) {
                        [flashLight setTorchMode:AVCaptureTorchModeOff];
                    } else {
                        [flashLight setTorchMode:AVCaptureTorchModeOn];
                    }
                    [flashLight unlockForConfiguration];
                }
            }
        }else{
            NSLog(@"此裝置無閃光燈功能");
        }
    }
}

- (void)startFlashlightWithTimeInterval:(float)second times:(int)times {
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(FlashlightOnOffSwitch) userInfo:nil repeats:YES];
    }
    self.times = times;
    
    //[self performSelector:@selector(stopFlashlightAndTimer) withObject:nil afterDelay:times];
}

- (void)stopFlashlightAndTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self turnFlashlightOff];
}

@end
