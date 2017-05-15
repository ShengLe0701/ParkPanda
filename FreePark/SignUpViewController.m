//
//  SignUpViewController.m
//  FreePark
//
//  Created by LovelyPony on 19/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "ParkPanaDatabaseAPI.h"
#import "UIView+Toast.h"

@import Firebase;
@import FirebaseAuth;

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [txtFirstName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    [txtLastName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    [txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
//    [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    [txtRetryPassword addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    
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

- (IBAction)touchUpInsideSignup:(id)sender {
    
    if( [txtEmail validate] && [txtPassword validate] && [txtRetryPassword validate] && [txtFirstName validate] && [txtLastName validate] && [txtCarLicenseNumber validate])
    {
        [[FIRAuth auth] createUserWithEmail:txtEmail.text
                                   password:txtPassword.text
                                 completion:^(FIRUser *_Nullable user,
                                              NSError *_Nullable error) {
                                 if (error)
                                 {
                                     NSLog(@"Firebase Error:%@", [error localizedDescription]);
                                     [self.view makeToast:@"Signup is failure."
                                                 duration:2.0
                                                 position:CSToastPositionCenter
                                                    title:@"ParkPanda"
                                                    image:nil
                                                    style:nil
                                               completion:nil];
                                 }
                                 else
                                 {
                                     NSLog(@"FireBaas Signin OK");
                                     
                                     NSMutableDictionary *profileItem = [[NSMutableDictionary alloc] init];
                                     [profileItem setValue:txtFirstName.text forKey:@"firstname"];
                                     [profileItem setValue:txtLastName.text forKey:@"lastname"];
                                     [profileItem setValue:txtCarLicenseNumber.text forKey:@"carlicensenumber"];
                                     
                                     [ParkPanaDatabaseAPI AddProfile:profileItem];
                                     [[AppDelegate sharedDelegate] setupMainScreen];
                                 }
        }];
    }
}

- (IBAction)touchBack:(id)sender {
    [[AppDelegate sharedDelegate] setupMainScreen];
}
@end
