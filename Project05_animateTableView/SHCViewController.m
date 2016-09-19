//
//  SHCViewController.m
//  animateTableView
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "SHCViewController.h"
#import "SHCTableViewCell.h"

@interface SHCViewController ()

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *toDoItems;

@end

@implementation SHCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create a dummy todo list
    _toDoItems = [[NSMutableArray alloc] init];
    [_toDoItems addObject:@"Feed the cat"];
    [_toDoItems addObject:@"Buy eggs"];
    [_toDoItems addObject:@"Pack bags for WWDC"];
    [_toDoItems addObject:@"Rule the web"];
    [_toDoItems addObject:@"Buy a new iPhone"];
    [_toDoItems addObject:@"Find missing socks"];
    [_toDoItems addObject:@"Write a new tutorial"];
    [_toDoItems addObject:@"Master Objective-C"];
    [_toDoItems addObject:@"Remember your wedding anniversary!"];
    [_toDoItems addObject:@"Drink less beer"];
    [_toDoItems addObject:@"Learn to draw"];
    [_toDoItems addObject:@"Take the car to the garage"];
    [_toDoItems addObject:@"Sell things on eBay"];
    [_toDoItems addObject:@"Learn to juggle"];
    [_toDoItems addObject:@"Give up"];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerClass:[SHCTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    SHCTableViewCell *cell = (SHCTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    // Configure the cell...
    cell.textLabel.text = self.toDoItems[indexPath.row];
    
    // find the to-do item for this index
    SHCToDoItem *item = self.toDoItems[indexPath.row];
    
    cell.delegate = self;
    cell.todoItem = item;
    
    return cell;
}

-(void)toDoItemDeleted:(id)todoItem {
    // use the UITableView to animate the removal of this row
    NSUInteger index = [self.toDoItems indexOfObject:todoItem];
    [self.tableView beginUpdates];
    [self.toDoItems removeObject:todoItem];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}


-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = self.toDoItems.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

#pragma mark - UITableViewDataDelegate protocol methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
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
