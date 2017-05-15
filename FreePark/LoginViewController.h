//
//  LoginViewController.h
//  FreePark
//
//  Created by LovelyPony on 21/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import "FBConnect.h"
#import "TextFieldValidator.h"

@interface LoginViewController : UIViewController
{
    
    __weak IBOutlet UIImageView *LogoImage;
    __weak IBOutlet TextFieldValidator *txtEmail;
    __weak IBOutlet TextFieldValidator *txtPassword;
}


- (IBAction)touchUpInsideFBLoginButton:(id)sender;
- (IBAction)touchUpInsideLogin:(id)sender;
- (IBAction)touchUpInsideSkipButton:(id)sender;
@end
