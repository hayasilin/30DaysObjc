//
//  WikiFaceManager.h
//  WikiFace
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageIO/ImageIO.h"
#import "UIKit/UIKit.h"


typedef enum WikiFaceError: NSUInteger {
    WikiCouldNotDownloadImage
} WikiFaceError;

@interface WikiFaceManager : NSObject

- (void)faceForPerson:(NSString *)person size:(CGSize)size complete:(void(^)(UIImage *image, BOOL imageFound))completeHandler;

- (void)centerImageViewOnFace:(UIImageView *)imageView;


@end
