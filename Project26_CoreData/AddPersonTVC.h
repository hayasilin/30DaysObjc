//
//  AddPersonTVC.h
//  Stuff Manager
//
//  Created by Kuan-Wei Lin on 9/27/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataProperties.h"
#import "Role+CoreDataProperties.h"
#import "PersonRoleTVC.h"

@class AddPersonTVC;
@protocol AddPersonTVCDelegate <NSObject>

- (void)theSaveButtonOnThePersonDetailTVCWasTapped:(AddPersonTVC *)controller;

@end

@interface AddPersonTVC : UITableViewController <PersonRoleTVCDelegate>

@property (nonatomic, weak) id <AddPersonTVCDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Person *person;
@property (strong, nonatomic) Role *selectedRole;

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITableViewCell *personRoleTableViewCell;

- (IBAction)save:(id)sender;


@end
