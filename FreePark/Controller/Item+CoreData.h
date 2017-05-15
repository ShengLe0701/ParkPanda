//
//  Item+CoreData.h
//  ui-searchcontroller-objc
//
//  Created by Clint Cabanero on 9/26/14.
//  Copyright (c) 2014 Big Leaf Mobile LLC. All rights reserved.
//

@interface Item : NSObject

/*!
 * @description For fetching a collection of distinct 'group' attributes across all instances of the Item entity
 * @param managedObjectContext The CoreData NSManagedObjectContext.
 * @return NSArray of Item entity objects.
 */
+ (NSArray *)fetchDistinctItemGroupsInManagedObjectContext:(NSMutableArray *)managedObjectContext;

/*!
 * @description For fetching a NSArray of Item names beginning with the passed in search text.
 * @param searchText The search text used to filter the returned item names.
 * @param managedObjectContext The CoreData NSManagedObjectContext.
 * @return NSArray of string objects representing item names.
 */
+ (NSArray *)fetchItemNamesBeginningWith:(NSString *)searchText inManagedObjectContext:(NSMutableArray *)managedObjectContext;

/*!
 * @description For fetching a collection of NSDictionaries where the key is the Group and the value is a collection of Item Names.
 * @param managedObjectContext The CoreData NSManagedObjectContext.
 * @return NSArray of NSDictionaries.
 */
+ (NSArray *)fetchItemNamesByGroupInManagedObjectContext:(NSMutableArray *)managedObjectContext;

/*!
 * @description For returning a NSDictionary where the key is the first letter of the input searchText and the value is a NSArray of items string objects that begin with the input searchText.
 * @param managedObjectContext The CoreData NSManagedObjectContext.
 * @return NSDictionary
 */
+ (NSDictionary *)fetchItemNamesByGroupFilteredBySearchText:(NSString *)searchText inManagedObjectContext:(NSMutableArray *)managedObjectContext;

@end
