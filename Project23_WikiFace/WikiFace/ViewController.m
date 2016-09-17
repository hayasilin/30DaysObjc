//
//  ViewController.m
//  WikiFace
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import "WikiFaceManager.h"

@interface ViewController () <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameInputTextField;
@property (weak, nonatomic) IBOutlet UIImageView *wikiFaceImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameInputTextField.delegate = self;
    self.wikiFaceImageView.alpha = 0;
    self.wikiFaceImageView.transform = CGAffineTransformMakeScale(0.2, 0.2);
}

- (void)fireWikiFaceManager
{
    NSString *textFieldContent = self.nameInputTextField.text;
    
    if ([textFieldContent length] > 0)
    {
        WikiFaceManager *manager = [[WikiFaceManager alloc] init];
        
        [manager faceForPerson:textFieldContent size:CGSizeMake(300, 400) complete:^(UIImage *image, BOOL imageFound) {
            
            if (imageFound)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.wikiFaceImageView.image = image;
                    
                    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        
                        self.wikiFaceImageView.transform = CGAffineTransformMakeScale(1, 1);
                        self.wikiFaceImageView.alpha = 1;
                        
                    } completion:^(BOOL finished) {
                        
                        //[manager centerImageViewOnFace:self.wikiFaceImageView];
                    }];
                });
            }
            else
            {
                NSLog(@"The wiki image is not found");
            }
        }];
    }
    else
    {
        NSLog(@"Please input something");
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self fireWikiFaceManager];
    
    return YES;
}

#pragma mark - IBAction
- (IBAction)findImage:(UIButton *)sender
{
    [self.nameInputTextField resignFirstResponder];
    
    [self fireWikiFaceManager];
}

- (IBAction)resetImage:(UIButton *)sender
{
    [UIView animateWithDuration:1 animations:^{
        self.wikiFaceImageView.alpha = 0;
    }];
    
}



@end
