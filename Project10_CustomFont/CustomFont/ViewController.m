//
//  ViewController.m
//  CustomFont
//
//  Created by Kuan-Wei Lin on 8/13/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *changeFontButton;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *fontNames;

@property (nonatomic) int fontRowIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"30 Days ObjectiveC", @"The font is choosed from UIFOnt", @"THis project is not for commercial usage", @"Hope you enjoy it", @"haha, good bye🤗 See you next Project", @"kuanwei.hayasi@gmail.com"];

    self.fontNames = @[@"IowanOldStyle-Italic", @"KohinoorTelugu-Regular", @"AvenirNextCondensed-Regular"];
    
    //self.fontNames = [UIFont familyNames];
    
    self.fontRowIndex = 0;
    
    
    NSString *family;
    NSString *font;
    for (family in [UIFont familyNames]) {
        NSLog(@"familyNames count = %li", [[UIFont familyNames] count]);
        for (font in [UIFont fontNamesForFamilyName:family]) {
            NSLog(@"font = %@", font);
        }
    }
    
    NSLog(@"familyNames count = %li", [[UIFont familyNames] count]);
    //NSLog(@"fontNamesForFamilyName count = %li", [[UIFont fontNamesForFamilyName:family] count]);
    
    self.changeFontButton.layer.cornerRadius = 55;
}

- (IBAction)changeFontAction:(UIButton *)sender {
    NSLog(@"Change font!");
    NSLog(@"self.fontRowIndex = %i", self.fontRowIndex);
    //以下表示會照著0, 1 ,2開始跳
    self.fontRowIndex = (self.fontRowIndex + 1) % 3;
    NSLog(@"change fontRowIndex = %i", self.fontRowIndex);
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:self.fontNames[self.fontRowIndex] size:16];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  50;
}


@end
