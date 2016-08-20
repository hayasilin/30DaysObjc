//
//  SHCTableViewCell.h
//  animateTableView
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCToDoItem.h"
#import "SHCTableViewCellDelegate.h"

@interface SHCTableViewCell : UITableViewCell

// The item that this cell renders.
@property (nonatomic) SHCToDoItem *todoItem;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<SHCTableViewCellDelegate> delegate;


@end
