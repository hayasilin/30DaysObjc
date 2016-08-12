//
//  ViewControllerWithTableView.m
//  CustomViewController
//
//  Created by Kuan-Wei Lin on 8/12/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewControllerWithTableView.h"
#import "MovieListGroupViewController.h"

@interface ViewControllerWithTableView ()
{
    //控制分段加載ＵＩ的控制值
    //開始的數值，基本為0
    int breakCreateStartIndex;
    //結束的數值，由後端傳來總共幾個資料，需要建立幾個group
    int breakCreateEndIndex;
    
    NSDate *autoPlayStartTime;
    NSDate *autoPlayEndTime;
}

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSMutableDictionary *groups;
@property (retain, nonatomic) NSMutableDictionary *panelsHieght;

@end

@implementation ViewControllerWithTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ViewControllerWithTableView";
    
    breakCreateStartIndex = -1;
    breakCreateEndIndex = 7;
    
    self.groups = [NSMutableDictionary dictionary];
    self.panelsHieght = [NSMutableDictionary dictionary];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self performSelector:@selector(createGroups) withObject:nil afterDelay:0];
}

#pragma mark * UI *
- (void)createGroups
{
    [self createPanelsWithStartIndex:breakCreateStartIndex to:breakCreateEndIndex];
    [self.tableView reloadData];
}

- (void)createPanelsWithStartIndex:(int)startIndex to:(int)endIndex
{
    for (int i = startIndex; i < endIndex + 1; i++)
    {
        UIViewController *groupVC = [self.groups objectForKey:@(i)];
        if (groupVC)
        {
            if (groupVC.view.hidden)
            {
                [self.panelsHieght setObject:@(0) forKey:@(i)];
            }
            else
            {
                [self.panelsHieght setObject:@(groupVC.view.frame.size.height) forKey:@(i)];
            }
            continue;
        }
        //根據各個type去創 group
        [self createGroupWithIndex:@(i)];
    }
}

- (void)createGroupWithIndex:(NSNumber *)index
{
    UIViewController *groupVC;
    
    switch ([index intValue]) {
        case 0:
            NSLog(@"0");
            groupVC = [[MovieListGroupViewController alloc] initWithData:@"title1"];
            
            break;
        case 1:
            NSLog(@"1");
            groupVC = [[MovieListGroupViewController alloc] initWithData:@"title2"];
            
            break;
        case 2:
            NSLog(@"2");
            groupVC = [[MovieListGroupViewController alloc] initWithData:@"title3"];
            
            break;
        case 3:
            NSLog(@"3");
            groupVC = [[MovieListGroupViewController alloc] initWithData:@"title4"];
            
            break;
        case 4:
            NSLog(@"4");
            groupVC = [[MovieListGroupViewController alloc] initWithData:@"title5"];
            
            break;
        case 5:
            NSLog(@"5");
            groupVC = [[MovieListGroupViewController alloc] initWithData:@"title6"];
            
            break;
        case 6:
            NSLog(@"6");
            groupVC = [[MovieListGroupViewController alloc] initWithData:@"title7"];
            
            break;
        default:
            break;
    }
    
    //如果有創出來就加進groups裡
    if (groupVC)
    {
        [self.groups setObject:groupVC forKey:index];
        //已有創出來的最後一個地下一個當下次的第一個
        breakCreateStartIndex = (int)index.integerValue + 1;
        NSLog(@"groupVC height = %f", groupVC.view.frame.size.height);
        [self.panelsHieght setObject:@(groupVC.view.frame.size.height) forKey:index];
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //全部預留一格
    return breakCreateEndIndex + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1; //ㄧ個section ㄧ個cell
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //讀取這個group的高
    NSNumber *hieght = [self.panelsHieght objectForKey:@(indexPath.section)];
    if (hieght)
    {
        return hieght.floatValue;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIViewController *group = [self.groups objectForKey:@(indexPath.section)];
    cell.frame = group.view.frame;
    [cell addSubview:group.view];
    
    
    return cell;
}

@end
