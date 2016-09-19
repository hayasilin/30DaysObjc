//
//  ViewController.m
//  KWMarqueeScrollingLabelView_Demo
//
//  Created by Kuan-Wei Lin on 8/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

//Kuan-Wei
#import "KWMarqueeScrollingLabelView.h"

@interface ViewController ()

@property (strong, nonatomic) KWMarqueeScrollingLabelView *navigationBarScrollingLabel;

@property (strong, nonatomic) KWMarqueeScrollingLabelView *scrollingLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *titleString = @"This is a long long..........long........long....title";
    
    [self implementNavigationBarScrollingLabelView:titleString];
}

- (void)implementNavigationBarScrollingLabelView:(NSString *)title{
    //Kuan-Wei: - 影片的標題字跑馬燈模組功能
    
    //只有右邊有BarButtonItem時，那麼可以設定較長的ScrollingLabel，如此ScrollingLabel將會把navigaionItem.titleView撐大，充分利用所有navigaionItem上的空間
    self.navigationBarScrollingLabel = [[KWMarqueeScrollingLabelView alloc] initWithFrame:CGRectMake(0,0,400,32)];
    
    self.navigationBarScrollingLabel.text = title;
    self.navigationBarScrollingLabel.textColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1];
    self.navigationBarScrollingLabel.font = [UIFont fontWithName:@"ArialMT" size:18.0f];
    self.navigationBarScrollingLabel.pauseInterval = 1;
    
    //在此設定200表示如果電影標題字串長度小於200則該View會置中，如果大於200則會靠左對齊，解決過長的字串蓋到back button的問題
    self.navigationBarScrollingLabel.labelTextLength = 200;
    
    [self.navigationBarScrollingLabel observeApplicationNotifications];
    
    self.navigationItem.titleView = self.navigationBarScrollingLabel;
}

- (void)implementScrollingLabelViewInView:(NSString *)title{
    
    //仍有問題，待研究
    self.scrollingLabel = [[KWMarqueeScrollingLabelView alloc] initWithFrame:CGRectMake(50, 100, 200, 32)];
    
    self.scrollingLabel.backgroundColor = [UIColor yellowColor];
    
    self.scrollingLabel.text = title;
    self.scrollingLabel.pauseInterval = 1;
    
    self.scrollingLabel.labelTextLength = 200;
    self.scrollingLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.scrollingLabel observeApplicationNotifications];
    
    [self.view addSubview:self.scrollingLabel];
    
}

@end
