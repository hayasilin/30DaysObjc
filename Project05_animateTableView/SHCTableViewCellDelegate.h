//
//  SHCTableViewCellDelegate.h
//  animateTableView
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCToDoItem.h"

// A protocol that the SHCTableViewCell uses to inform of state change
@protocol SHCTableViewCellDelegate <NSObject>

// indicates that the given item has been deleted
-(void) toDoItemDeleted:(SHCToDoItem*)todoItem;

@end
