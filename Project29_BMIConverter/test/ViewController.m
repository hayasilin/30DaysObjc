//
//  ViewController.m
//  test
//
//  Created by Kuan-Wei Lin on 2/23/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)convertAction:(id)sender {
    
    NSString *heightStr = self.heightField.text;
    NSString *weightStr = self.weightField.text;
    
    float cmFloat = [heightStr floatValue];
    float kgFloat = [weightStr floatValue];
    
    if (!heightStr.length && !weightStr.length) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You can't leave empty textfield." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
    
        BMICalc *calc = [[BMICalc alloc] init];
        float bmiFloat = [calc bmiCalc:cmFloat weight:kgFloat];
        
        NSString *bmiStr = [calc bmiStr:bmiFloat];
        
        self.bmiResultLabel.text = bmiStr;
        
        if (bmiFloat < 18) {
            self.judgeLabel.text = @"體重過輕";
        }else if (bmiFloat < 24){
            self.judgeLabel.text = @"正常";
        }else if (bmiFloat < 27){
            self.judgeLabel.text = @"輕度肥胖";
        }else if (bmiFloat < 30){
            self.judgeLabel.text = @"中度肥胖";
        }else{
            self.judgeLabel.text = @"重度肥胖";
        }
    }
}

- (IBAction)resetAction:(id)sender {
    self.heightField.text = nil;
    self.weightField.text = nil;
    self.bmiResultLabel.text = @"Please enter the data above";
    self.judgeLabel.text = nil;
}
@end
