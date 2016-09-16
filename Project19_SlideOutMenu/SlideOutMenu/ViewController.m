//
//  ViewController.m
//  SlideOutMenu
//
//  Created by Kuan-Wei Lin on 9/16/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *menuHolder;
@property (strong, nonatomic) UIView *menuBackgroundHolder;

@property (strong, nonatomic) UITableView *menuTable;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Menu tableView data
    self.dataArray = @[@"我的文章", @"待讀文章"];
    
    //Create menuHolderView and menuBackgroundHolderView
    self.menuHolder = [[UIView alloc] initWithFrame:CGRectMake(-250, 0, 250, self.view.frame.size.height)];
    self.menuBackgroundHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.menuBackgroundHolder.hidden = YES;
    
    self.menuHolder.backgroundColor = [UIColor clearColor];
    self.menuBackgroundHolder.backgroundColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:0.3];
    
    [self.view addSubview:self.menuBackgroundHolder];
    [self.view addSubview:self.menuHolder];
    
    //Create gestureRecognizer
    UISwipeGestureRecognizer * swiperight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
    
    UISwipeGestureRecognizer * swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    [self.menuBackgroundHolder addGestureRecognizer:tapRecognizer];
    
    //Create menuTableView
    self.menuTable = [[UITableView alloc] initWithFrame:self.menuHolder.bounds style:UITableViewStylePlain];
    [self.menuTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    self.menuTable.backgroundColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:0.9];
    self.menuTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.menuTable.tableHeaderView.backgroundColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:0.3];
    ;
    
    [self.menuHolder addSubview:self.menuTable];    
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    self.menuBackgroundHolder.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.menuHolder.frame = CGRectMake(0, 0, 250, self.view.frame.size.height);
    }];
}


-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    self.menuBackgroundHolder.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.menuHolder.frame = CGRectMake(-250, 0, 250, self.view.frame.size.height);
    }];
}

- (void)singleTapped:(UITapGestureRecognizer*)sender {
    self.menuBackgroundHolder.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.menuHolder.frame = CGRectMake(-250, 0, 250, self.view.frame.size.height);
    }];
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Defaule UITableViewCell syntax
    UITableViewCell *cell = [self.menuTable dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    // Configure the cell...
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:0.1];

    
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
    
    UIViewController *vc;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (indexPath.row == 0)
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"articleVC"];
    }
    else
    {
        vc = [storyboard instantiateViewControllerWithIdentifier:@"readitlaterVC"];
    }
    
    // Display the selected view controller
    [self presentViewController:vc animated:YES completion:nil];
    [self swipeleft:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
}

// Set the view for each cell with a clear color
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)]; //
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
