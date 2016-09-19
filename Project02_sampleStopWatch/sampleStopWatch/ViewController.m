//
//  ViewController.m
//  sampleStopWatch
//
//  Created by Kuan-Wei Lin on 4/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countingLabel;
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIButton *pause;

@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIButton *resetButton;
//@property (strong, nonatomic) UILabel *timerLabel;

@end

@implementation ViewController{
    float counter;
    NSTimer *timer;
    Boolean isPlaying;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    counter = 0.0;
    timer = [[NSTimer alloc] init];
    isPlaying = NO;
    
//    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMinY(self.view.frame) + 50, 200, 50)];
//    self.timerLabel.text = [NSString stringWithFormat:@"%.f", counter];
//    self.timerLabel.tintColor = [UIColor darkGrayColor];
//    self.timerLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.timerLabel];
//
//    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 25, CGRectGetMidY(self.view.frame), 50, 50)];
//    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
//    [self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.playButton];
//    
//    self.pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 25, CGRectGetMidY(self.view.frame) + 50, 50, 50)];
//    [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
//    [self.pauseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.pauseButton addTarget:self action:@selector(pauseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.pauseButton];
//    
//    self.resetButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 25, CGRectGetMidY(self.view.frame) - 50, 50, 50)];
//    [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
//    [self.resetButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self.resetButton addTarget:self action:@selector(resetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.resetButton];
}

- (void)playButtonClicked: (id)sender{
    if (isPlaying) {
        return;
    }
    
    self.playButton.hidden = YES;
    self.pauseButton.hidden = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    isPlaying = YES;
}

- (void)pauseButtonClicked: (id)sender{
    self.playButton.hidden = NO;
    self.pauseButton.hidden = YES;
    [timer invalidate];
    isPlaying = NO;
}

- (void)resetButtonClicked: (id)sender{
    [timer invalidate];
    isPlaying = NO;
    counter = 0.0;
    //self.timerLabel.text = [NSString stringWithFormat:@"%.1f", counter];
    self.countingLabel.text = [NSString stringWithFormat:@"%.1f", counter];
    self.playButton.hidden = NO;
    self.pauseButton.hidden = YES;
}

- (void)updateTimer{
    counter = counter + 0.1;
//    self.timerLabel.text = [NSString stringWithFormat:@"%.1f", counter];
    self.countingLabel.text = [NSString stringWithFormat:@"%.1f", counter];
}

- (IBAction)play:(UIButton *)sender
{
    [self playButtonClicked:nil];
    
    self.play.enabled = NO;
    self.play.alpha = 0.6;
    
    self.pause.enabled = YES;
    self.pause.alpha = 1;
}

- (IBAction)pause:(id)sender
{
    [self pauseButtonClicked:nil];
    
    self.play.enabled = YES;
    self.play.alpha = 1;
    
    self.pause.enabled = NO;
    self.pause.alpha = 0.6;
}

- (IBAction)reset:(id)sender
{
    [self resetButtonClicked:nil];
    
    self.play.enabled = YES;
    self.play.alpha = 1;
    
    self.pause.enabled = NO;
    self.pause.alpha = 0.6;
}


@end
