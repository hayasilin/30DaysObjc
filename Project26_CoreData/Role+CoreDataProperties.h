//
//  Role+CoreDataProperties.h
//  Stuff Manager
//
//  Created by Kuan-Wei Lin on 9/27/15.
//  Copyright © 2015 Kuan-Wei Lin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Role.h"

NS_ASSUME_NONNULL_BEGIN

@interface Role (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Person *> *heldBy;

@end

@interface Role (CoreDataGeneratedAccessors)

- (void)addHeldByObject:(Person *)value;
- (void)removeHeldByObject:(Person *)value;
- (void)addHeldBy:(NSSet<Person *> *)values;
- (void)removeHeldBy:(NSSet<Person *> *)values;

@end

NS_ASSUME_NONNULL_END
