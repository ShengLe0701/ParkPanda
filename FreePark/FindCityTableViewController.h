//
//  FindCityTableViewController.h
//  FreePark
//
//  Created by LovelyPony on 20/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCityTableViewController : UITableViewController<UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *tableSections;
@property (nonatomic, strong) NSMutableArray *tableSectionsAndItems;

@property (nonatomic, strong) NSMutableArray *mCityInfos;
@property (nonatomic, strong) NSMutableArray *managedObjectContext;
- (IBAction)touchInsideBack:(id)sender;




@end
