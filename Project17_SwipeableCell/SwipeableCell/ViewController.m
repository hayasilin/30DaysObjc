//
//  ViewController.m
//  SwipeableCell
//
//  Created by Kuan-Wei Lin on 9/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.dataArray = @[@"Pattern Building", @"Joe Beez", @"Car It's car", @"Floral Kaleidoscopic", @"Sprinkle Pattern", @"Palitos de queso", @"Ready to Go? Pattern", @"Sets Seamless"];

    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"🗑\nDelete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"Delete button tapped");
    }];
    
    delete.backgroundColor = [UIColor grayColor];
    
    UITableViewRowAction *share = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"🤗\nShare" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //id firstActivityItem = self.dataArray[indexPath.row];
        //UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:firstActivityItem applicationActivities:nil];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:self.dataArray applicationActivities:nil];
        
        [self presentViewController:activityViewController animated:YES completion:nil];
    }];
    
    share.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *download = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"⬇️\nDownload" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
       
        NSLog(@"Download button tapped");
        
    }];
    
    download.backgroundColor = [UIColor blueColor];
   
    return @[download, share, delete];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
