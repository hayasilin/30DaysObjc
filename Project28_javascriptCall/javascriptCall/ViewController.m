//
//  ViewController.m
//  javascriptCall
//
//  Created by Kuan-Wei on 2016/6/28.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "ViewController.h"
#import "TADFlashlightDetector.h"
#import "TADMicrophoneDetector.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

//@property (strong, nonatomic) TADFlashlightDetector *flashlightDetector;
//@property (strong, nonatomic) TADMicrophoneDetector *microphoneDetector;

//@property (weak, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSString *decibelValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sdk4" ofType:@"html"]isDirectory:NO]]];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"absoluteString = %@", request.URL.absoluteString);
    NSLog(@"relativeString = %@", request.URL.relativeString);
    NSLog(@"baseURL = %@", request.URL.baseURL);
    NSLog(@"absoluteURL = %@", request.URL.absoluteURL);
    NSLog(@"host = %@", request.URL.host);
    NSLog(@"port = %@", request.URL.port);
    NSLog(@"user = %@", request.URL.user);
    NSLog(@"password = %@", request.URL.password);
    NSLog(@"path = %@", request.URL.path);
    NSLog(@"fragment = %@", request.URL.fragment);
    NSLog(@"parameterString = %@", request.URL.parameterString);
    NSLog(@"query = %@", request.URL.query);
    NSLog(@"relativePath = %@", request.URL.relativePath);
    
    NSString *urlAbsoluteString = request.URL.absoluteString;
    //NSString* strUrl = [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strUrl = [request.URL.absoluteString stringByRemovingPercentEncoding];
    
    // 判斷點下的網址是否有js-call，更精確應該再比對切出來的字串是否有runObjMethod
    if( [urlAbsoluteString hasPrefix:@"js-call:"])
    {
        [self runObjMethod];
        
        return NO;
    }
    else if ([[request.URL.scheme lowercaseString]isEqualToString:@"flashswitch"])
    {
        TADFlashlightDetector *flashlightDetector = [TADFlashlightDetector defaultDetector];
        
        NSArray *r = [strUrl componentsSeparatedByString:@"://"];
        NSString *cStr = [[r lastObject] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSString *strState = [cStr stringByReplacingOccurrencesOfString:@"state=" withString:@""];
        
        //取得閃光燈開關參數
        NSLog(@"flashlight state = %@", strState);
        
        if ([strState isEqualToString:@"1"]) {
            [flashlightDetector turnFlashlightOn];
        }else if ([strState isEqualToString:@"0"]){
            [flashlightDetector turnFlashlightOff];
        }else{
            //Do nothing
        }
        
        return NO;
    }
    else if ([[request.URL.scheme lowercaseString] isEqualToString:@"flasheffect"])
    {
        TADFlashlightDetector *flashlightDetector = [TADFlashlightDetector defaultDetector];
        
        //NSArray *tempArray = [strUrl componentsSeparatedByString:@"://"];
        //NSString *qStr = [[tempArray lastObject] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSString *qStr = request.URL.query;
        NSArray *dataArray = [qStr componentsSeparatedByString:@"&"];
        NSString *intervalString = [[dataArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@"interval=" withString:@""];
        NSString *timesString = [[dataArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"times=" withString:@""];
        //取得閃光燈閃爍間隔及閃爍次數
        NSLog(@"flashlight interval = %@, times = %@", intervalString, timesString);
        
        if (intervalString && timesString) {
            [flashlightDetector startFlashlightWithTimeInterval:[intervalString floatValue] times:[timesString intValue]];
        }
        
        return NO;
    }
    else if ([[request.URL.scheme lowercaseString] isEqualToString:@"microphoneswitch"])
    {
        TADMicrophoneDetector *microphoneDetector = [TADMicrophoneDetector defaultDetector];
        
        NSArray *r = [strUrl componentsSeparatedByString:@"://"];
        NSString *cStr = [[r lastObject] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSString *strState = [cStr stringByReplacingOccurrencesOfString:@"state=" withString:@""];
        NSLog(@"microphone state = %@", strState);
        
        if ([strState isEqualToString:@"1"]) {
            [microphoneDetector startSoundDetector];
        }else if ([strState isEqualToString:@"0"]){
            [microphoneDetector closeSoundDetector];
        }
        
        return NO;
    }
    else if ([[request.URL.scheme lowercaseString] isEqualToString:@"maxdecibel"])
    {
        TADMicrophoneDetector *microphoneDetector = [TADMicrophoneDetector defaultDetector];
        
        NSArray *r = [strUrl componentsSeparatedByString:@"://"];
        NSString *cStr = [[r lastObject] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSString *strState = [cStr stringByReplacingOccurrencesOfString:@"second=" withString:@""];
        
        if (strState) {
            [microphoneDetector startSoundDetectorWithSecond:[strState floatValue]];
        }
        
        //Call back
//        if (self.timer == nil) {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:[strState floatValue] target:self selector:@selector(maxDecibelCallback) userInfo:nil repeats:NO];
//        }
        [self performSelector:@selector(maxDecibelCallback) withObject:nil afterDelay:[strState floatValue]];
        
        //NSLog(@"音量最大值 = %d", microphoneDetector.maxDecibel);
    }
    else if ([[request.URL.scheme lowercaseString] isEqualToString:@"isoverdecibel"])
    {
        TADMicrophoneDetector *microphoneDetector = [TADMicrophoneDetector defaultDetector];
        
        //NSArray *tempArray = [strUrl componentsSeparatedByString:@"://"];
        //NSString *qStr = [[tempArray lastObject] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSString *qStr = request.URL.query;
        NSArray *dataArray = [qStr componentsSeparatedByString:@"&"];
        NSString *secondString = [[dataArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@"second=" withString:@""];
        NSString *decibelValueString = [[dataArray objectAtIndex:1] stringByReplacingOccurrencesOfString:@"decibelValue=" withString:@""];
        //取得時間及設定分貝數
        NSLog(@"second = %@, decibelValue = %@", secondString, decibelValueString);
        
        if (secondString && decibelValueString) {
            [microphoneDetector startSoundDetectorWithSecond:[secondString floatValue]];
        }
        
        self.decibelValue = decibelValueString;
        
        //Call back
//        if (self.timer == nil) {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:[secondString floatValue] target:self selector:@selector(IsOverDecibelCallback) userInfo:nil repeats:NO];
//        }
        [self performSelector:@selector(IsOverDecibelCallback) withObject:nil afterDelay:[secondString floatValue]];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Javascript call back
- (void)maxDecibelCallback
{
//    if (self.timer != nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
    //Call back 音量最大值
    TADMicrophoneDetector *microphoneDetector = [TADMicrophoneDetector defaultDetector];
    if (microphoneDetector.maxDecibel != 0) {
        NSLog(@"maxDecibel = %i", microphoneDetector.maxDecibel);
        NSString *script = [NSString stringWithFormat:@"maxDecibelCallback('%i');", microphoneDetector.maxDecibel];
        [self.webView stringByEvaluatingJavaScriptFromString:script];
    }
}

- (void)IsOverDecibelCallback
{
//    if (self.timer != nil){
//        [self.timer invalidate];
//        self.timer = nil;
//    }
    
    NSLog(@"decibel = %@", self.decibelValue);
    
    TADMicrophoneDetector *microphoneDetector = [TADMicrophoneDetector defaultDetector];
    //Call back 回傳音量是否超過特定分貝true/false
    if (microphoneDetector.maxDecibel >= [self.decibelValue intValue])
    {
        NSString *booleanStr = @"true";
        NSString *script = [NSString stringWithFormat:@"isOverDecibelCallback('%@');", booleanStr];
        [self.webView stringByEvaluatingJavaScriptFromString:script];
    }
    else
    {
        NSString *booleanStr = @"false";
        NSString *script = [NSString stringWithFormat:@"isOverDecibelCallback('%@');", booleanStr];
        [self.webView stringByEvaluatingJavaScriptFromString:script];
    }
}

- (void) runObjMethod
{
    NSLog(@"this is objective-c method");
    
    // 方法1
    NSString *myval = @"my parameters from objective-c";
    // javascript 的function 名稱 與obj變數組合成字串
    //NSString  *jsMethod = [NSString stringWithFormat:@"%@%@%@", @"jsFunction('", myval, @"')"];
    
    //[self.webView stringByEvaluatingJavaScriptFromString:jsMethod];
    
    // 方法2
    [self.webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"jsFunction('%@')",myval]];
}

@end
