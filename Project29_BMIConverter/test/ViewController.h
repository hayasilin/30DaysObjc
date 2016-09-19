//
//  ViewController.h
//  test
//
//  Created by Kuan-Wei Lin on 2/23/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMICalc.h"

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *heightField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UILabel *bmiResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *judgeLabel;

- (IBAction)convertAction:(id)sender;
- (IBAction)resetAction:(id)sender;

@end

