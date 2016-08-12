//
//  SHCToDoItem.h
//  animateTableView
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCToDoItem : NSObject

// A text description of this item.
@property (nonatomic, copy) NSString *text;

// A Boolean value that determines the completed state of this item.
@property (nonatomic) BOOL completed;

// Returns an SHCToDoItem item initialized with the given text.
-(id)initWithText:(NSString*)text;

// Returns an SHCToDoItem item initialized with the given text.
+(id)toDoItemWithText:(NSString*)text;


@end
