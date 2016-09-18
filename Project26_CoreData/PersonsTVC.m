//
//  PersonsTVC.m
//  Stuff Manager
//
//  Created by Kuan-Wei Lin on 9/27/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//

#import "PersonsTVC.h"
#import "AppDelegate.h"

@interface PersonsTVC ()

@property (strong) NSMutableArray *persons;

@end

@implementation PersonsTVC

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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    self.persons = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Person *person = [self.persons objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[person valueForKey:@"firstName"]];
    //[cell.detailTextLabel setText:[person valueForKey:@"lastName"]];
    cell.detailTextLabel.text = person.inRole.name;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.persons objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"Save Success!!");
        }
        
        //Remove device from table view
        [self.persons removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSString *stringToMove = [self.persons objectAtIndex:fromIndexPath.row];    
    [self.persons removeObjectAtIndex:fromIndexPath.row];
    [self.persons insertObject:stringToMove atIndex:toIndexPath.row];
    
//    [self.persons exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Don't move the first row
//    if (indexPath.row == 0){
//        return NO;
//    }
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"update"]){
        Person *selectedPerson = [self.persons objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        AddPersonTVC *destViewController = segue.destinationViewController;
        destViewController.person = selectedPerson;
    }
}

#pragma mark - AddPerTVCDelegate

- (void)theSaveButtonOnThePersonDetailTVCWasTapped:(AddPersonTVC *)controller
{
    // do something here like refreshing the table or whatever
    [self.tableView reloadData];
    // close the delegated view
    //[self.navigationController popViewControllerAnimated:YES];
}

@end
