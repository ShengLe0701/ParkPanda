//
//  SignInViewController.h
//  FreePark
//
//  Created by LovelyPony on 19/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface SignInViewController : UIViewController
{
    
    __weak IBOutlet TextFieldValidator *txtEmail;
    __weak IBOutlet TextFieldValidator *txtPassword;
}
- (IBAction)touchUpInsideSignin:(id)sender;
- (IBAction)touchUpInsideFacebookLogin:(id)sender;
- (IBAction)touchBack:(id)sender;
- (IBAction)touchUpInsideForgetPassword:(id)sender;
- (IBAction)touchUpInsideSignup:(id)sender;

@end
