//
//  FirstTableViewController.m
//  TabBar
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "FirstTableViewController.h"
#import "ArticleTableViewCell.h"

@interface FirstTableViewController ()

@property (strong, nonatomic) NSArray *profileImageArray;
@property (strong, nonatomic) NSArray *nameArray;
@property (strong, nonatomic) NSArray *contentArray;
@property (strong, nonatomic) NSArray *contentImageArray;

@end

@implementation FirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.profileImageArray = @[@"allen", @"Daniel Hooper", @"davidbeckham", @"bruce", @"allen"];
    self.nameArray = @[@"Allen Wang", @"Daniel Hooper", @"David Beckham", @"Bruce Fan", @"Allen Wang"];
    self.contentArray = @[@"Giphy Cam Lets You Create And Share Homemade Gifs", @"Principle. The Sketch of Prototyping Tools", @"Ohlala, An Uber For Escorts, Launches Its ‘Paid Dating’ Service In NYC", @"Lonely Planet’s new mobile app helps you explore major cities like a pro", @"Giphy Cam Lets You Create And Share Homemade Gifs",];
    self.contentImageArray = @[@"giphy", @"my workflow flow", @"Ohlala", @"Lonely Planet", @"giphy"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self animateTable];
}

- (void)animateTable
{
    
    [self.tableView reloadData];
    
    NSArray *cells = self.tableView.visibleCells;
    CGFloat tableHeight = self.tableView.bounds.size.height;
    
    for (UITableViewCell *i in cells) {
        UITableViewCell *cell = i;
        cell.transform = CGAffineTransformMakeTranslation(0, tableHeight);
    }
    
    __block int index = 0;
    
    for (UITableViewCell *a in cells) {
        UITableViewCell *cell = a;
        
        [UIView animateWithDuration:1.0 delay:0.05 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
            
        } completion:^(BOOL finished) {
            
            index+=1;
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = (ArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.nameLabel.text = self.nameArray[indexPath.row];
    cell.contentLabel.text = self.contentArray[indexPath.row];
    cell.profileImageView.image = [UIImage imageNamed:self.profileImageArray[indexPath.row]];
    cell.contentImageView.image = [UIImage imageNamed:self.contentImageArray[indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
