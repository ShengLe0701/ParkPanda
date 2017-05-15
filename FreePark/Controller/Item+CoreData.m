//
//  Item+CoreData.m
//  ui-searchcontroller-objc
//
//  Created by Clint Cabanero on 9/26/14.
//  Copyright (c) 2014 Big Leaf Mobile LLC. All rights reserved.
//

#import "Item+CoreData.h"

@implementation Item


+ (NSArray *)fetchDistinctItemGroupsInManagedObjectContext:(NSMutableArray *)managedObjectContext {
    
    
    NSMutableSet *firstCharacters = [NSMutableSet setWithCapacity:0];
    for( NSString*string in managedObjectContext ){
        [firstCharacters addObject:[[string substringToIndex:1] uppercaseString]];
    }
    NSArray *allLetters = [[firstCharacters allObjects] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    int indexLetter = 0;
    NSMutableArray *separeNamesByLetters = [NSMutableArray new];
    
    
    
    for (NSString *letter in allLetters) {
        NSMutableDictionary*userBegeinsWith = [NSMutableDictionary new];
        [userBegeinsWith setObject:letter forKey:@"group"];
        NSMutableArray *groupNameByLetters = [NSMutableArray new];
        NSString *compareLetter1 = [NSString stringWithFormat:@"%@", allLetters[indexLetter]];
        for (NSString*friendName in managedObjectContext) {
            NSString *compareLetter2 = [[friendName substringToIndex:1] uppercaseString];
            
            if ( [compareLetter1 isEqualToString:compareLetter2] ) {
                [groupNameByLetters addObject:friendName];
            }
        }
        indexLetter++;
        [userBegeinsWith setObject:groupNameByLetters forKey:@"list"];
        [separeNamesByLetters addObject: userBegeinsWith];
    }

    
    
    NSArray *results = [[NSArray alloc] init];
    
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:separeNamesByLetters.count];
    
    for(NSDictionary *currentDictionary in separeNamesByLetters) {
        
        [mutableArray addObject:[currentDictionary objectForKey:@"group"]];
    }
    
    results = [NSArray arrayWithArray:mutableArray];
    
    return results;
}

+ (NSArray *)fetchItemNamesBeginningWith:(NSString *)searchText inManagedObjectContext:(NSMutableArray *)managedObjectContext {
    
    NSArray *results = [[NSArray alloc] init];
    
    NSMutableArray *compares = [NSMutableArray new];
    for( NSString*string in managedObjectContext ){
        NSRange range = [string rangeOfString:searchText];
        if( range.location != NSNotFound && range.location == 0 )
        {
            [compares addObject:string];
        }
    }
    
    //serialize to an array of name string objects
    NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:compares.count];
    
    for(NSString *currentItem in compares) {
        
        //add the item name
        [names addObject:currentItem];
    }
    
    //serialize to non-mutable
    results = [NSArray arrayWithArray: names];
    
    return results;
}

+ (NSArray *)fetchItemNamesByGroupInManagedObjectContext:(NSMutableArray *)managedObjectContext {
    
    NSArray *results = [[NSArray alloc] init];
    
    
    //groups
    NSArray *itemGroups = [Item fetchDistinctItemGroupsInManagedObjectContext:managedObjectContext];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:itemGroups.count];
    
    for(NSString *group in itemGroups) {
        
        //items in group
        NSArray *groupItems = [Item fetchItemNamesBeginningWith:group inManagedObjectContext:managedObjectContext];
        
        
        //create item and group structure
        NSDictionary *itemAndGroup = [[NSDictionary alloc] initWithObjectsAndKeys:groupItems, group, nil];
        
        [mutableArray addObject:itemAndGroup];
    }
    
    //serialize to non-mutable
    results = [NSArray arrayWithArray:mutableArray];

    return results;
}

+ (NSDictionary *)fetchItemNamesByGroupFilteredBySearchText:(NSString *)searchText inManagedObjectContext:(NSMutableArray *)managedObjectContext {
    
    NSDictionary *result = nil;
    
    //to be used as the key for the returned NSDictionary
    NSString *firstLetterOfSearchText = [[searchText substringToIndex:1] uppercaseString];
    
    NSArray *itemNames = [Item fetchItemNamesBeginningWith:searchText inManagedObjectContext:managedObjectContext];
    
    result = [[NSDictionary alloc] initWithObjectsAndKeys:itemNames, firstLetterOfSearchText, nil];
    
    return result;
}

@end
