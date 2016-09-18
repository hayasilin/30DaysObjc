//
//  PersonRoleTVC.h
//  Stuff Manager
//
//  Created by Kuan-Wei Lin on 9/27/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Role.h"
#import "Person.h"

@class PersonRoleTVC;
@protocol PersonRoleTVCDelegate
- (void)roleWasSelectedOnPersonRoleTVC:(PersonRoleTVC *)controller;
@end

@interface PersonRoleTVC : UITableViewController

@property (nonatomic, weak) id <PersonRoleTVCDelegate> delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Role *selectedRole;

@end
