//
//  SHCToDoItem.m
//  animateTableView
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "SHCToDoItem.h"

@implementation SHCToDoItem

-(id)initWithText:(NSString*)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

+(id)toDoItemWithText:(NSString *)text {
    return [[SHCToDoItem alloc] initWithText:text];
}


@end
