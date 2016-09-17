//
//  WikiFaceManager.m
//  WikiFace
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "WikiFaceManager.h"

@interface WikiFaceManager ()

@end

@implementation WikiFaceManager

- (void)faceForPerson:(NSString *)person size:(CGSize)size complete:(void(^)(UIImage *image, BOOL imageFound))completeHandler
{
    NSString *escapedString = [person stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    int pixelsForAPIRequest = MAX(size.width, size.height) * 2;
    
    NSString *urlString = [NSString stringWithFormat:@"https://en.wikipedia.org/w/api.php?action=query&titles=%@&prop=pageimages&format=json&pithumbsize=%d", escapedString, pixelsForAPIRequest];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error == nil)
        {
            NSDictionary *wikiDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *query = [wikiDict objectForKey:@"query"];
            NSDictionary *pages = [query objectForKey:@"pages"];
            NSDictionary *pageContent = [[pages allValues]firstObject];
            NSDictionary *thumbnail = [pageContent objectForKey:@"thumbnail"];
            NSString *thumbURL = [thumbnail objectForKey:@"source"];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:thumbURL]];
            UIImage *faceImage = [UIImage imageWithData:imageData];
            
            if (faceImage != nil)
            {
                completeHandler(faceImage, YES);
            }
            else
            {
                completeHandler(nil, NO);
            }
        }
        else
        {
            completeHandler(nil, NO);
        }
        
    }];
    
    [task resume];
    [session finishTasksAndInvalidate];
}

- (void)centerImageViewOnFace:(UIImageView *)imageView
{
    CIContext *context = [CIContext contextWithOptions:nil];
    NSDictionary *options = @{CIDetectorAccuracy:CIDetectorAccuracyHigh};
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:options];
    
    UIImage *faceImage = imageView.image;
    CIImage *ciImage = [CIImage imageWithCGImage:faceImage.CGImage];
    
    NSArray *features = [detector featuresInImage:ciImage];
    
    if (features.count > 0)
    {
        CIFaceFeature *face;
        for (CIFaceFeature *rect in features) {
            face = rect;
        }
        
        CGRect faceRectWithExtendedBounds = face.bounds;
        faceRectWithExtendedBounds.origin.x -= 20;
        faceRectWithExtendedBounds.origin.y -= 30;
        
        faceRectWithExtendedBounds.size.width += 40;
        faceRectWithExtendedBounds.size.height += 40;
        
        CGFloat x = faceRectWithExtendedBounds.origin.x / faceImage.size.width;
        CGFloat y = (faceImage.size.height - faceRectWithExtendedBounds.origin.y - faceRectWithExtendedBounds.size.height) / faceImage.size.height;
        
        CGFloat widthFace = faceRectWithExtendedBounds.size.width / faceImage.size.width;
        CGFloat heightFace = faceRectWithExtendedBounds.size.height / faceImage.size.height;
        
        imageView.layer.contentsRect = CGRectMake(x, y, widthFace, heightFace);
    }
}

@end
