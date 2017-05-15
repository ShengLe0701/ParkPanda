//
//  SettingTableViewController.m
//  FreePark
//
//  Created by LovelyPony on 22/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "SettingTableViewController.h"
#import "MainMapViewController.h"
#import "AppDelegate.h"
#import "JVFloatingDrawerViewController.h"
#import "ParkPanaDatabaseAPI.h"

@import Firebase;

#define kSettingItem_UserProfile    1
#define kSettingItem_FindParking    2
#define kSettingItem_Payment        4
#define kSettingItem_Help           3


@implementation SettingTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self SettingProfileItem];
    
}

- (void)SettingProfileItem
{
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user != nil) {
        // User is signed in.
        [txtEmail setHidden:NO];
        [txtDisplayName setHidden:NO];
        [txtAccount setHidden:YES];

        
        for (id<FIRUserInfo> profile in user.providerData) {
            
            txtEmail.text = profile.email;
            
            if( profile.displayName != nil )
                txtDisplayName.text = profile.displayName;
            else{
                [ParkPanaDatabaseAPI GetProfile:^(NSMutableDictionary *profileItem){
                    txtDisplayName.text = [ NSString stringWithFormat:@"%@  %@", [profileItem objectForKey:@"firstname"], [profileItem objectForKey:@"lastname"] ];
                }];
                
            }
        }
        
    }
    else{
        [txtEmail setHidden:YES];
        [txtDisplayName setHidden:YES];
        [txtAccount setHidden:NO];
        txtAccount.text = @"Account";
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self SettingProfileItem];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case kSettingItem_UserProfile: {
            [self profileItemProcess];
        }
            
        break;
        case kSettingItem_FindParking: {
            [[AppDelegate sharedDelegate] findScreen];
        }
            
        break;
        case kSettingItem_Payment: {
        }
            
        break;
        case kSettingItem_Help: {
            [self helpItemProcess];
        }
            
        break;
    }
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
}

-(void)profileItemProcess
{
    FIRUser *user = [FIRAuth auth].currentUser;
    
    if (user != nil) {
        // User is signed in.
        [[AppDelegate sharedDelegate] profileScreen];
    } else {
        // No user is signed in.
        [[AppDelegate sharedDelegate] signinScreen];
    }
    
}


-(void)helpItemProcess
{
//    UIViewController *destinationViewController = nil;
//    destinationViewController = [[AppDelegate sharedDelegate] mainMapViewController];
//    [[[AppDelegate sharedDelegate] drawerViewController] setCenterViewController:destinationViewController];
    [[AppDelegate sharedDelegate] toggleSettingViewControllerWithHelper:self animated:YES];
}

@end
