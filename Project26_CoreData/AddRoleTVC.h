//
//  AddRoleTVC.h
//  Stuff Manager
//
//  Created by Kuan-Wei Lin on 9/26/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Role+CoreDataProperties.h"


@interface AddRoleTVC : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *roleNameField;
@property (strong) NSManagedObject *role;


- (IBAction)save:(id)sender;

@end
