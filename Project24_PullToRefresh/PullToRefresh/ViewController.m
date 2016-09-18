//
//  ViewController.m
//  PullToRefresh
//
//  Created by Kuan-Wei Lin on 9/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"Hello world";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    NSDictionary *attributedDict = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSRange range = NSMakeRange(0, [string length]);
    [string setAttributes:attributedDict range:range];
    
    UIFont *markerFeltWide = [UIFont fontWithName:@"MarkerFelt-Wide" size:50.0f];
    //字型
    [string addAttribute:NSFontAttributeName value:markerFeltWide range:range];
    //前景顏色
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    //背景顏色
    [string addAttribute:NSBackgroundColorAttributeName value:[UIColor grayColor] range:range];
    //底線
    [string addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:range];
    
    //字間距
    [string addAttribute:NSKernAttributeName value:[NSNumber numberWithInt:0] range:range];
    //陰影
    NSShadow *shadowDic=[[NSShadow alloc] init];
    [shadowDic setShadowBlurRadius:3.0]; //0 ~ ? 清晰～模糊
    [shadowDic setShadowColor:[UIColor blackColor]];
    [shadowDic setShadowOffset:CGSizeMake(3, 3)];
    [string addAttribute:NSShadowAttributeName value:shadowDic range:range];
    //描邊顏色
    [string addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:range];
    //描邊線條粗細 正數描邊 負數描邊加填滿
    [string addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithInt:-3.0] range:range];
    
    //Another way
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[[UIFont fontWithName:@"Helvetica-Bold" size:45.0f], [UIColor greenColor], [UIColor redColor], [NSNumber numberWithFloat:-3.0]] forKeys:@[NSFontAttributeName, NSForegroundColorAttributeName, NSStrokeColorAttributeName, NSStrokeWidthAttributeName]];
    [string addAttributes:dict range:NSMakeRange(0,string.length)];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 , 85, 300, 150)];
    label.attributedText = string;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
