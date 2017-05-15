//
//  LoginViewController.m
//  FreePark
//
//  Created by LovelyPony on 21/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

#import "UIView+Toast.h"



@import Firebase;

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view sendSubviewToBack:LogoImage];
    
    [self customizeOutlets];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user != nil) {
        // User is signed in.
        [[AppDelegate sharedDelegate] setupMainScreen];
    }
}

- (IBAction)touchUpInsideFBLoginButton:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    //I added because of "com.facebook.sdk.login error 304".
    FBSDKLoginManager *logMeOut = [[FBSDKLoginManager alloc] init];
    [logMeOut logOut];
     
    [login logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    NSLog(@"Facebook Login Failure");
                                    NSLog(@"Facebook Error:%@", [error localizedDescription]);
                                } else if (result.isCancelled) {
                                    NSLog(@"Facebook Login Cancelled");
                                } else {
                                    NSLog(@"Facebook Login OK");
                                    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                                                     .tokenString];
                                    
                                    [[FIRAuth auth] signInWithCredential:credential
                                                              completion:^(FIRUser *user, NSError *error) {
                                                                  
                                                                  if (error)
                                                                  {
                                                                      NSLog(@"Firebase Error:%@", [error localizedDescription]);
                                                                  }
                                                                  else
                                                                  {
                                                                      NSLog(@"FireBaas Signin OK");
                                                                      [[AppDelegate sharedDelegate] setupMainScreen];
                                                                  }
                                                                  
                                                              }];
                                }
                            }];
    
}

- (IBAction)touchUpInsideLogin:(id)sender {
   
    if( [txtEmail validate] && [txtPassword validate])
    {
        
        [[FIRAuth auth] signInWithEmail:txtEmail.text
                               password:txtPassword.text
                             completion:^(FIRUser *user, NSError *error) {
                                 if (error)
                                 {
                                     NSLog(@"Firebase Error:%@", [error localizedDescription]);
                                     if ([[error localizedDescription] containsString:@"There is no user"])
                                     {
                                         [self.view makeToast:@"There is no user."
                                                     duration:2.0
                                                     position:CSToastPositionCenter
                                                        title:@"ParkPanda"
                                                        image:nil
                                                        style:nil
                                                   completion:nil];
                                     }
                                     else if([[error localizedDescription] containsString:@"The password is invalid"])
                                     {
                                         [self.view makeToast:@"The password is invalid."
                                                     duration:2.0
                                                     position:CSToastPositionCenter
                                                        title:@"ParkPanda"
                                                        image:nil
                                                        style:nil
                                                   completion:nil];
                                     }
                                 }
                                 else
                                 {
                                     NSLog(@"FireBaas Signin OK");
                                     [[AppDelegate sharedDelegate] setupMainScreen];
                                 }
                                 
                             }];
    }
    
}

- (IBAction)touchUpInsideSkipButton:(id)sender {
    [[AppDelegate sharedDelegate] setupMainScreen];
}

-(void)customizeOutlets
{
    //change textfields placeholder text color
    UIColor *colorForPlaceholder = [UIColor colorWithWhite:0.9 alpha:0.9];
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: colorForPlaceholder}];
    txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: colorForPlaceholder}];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor grayColor].CGColor;
    border.borderWidth = borderWidth;
    
    border.frame = CGRectMake(0, txtEmail.frame.size.height - borderWidth, txtEmail.frame.size.width, txtEmail.frame.size.height);
    [txtEmail.layer addSublayer:border];
    txtEmail.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 1;
    border1.borderColor = [UIColor grayColor].CGColor;
    border1.borderWidth = borderWidth1;
    
    border1.frame = CGRectMake(0, txtPassword.frame.size.height - borderWidth, txtPassword.frame.size.width, txtPassword.frame.size.height);
    [txtPassword.layer addSublayer:border1];
    txtPassword.layer.masksToBounds = YES;
    
    
    [txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];

}


@end
