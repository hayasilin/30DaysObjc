//
//  CameraView.m
//  SnapChatMenu
//
//  Created by Kuan-Wei Lin on 8/13/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "CameraView.h"
#import "AVFoundation/AVFoundation.h"

@interface CameraView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation CameraView

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    self.captureSession = [[AVCaptureSession alloc] init];
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    self.captureSession.sessionPreset = AVCaptureSessionPreset1920x1080;
//    
//    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:@"AVMediaTypeVideo"];
//    NSError *error;
//    AVCaptureInput *input = [[AVCaptureInput alloc] init];
//    
//    @try {
//        input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
//    } @catch (NSException *exception) {
//        NSLog(@"%@", exception.reason);
//    } @finally {
//        input = nil;
//    }
//    
//    if (error == nil && [_captureSession canAddInput:input] != NO) {
//        [_captureSession addInput:input];
//        _stillImageOutput.outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
//        
//        if ([_captureSession canAddOutput:_stillImageOutput] != NO) {
//            [_captureSession addOutput:_stillImageOutput];
//            
//            self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
//            self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//            self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
//            [self.cameraView.layer addSublayer:_previewLayer];
//            [_captureSession startRunning];
//        }
//    }
//}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    self.previewLayer.frame = self.cameraView.bounds;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
