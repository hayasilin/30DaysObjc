//
//  ViewController.h
//  CollectionViewController
//
//  Created by Kuan-Wei Lin on 9/19/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsLibrary/AssetsLibrary.h"
#import "MyCell.h"
#import "Photos/Photos.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) ALAssetsLibrary *library;

@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *phImageArray;

@end

