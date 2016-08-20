//
//  ViewController.m
//  EmojiSlotMachine
//
//  Created by Kuan-Wei Lin on 8/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *slotPickerView;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UILabel *bingoLabel;

@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSMutableArray *dataArray1;
@property (strong, nonatomic) NSMutableArray *dataArray2;
@property (strong, nonatomic) NSMutableArray *dataArray3;

@property (nonatomic) CGRect bounds;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bounds = self.goButton.bounds;
    
    self.imageArray = @[@"👻",@"👸",@"💩",@"😘",@"🍔",@"🤖",@"🍟",@"🐼",@"🚖",@"🐷"];
    
    self.dataArray1 = [NSMutableArray array];
    self.dataArray2 = [NSMutableArray array];
    self.dataArray3 = [NSMutableArray array];
    
    for (int i = 0; i < 100 ; i++) {
        NSNumber *n1 = [NSNumber numberWithInt:arc4random() % 10];
        [self.dataArray1 addObject:n1];
        NSNumber *n2 = [NSNumber numberWithInt:arc4random() % 10];
        [self.dataArray2 addObject:n2];
        NSNumber *n3 = [NSNumber numberWithInt:arc4random() % 10];
        [self.dataArray3 addObject:n3];
    }
    
    self.bingoLabel.text = @"";

    self.slotPickerView.delegate = self;
    self.slotPickerView.dataSource = self;

    self.goButton.layer.cornerRadius = 6;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.goButton.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.goButton.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UIPickerViewDatasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 100.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *pickerLabel = [[UILabel alloc] init];
    
    if (component == 0)
    {
        pickerLabel.text = self.imageArray[[self.dataArray1[row] intValue]];
    }
    else if (component == 1)
    {
        pickerLabel.text = self.imageArray[[self.dataArray2[row] intValue]];
    }
    else
    {
        pickerLabel.text = self.imageArray[[self.dataArray3[row] intValue]];
    }

    pickerLabel.font = [UIFont fontWithName:@"Apple Color Emoji" size:80];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    
    return pickerLabel;
}

- (IBAction)goButtonPressed:(UIButton *)sender {
    
    [self.slotPickerView selectRow:arc4random() % 90 + 3 inComponent:0 animated:YES];
    [self.slotPickerView selectRow:arc4random() % 90 + 3 inComponent:1 animated:YES];
    [self.slotPickerView selectRow:arc4random() % 90 + 3 inComponent:2 animated:YES];
    
    if (self.dataArray1[[self.slotPickerView selectedRowInComponent:0]] == self.dataArray2[[self.slotPickerView selectedRowInComponent:1]] && self.dataArray2[[self.slotPickerView selectedRowInComponent:1]] == self.dataArray3[[self.slotPickerView selectedRowInComponent:2]]) {
        
        self.bingoLabel.text = @"Bingo!";
        NSLog(@"Bingo!");
    }else{
        self.bingoLabel.text = @"💔";
    }
    
    //animate
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveLinear animations:^{
       
        self.goButton.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width + 20, self.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.goButton.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
    }];

}

@end
