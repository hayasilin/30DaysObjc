//
//  HomeViewController.m
//  spotifyVideoBackground
//
//  Created by Kuan-Wei Lin on 4/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UILabel *mylabel;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *controllerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    controllerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:controllerView];
    
    [self.view.layer insertSublayer:self.playerLayer below:controllerView.layer];
    
    self.firstButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.firstButton setTitle:@"Log In" forState:UIControlStateNormal];
    self.firstButton.frame = CGRectMake(CGRectGetMidX(self.playerLayer.frame) - 150, CGRectGetMaxY(self.playerLayer.frame) - 100, 300, 40);
    self.firstButton.backgroundColor = [UIColor greenColor];
    self.firstButton.tintColor = [UIColor whiteColor];
    self.firstButton.layer.cornerRadius = 5;
    [self.firstButton addTarget:self action:@selector(theAction:) forControlEvents:UIControlEventTouchUpInside];
    [controllerView addSubview:self.firstButton];
    
    // loop movie
    self.playerLayer.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(replayMovie:)
                                                 name: AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}

- (void)theAction:(id)sender
{
    NSLog(@"Button Tapped");
}

-(AVPlayerLayer*)playerLayer
{
    if(!_playerLayer)
    {
        // find movie file
        NSURL *moviePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"moments" ofType:@"mp4"]];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:[[AVPlayer alloc]initWithURL:moviePath]];
        _playerLayer.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [_playerLayer.player play];
    }
    return _playerLayer;
}

-(void)replayMovie:(NSNotification *)notification
{
    AVPlayerItem *repeatPlayer = [notification object];
    [repeatPlayer seekToTime:kCMTimeZero];
}

@end
