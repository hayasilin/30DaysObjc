//
//  SecondViewController.m
//  CollectionViewController
//
//  Created by Kuan-Wei Lin on 9/19/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "SecondViewController.h"
#import "Photos/Photos.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - PHPhotoLibrary
- (void)getLastImageFromCameraRoll
{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    PHAsset *lastAsset = [fetchResult lastObject];
    
    [[PHImageManager defaultManager] requestImageForAsset:lastAsset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //[[self btn] setImage:result forState:UIControlStateNormal];
            self.imageView.image = result;
            
        });
        
    }];
}


- (IBAction)buttonPressed:(UIButton *)sender
{
    [self getLastImageFromCameraRoll];
}

@end
