//
//  DetailViewController2.m
//  KWMarqueeScrollingLabelView_Demo
//
//  Created by Kuan-Wei Lin on 8/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "DetailViewController2.h"

#import "KWMarqueeScrollingLabelView.h"

@interface DetailViewController2 ()

@property (strong, nonatomic) KWMarqueeScrollingLabelView *navigationBarScrollingLabel;

@end

@implementation DetailViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *titleString = @"This is a long long..........long.......long...title";
    
    [self implementNavigationBarScrollingLabelView:titleString];
}

- (void)implementNavigationBarScrollingLabelView:(NSString *)title{
    //Kuan-Wei: - 影片的標題字跑馬燈模組功能
    self.navigationBarScrollingLabel = [[KWMarqueeScrollingLabelView alloc] initWithFrame:CGRectMake(0,0,400,32)];
    self.navigationBarScrollingLabel.text = title;
    self.navigationBarScrollingLabel.textColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1];
    self.navigationBarScrollingLabel.font = [UIFont fontWithName:@"ArialMT" size:18.0f];
    self.navigationBarScrollingLabel.pauseInterval = 1;
    
    //在此設定200表示如果電影標題字串長度小於200則該View會置中，如果大於500則會靠左對齊，解決過長的字串蓋到back button的問題
    self.navigationBarScrollingLabel.labelTextLength = 200;
    
    [self.navigationBarScrollingLabel observeApplicationNotifications];
    
    self.navigationItem.titleView = self.navigationBarScrollingLabel;
}

@end
