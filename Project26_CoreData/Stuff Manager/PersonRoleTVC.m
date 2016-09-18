//
//  PersonRoleTVC.m
//  Stuff Manager
//
//  Created by Kuan-Wei Lin on 9/27/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import "PersonRoleTVC.h"
#import "AppDelegate.h"
#import "AddPersonTVC.h"

@interface PersonRoleTVC ()
@property (strong) NSMutableArray *roles;

@end

@implementation PersonRoleTVC

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Role"];
    self.roles = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.roles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObjectContext *role = [self.roles objectAtIndex:indexPath.row];
    [cell.textLabel setText:[role valueForKey:@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSManagedObjectContext *role = [self.roles objectAtIndex:indexPath.row];
    
    self.selectedRole = [self.roles objectAtIndex:indexPath.row];
    
    NSLog(@"The PersonRoleTVC reports that the %@ role was selected", self.selectedRole.name);
    [self.delegate roleWasSelectedOnPersonRoleTVC:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    /*MyViewController *view = [segue destinationViewController];
     [view passData:self.textBox.text];*/
    
    /*
    if ([segue.identifier isEqualToString:@"update"]){
        NSManagedObject *selectedRole = [self.roles objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        AddRoleTVC *destViewController = segue.destinationViewController;
        destViewController.role = selectedRole;
    }
     */
}



@end
