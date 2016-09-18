//
//  AddPersonTVC.m
//  Stuff Manager
//
//  Created by Kuan-Wei Lin on 9/27/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import "AddPersonTVC.h"
#import "Person+CoreDataProperties.h"
#import "AppDelegate.h"

@interface AddPersonTVC ()

@end

@implementation AddPersonTVC
@synthesize selectedRole;

-(NSManagedObjectContext *) managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector: @selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)save:(id)sender{
    //NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.person) {
        // Update existing device
        [self.person setValue:self.firstNameField.text forKey:@"firstName"];
        [self.person setValue:self.lastNameField.text forKey:@"lastName"];
        self.person.inRole = selectedRole;
    }else{
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                   inManagedObjectContext:context];
        [person setValue:self.firstNameField.text forKey:@"firstName"];
        [person setValue:self.lastNameField.text forKey:@"lastName"];
        person.inRole = selectedRole;
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't save %@ %@", error, [error localizedDescription]);
    }
    [self.delegate theSaveButtonOnThePersonDetailTVCWasTapped:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.firstNameField setText:[self.person valueForKey:@"firstName"]];
    [self.lastNameField setText:[self.person valueForKey:@"lastName"]];
    self.personRoleTableViewCell.textLabel.text = self.person.inRole.name;
    self.selectedRole = self.person.inRole;// ensure null role doesn't get saved.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"update"])
    {
        NSLog(@"Setting AddPersonTVC as a delegate of PersonRoleTVC");
        PersonRoleTVC *personRoleTVC = segue.destinationViewController;
        personRoleTVC.delegate = self;
        personRoleTVC.managedObjectContext = self.managedObjectContext;
    }
    else {
        NSLog(@"Unidentified Segue Attempted!");
    }
}

#pragma mark - PersonRoleTVCDelegate
- (void)roleWasSelectedOnPersonRoleTVC:(PersonRoleTVC *)controller
{
    self.personRoleTableViewCell.textLabel.text = controller.selectedRole.name;
    self.selectedRole = controller.selectedRole;
    NSLog(@"PersonDetailTVC reports that the %@ role was selected on the PersonRoleTVC", controller.selectedRole.name);
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
