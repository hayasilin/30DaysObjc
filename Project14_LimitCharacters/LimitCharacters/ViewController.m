//
//  ViewController.m
//  LimitCharacters
//
//  Created by Kuan-Wei Lin on 8/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *countCharacterLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomUIView;

@end

@implementation ViewController

//Only for iOS 9
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *myTextViewString = self.tweetTextView.text;
    NSUInteger characterCount = [myTextViewString length];
    NSUInteger count = 140 - characterCount;
    self.countCharacterLabel.text = [NSString stringWithFormat:@"%li", count];
    
    if (range.length > 140) {
        return NO;
    }
    
    NSUInteger newLength = characterCount + range.length;
    return newLength < 140;
}

- (void)keyBoardWillShow:(NSNotification *)note{
    
    NSDictionary *userInfo = note.userInfo;
    NSString *keyBoardString = userInfo[UIKeyboardFrameEndUserInfoKey];
    NSLog(@"%@", keyBoardString);

    NSValue *nsValue = (NSValue *)keyBoardString;
    NSLog(@"%@", nsValue);
    
    CGRect keyBoardBounds = [nsValue CGRectValue];
    
    NSString *durationString = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSLog(@"%@", durationString);
    double duration = [durationString doubleValue];
    
    CGFloat deltaY = keyBoardBounds.size.height;
    
    
    void(^animations)() = ^void(){
        self.bottomUIView.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    };
    
    if (duration > 0) {
        UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut;
        
        [UIView animateWithDuration:duration delay:0 options:options animations:animations completion:nil];
    }else{
        animations();
    }
}

- (void)keyBoardWillHide:(NSNotification *)note{
    
    NSDictionary *userInfo = note.userInfo;
    
    NSString *animationDurationUserInfo = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    
    double duration = [animationDurationUserInfo doubleValue];
    
    void(^animations)() = ^void(){
        self.bottomUIView.transform = CGAffineTransformIdentity;
    };
    
    if (duration > 0) {
        UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut;
        
        [UIView animateWithDuration:duration delay:0 options:options animations:animations completion:nil];
    }else{
        animations();
    }
    
}

- (IBAction)closeAction:(UIButton *)sender {
    [self.view endEditing:YES];
}

@end
