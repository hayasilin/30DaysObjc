//
//  TADMicrophoneDetector.m
//  javascriptCall
//
//  Created by Kuan-Wei on 2016/6/28.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "TADMicrophoneDetector.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface TADMicrophoneDetector () <AVAudioRecorderDelegate>

//低頻率聲音數值
@property (nonatomic) double lowPassResults;
//瞬間最大聲音數值
@property (nonatomic) double maxLowPassResults;
//設定每秒偵測時間
@property (weak, nonatomic) NSTimer *timer;
//AVAudioRecorder library
@property (strong, nonatomic) AVAudioRecorder *recorder;

@end

@implementation TADMicrophoneDetector

+ (instancetype)defaultDetector {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - 麥克風音量偵測

- (void)startSoundDetector{
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        if(granted) {
            //允許
            NSLog(@"允許使用麥克風");
            NSError *errorMic;
            [session setCategory:@"AVAudioSessionCategoryPlayAndRecord" error:&errorMic];
            
            //開始偵測聲音
            NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
            
            NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                      [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                      [NSNumber numberWithInt: 0],                         AVNumberOfChannelsKey,
                                      [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                      nil];
            NSError *error;
            
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setActive:YES error:nil];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
            
            _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
            
            if (_recorder) {
                _recorder.delegate = self;
                [_recorder prepareToRecord];
                _recorder.meteringEnabled = TRUE;
                [_recorder record];
                if (self.timer == nil) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(levelTimerCallback) userInfo: nil repeats: YES];
                }
            } else {
                NSLog(@"error");// mic error message
            }
        }
        else {
            //不允許
            NSLog(@"不允許使用麥克風");
        }
    }];
}

- (void)startSoundDetectorWithSecond:(float)second{
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        if(granted) {
            //允許
            NSLog(@"允許使用麥克風");
            NSError *errorMic;
            [session setCategory:@"AVAudioSessionCategoryPlayAndRecord" error:&errorMic];
            
            //開始偵測聲音
            NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
            NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                      [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                      [NSNumber numberWithInt: 0],                         AVNumberOfChannelsKey,
                                      [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                      nil];
            NSError *error;
            
            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
            [audioSession setActive:YES error:nil];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
            
            _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
            
            if (_recorder) {
                _recorder.delegate = self;
                [_recorder prepareToRecord];
                _recorder.meteringEnabled = TRUE;
                [_recorder record];
                if (self.timer == nil) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(levelTimerCallback) userInfo: nil repeats: YES];
                }
            } else {
                NSLog(@"error");// mic error message
            }
            
            //設定幾秒後關閉聲音偵測
            [self performSelector:@selector(closeSoundDetector) withObject:nil afterDelay:second];
            
        }
        else {
            //不允許
            NSLog(@"不允許使用麥克風");
        }
    }];
}

- (void)levelTimerCallback {
    [_recorder updateMeters];
    
    //averagePowerForChannel及peakPowerForChannel回傳從0db～-160db之間，0db為最大能量，-160db為最小
    NSLog(@"平均：%f 波峰：%f",[_recorder averagePowerForChannel:0],[_recorder peakPowerForChannel:0]);
    
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    _lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * _lowPassResults;
    NSLog(@"lowPass = %f", _lowPassResults);
    
    if (_lowPassResults > _maxLowPassResults) {
        _maxLowPassResults = _lowPassResults;
    }
    
    if (_lowPassResults > 0.35) {
        NSLog(@"Mic blow detected1");
    }else{
        //Do nothing
    }
    
    //TODO: - 計算分貝數 - 方法1
    float avg = [_recorder averagePowerForChannel:0];
    //比如把-60作為最低分貝
    float minValue = -60;
    //把60作為獲取分配的範圍
    float range = 60;
    //把100作為輸出分貝的範圍
    float outRange = 100;
    //確保在最小值範圍內
    if (avg < minValue){
        avg = minValue;
    }
    //計算分貝數
    float decibels = (avg + range) / range * outRange;
    self.currentDecibel = (int)roundf(decibels);
    NSLog(@"分貝數 = %f",  decibels);
    NSLog(@"分貝數四捨五入 = %i", self.currentDecibel);
    
    if (self.currentDecibel > self.maxDecibel) {
        self.maxDecibel = self.currentDecibel;
    }
    
    //TODO: - 計算分貝數 - 方法2
    float level;                // The linear 0.0 .. 1.0 value we need.
    float minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
    float avgDecibels = [_recorder averagePowerForChannel:0];
    
    if (avgDecibels < minDecibels){
        level = 0.0f;
    }else if (avgDecibels >= 0.0f){
        level = 1.0f;
    }else{
        float   root            = 2.0f;
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * avgDecibels);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        level = powf(adjAmp, 1.0f / root);
    }
    NSLog(@"分貝平均值 %f", level * 120);
}

- (void)closeSoundDetector {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.recorder stop];
    NSLog(@"聲音偵測停止，maxDecibel = %d", self.maxDecibel);
}

@end
