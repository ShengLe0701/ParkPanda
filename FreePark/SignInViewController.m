//
//  SignInViewController.m
//  FreePark
//
//  Created by LovelyPony on 19/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "SignInViewController.h"
#import "AppDelegate.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "UIView+Toast.h"


@import Firebase;

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
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

- (IBAction)touchUpInsideSignin:(id)sender {
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
                                     [[AppDelegate sharedDelegate] profileScreen];
                                 }
                                 
                             }];
    }
}

- (IBAction)touchUpInsideFacebookLogin:(id)sender {
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
                                                                      [[AppDelegate sharedDelegate] profileScreen];
                                                                  }
                                                                  
                                                              }];
                                }
                            }];
    
}

- (IBAction)touchBack:(id)sender {
    [[AppDelegate sharedDelegate] setupMainScreen];
}

- (IBAction)touchUpInsideForgetPassword:(id)sender {
    NSString *email = txtEmail.text;
    
    if( [txtEmail validate] )
    {
        [[FIRAuth auth] sendPasswordResetWithEmail:email
                                        completion:^(NSError *_Nullable error) {
                                            if (error) {
                                                // An error happened.
                                                NSLog(@"Firebase Error:%@", [error localizedDescription]);
                                            } else {
                                                // Password reset email sent.
                                                NSLog(@"Firebase Password reset email sent");
                                                [self.view makeToast:@"Password reset email sent"
                                                                                 duration:2.0
                                                                                 position:CSToastPositionCenter
                                                                                    title:@"ParkPanda"
                                                                                    image:nil
                                                                                    style:nil
                                                                               completion:nil];
                                            }
                                            
                                        }];
    }
}

- (IBAction)touchUpInsideSignup:(id)sender {
    [[AppDelegate sharedDelegate] signupScreen];
}
@end
