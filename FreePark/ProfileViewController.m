//
//  ProfileViewController.m
//  FreePark
//
//  Created by LovelyPony on 19/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "ParkPanaDatabaseAPI.h"
#import "UIView+Toast.h"

@import Firebase;
#import "SVProgressHUD.h"

#import <FirebaseAuth/FIRUserInfo.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    [txtUserName addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    //    [txtUserName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    //    txtUserName.validateOnResign=NO;
    //    [txtConfirmPass addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    //    [txtPhone addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
    //    txtPhone.isMandatory=NO;
    
    [txtFirstName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    [txtLastName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    [txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    [txtRetryPassword addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    
    [self settingProfile];
    
}

-(void)settingProfile
{
//    [SVProgressHUD showWithStatus:@"Please Wait..." maskType:2];
    [SVProgressHUD show];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    
    if (user != nil) {
        
        for (id<FIRUserInfo> profile in user.providerData) {
            
            txtEmail.text = profile.email;
            //NSURL *photoURL = profile.photoURL;
            //NSString *name = profile.displayName;
            
            [ParkPanaDatabaseAPI GetProfile:^(NSMutableDictionary *profileItem){
                if( profileItem != [NSNull null] )
                {
                    txtFirstName.text = [profileItem objectForKey:@"firstname"];
                    txtLastName.text = [profileItem objectForKey:@"lastname"];
                    txtCarLicenseNumber.text = [profileItem objectForKey:@"carlicensenumber"];
                }
            }];
            
            
        }
    } else {
        // No user is signed in.
    }
    
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated{
    [self settingProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)touchUpInsideSave:(id)sender {
    if ( [txtFirstName validate] && [txtLastName validate] && [txtCarLicenseNumber validate] )
    {
        NSMutableDictionary *profileItem = [[NSMutableDictionary alloc] init];
        [profileItem setValue:txtFirstName.text forKey:@"firstname"];
        [profileItem setValue:txtLastName.text forKey:@"lastname"];
        [profileItem setValue:txtCarLicenseNumber.text forKey:@"carlicensenumber"];
        
        [ParkPanaDatabaseAPI UpdateProfile:profileItem];
        
        [self.view makeToast:@"Profile is saved."
                    duration:2.0
                    position:CSToastPositionCenter
                       title:@"ParkPanda"
                       image:nil
                       style:nil
                  completion:nil];
    }
   
}

- (IBAction)touchUpInsideSignout:(id)sender {
    NSError *error;
    if( [txtEmail validate])
    {
        [[FIRAuth auth] signOut:&error];
        if (error) {
            // An error happened.
            NSLog(@"Firebase Error:%@", [error localizedDescription]);
        } else {
            // Password reset email sent.
            NSLog(@"FireBaas signed out.");
            [[AppDelegate sharedDelegate] signinScreen];
        }
        
    }

}

- (IBAction)touchBack:(id)sender {
    [[AppDelegate sharedDelegate] setupMainScreen];    
}
@end
