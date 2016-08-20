//
//  VideoListTableViewController.m
//  playLocalVideo
//
//  Created by Kuan-Wei Lin on 4/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//
@import AVKit;
#import "VideoListTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoTableViewCell.h"

@interface VideoListTableViewController ()

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) AVPlayerViewController *playViewController;
@property (strong, nonatomic) AVPlayer *playerView;

@end

@implementation VideoListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"Watch Later";
    
    self.data = @[@"videoScreenshot01", @"videoScreenshot02", @"videoScreenshot03", @"videoScreenshot04", @"videoScreenshot05", @"videoScreenshot06"];
    
    self.playViewController = [[AVPlayerViewController alloc] init];
//    AVPlayer *playerView = [[AVPlayer alloc] init];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.backgroundColor = [UIColor colorWithRed:0.113 green:0.113 blue:0.145 alpha:1];
    
    refreshControl.tintColor = [UIColor whiteColor];
    [self setRefreshControl:refreshControl];
}

- (void)refresh: (id)sender{
    [self.tableView reloadData];
    [(UIRefreshControl *)sender endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];

    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    
    if (!cell) {
    [tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"videoCell"];
    cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    }
    
    // Configure the cell...
    cell.imageView.image = [UIImage imageNamed:self.data[indexPath.row]];
    [[cell playButton] addTarget:self action:@selector(playVideoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)playVideoButtonClicked: (id)sender{
    
    NSLog(@"play clicked");
    NSString *path = [[NSBundle mainBundle]pathForResource:@"emoji zone" ofType:@"mp4"];
    NSLog(@"path = %@", path);
    self.playerView = [[AVPlayer alloc]initWithURL:[NSURL fileURLWithPath:path]];
    self.playViewController.player = self.playerView;
    [self presentViewController:self.playViewController animated:YES completion:^{
        [self.playViewController.player play];
    }];
}

@end
