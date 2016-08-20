//
//  MovieListGroupViewController.m
//  CustomViewController
//
//  Created by Kuan-Wei Lin on 8/12/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "MovieListGroupViewController.h"
#import "CustomCollectionViewCell.h"

@interface MovieListGroupViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *groupTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *whiteBackground;

//整個group的標題
@property (retain, nonatomic) NSString *titleString;
//group裡面個別video的標題
@property (retain, nonatomic) NSArray *videoList;
@property (retain, nonatomic) UIImage *coverImage;

@property (nonatomic) BOOL isRefreshed;

@end

@implementation MovieListGroupViewController

- (instancetype)initWithData:(NSString *)title;
{
    
    CGFloat width = [[[[UIApplication sharedApplication]delegate]window]frame].size.width;
    
    if (width == 320) {
        self = [super initWithNibName:@"MovieListGroupViewController" bundle:nil];
    }else if (width == 375) {
        self = [super initWithNibName:@"MovieListGroupViewController_iPhone6" bundle:nil];
    }else if (width == 414){
        self = [super initWithNibName:@"MovieListGroupViewController_iPhone6Plus" bundle:nil];
    }
    
    if (self)
    {
        self.titleString = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoList = @[@"Movie1", @"Movie2", @"Movie3", @"Movie4", @"Movie5", @"Movie6",];
    self.coverImage = [UIImage imageNamed:@"MoviePoster.jpg"];
    
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //設定group title
    //self.groupTitle.text = self.titleString;
    [self.groupTitle setTitle:self.titleString forState:UIControlStateNormal];
    [self.groupTitle addTarget:self action:@selector(moreInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    //設定group的陰影
    [self.whiteBackground.layer setShadowOffset:CGSizeMake(0, 2)];
    [self.whiteBackground.layer setShadowColor:[[UIColor grayColor] CGColor]];
    [self.whiteBackground.layer setShadowRadius:1.0];
    [self.whiteBackground.layer setShadowOpacity:0.5];
    [self.whiteBackground.layer setMasksToBounds:NO];
}

- (IBAction)moreInfo:(UIButton *)sender {
    NSLog(@"更多資訊，開啟另一頁");
}

- (IBAction)refresh:(UIButton *)sender {
    NSLog(@"重新整理，換一批內容");
    
    if (!self.isRefreshed) {
        self.isRefreshed = YES;
        self.videoList = @[@"Drama1", @"Drama2", @"Drama3", @"Drama4", @"Drama5", @"Drama6",];
        self.coverImage = [UIImage imageNamed:@"cover.jpg"];
    }else{
        self.isRefreshed = NO;
        self.videoList = @[@"Movie1", @"Movie2", @"Movie3", @"Movie4", @"Movie5", @"Movie6",];
        self.coverImage = [UIImage imageNamed:@"MoviePoster.jpg"];
    }
    
    [self.collectionView reloadData];
}

#pragma - mark UICollectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1; // The number of sections
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //防呆：避免超過最大值
    //return self.videoList.count < self.panelItem.displayCount ? self.videoList.count : self.panelItem.displayCount;
    return self.videoList.count;
}

- (CustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
    
    if (self.videoList.count > indexPath.row)
    {
        //設定title
        cell.title.text = self.videoList[indexPath.row];
        //設定圖片
        cell.poster.image = self.coverImage;
        cell.poster.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath = %li", indexPath.row);
    //轉導到指定頁面    
}

@end
