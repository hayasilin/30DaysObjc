//
//  videoCutter.m
//  spotifyVideoBackground
//
//  Created by Kuan-Wei Lin on 4/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "videoCutter.h"
#import <AVFoundation/AVFoundation.h>

@implementation videoCutter
//
//- (void) cropVideoWithUrl:(NSURL *)url start:(CGFloat)startTime dur:(CGFloat)duration andCompletionHandler:(void (^)(NSURL * videoPath, NSError * error))completionHandler{
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 耗时的操作
//        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
//        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:@"AVAssetExportPresetHighestQuality"];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *outPutURL = [paths objectAtIndex:0];
//        NSFileManager *manager = [NSFileManager defaultManager];
//        NSError *error;
//        
//        [manager createDirectoryAtPath:outPutURL withIntermediateDirectories:YES attributes:nil error:&error];
//        
//        outPutURL = [outPutURL stringByAppendingPathComponent:@"output.mp4"];
//        
//        [manager removeItemAtPath:outPutURL error:&error];
//        
//        exportSession = (AVAssetExportSession *)exportSession;
//        
//        
//        
//        
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 更新界面
//        });
//    });  
//
//    
//}




@end
