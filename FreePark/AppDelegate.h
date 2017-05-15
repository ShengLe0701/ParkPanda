//
//  AppDelegate.h
//  FreePark
//
//  Created by LovelyPony on 05/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JVFloatingDrawerViewController;
@class JVFloatingDrawerSpringAnimator;

#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) JVFloatingDrawerViewController *drawerViewController;
@property (nonatomic, strong) JVFloatingDrawerSpringAnimator *drawerAnimator;

@property (nonatomic, strong) UITableViewController *settingTableViewController;
@property (nonatomic, strong) UIViewController *mainMapViewController;

@property (nonatomic, strong) UIViewController *parkingProfileViewController;
@property (nonatomic, strong) UIViewController *profileViewController;
@property (nonatomic, strong) UIViewController *signinViewController;
@property (nonatomic, strong) UIViewController *signupViewController;
@property (nonatomic, strong) UIViewController *findViewController;
@property (nonatomic, strong) UIViewController *navFindViewController;
@property (nonatomic, strong) UIViewController *mapNavigationViewController;


#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"


+ (AppDelegate *)sharedDelegate;

- (UIStoryboard *)mainStoryboard;
- (void)setupWelcomeScreen;
- (void)setupMainScreen;

- (void)mainScreen;
- (void)parkingProfile;
- (void)findScreen;
- (void)profileScreen;
- (void)signinScreen;
- (void)signupScreen;
- (void)mapNavigationScreen;


- (void)toggleSettingViewController:(id)sender animated:(BOOL)animated;
- (void)toggleSettingViewControllerWithHelper:(id)sender animated:(BOOL)animated;
- (void)toggleSettingViewControllerWithMain:(id)sender animated:(BOOL)animated;


@end

