//
//  ProfileViewController.h
//  FreePark
//
//  Created by LovelyPony on 19/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface ProfileViewController : UIViewController
{
    __weak IBOutlet TextFieldValidator *txtFirstName;
    __weak IBOutlet TextFieldValidator *txtLastName;
    __weak IBOutlet TextFieldValidator *txtEmail;
    __weak IBOutlet TextFieldValidator *txtCarLicenseNumber;
    __weak IBOutlet TextFieldValidator *txtPassword;
    __weak IBOutlet TextFieldValidator *txtRetryPassword;
    
}
- (IBAction)touchUpInsideSave:(id)sender;
- (IBAction)touchUpInsideSignout:(id)sender;
- (IBAction)touchBack:(id)sender;


@end
