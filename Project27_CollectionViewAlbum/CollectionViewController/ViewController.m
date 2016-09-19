//
//  ViewController.m
//  CollectionViewController
//
//  Created by Kuan-Wei Lin on 9/19/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.library = [[ALAssetsLibrary alloc] init];
    //使用參數ALAssetsGroupSavedPhotos 取出所有照片
    [self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        if (group != nil)
        {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                if (result != nil) {
                    [tempArray addObject:result];
                }
            }];
            
            //保存結果
            self.imageArray = [tempArray copy];
            NSLog(@"取出照片共 %lu 張", (unsigned long)self.imageArray.count);
            //要求collectionView重新載入資料
            [self.collectionView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"讀取照片失敗");
    }];
    
    self.phImageArray = [self getAllPhotos];
}

#pragma mark - PHPhotoLibrary, use it for iOS 9
-(NSMutableArray *)getAllPhotos
{
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    PHFetchResult *fetchResult = @[allPhotos][0];
    
    for (int x = 0; x < fetchResult.count; x ++) {
        
        PHAsset *asset = fetchResult[x];
        photos[x] = asset;
    }
    
    NSLog(@"photos = %lu", photos.count);
    
    return photos;
}

- (void)getLastImageFromCameraRoll{

    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    PHAsset *lastAsset = [fetchResult lastObject];
    
    [[PHImageManager defaultManager] requestImageForAsset:lastAsset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:PHImageRequestOptionsVersionCurrent resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        NSLog(@"last image result = %@", result);
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[MyCell alloc] init];
    }
    
    //取出每一張照片的資料並將ALAsset轉換成UIImage格式
//    ALAssetRepresentation *representation = [[self.imageArray objectAtIndex:indexPath.row] defaultRepresentation];
//    CGImageRef resolutionRef = [representation fullResolutionImage];
//    UIImage *image = [UIImage imageWithCGImage:resolutionRef scale:1.0f orientation:(UIImageOrientation)representation.orientation];
    
//    cell.imageView.image = image;
    
    
    //取出每一張照片的資料並將PHAsset轉換成UIImage格式
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    [manager requestImageForAsset:self.phImageArray[indexPath.row] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        cell.imageView.image = result;
        
    }];

    return cell;
}




@end
