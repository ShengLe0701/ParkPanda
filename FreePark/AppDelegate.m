//
//  AppDelegate.m
//  FreePark
//
//  Created by LovelyPony on 05/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "AppDelegate.h"
#import "GoogleMapAPIKey.h"
#import "FPGlobal.h"
#import "FPSetting.h"
#import "LaunchScreenVC.h"
#import "MainMapViewController.h"

#import "ParkPanaDatabaseAPI.h"

#import "JVFloatingDrawerViewController.h"
#import "JVFloatingDrawerSpringAnimator.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import GoogleMaps;
@import Firebase;

static NSString * const kFPMainStoryboardName = @"Main";
static NSString * const kFPLaunchStoryboardName = @"LaunchScreen";


static NSString * const kFPSettingViewControllerStoryboardID = @"FPSettingViewControllerStoryboardID";
static NSString * const kFPMainMapViewControllerStoryboardID = @"FPMainMapViewControllerStoryboardID";

static NSString * const kSignUpViewControllerStoryboardID = @"SignUpViewControllerStoryboardID";
static NSString * const kSignInViewControllerStoryboardID = @"SignInViewControllerStoryboardID";
static NSString * const kProfileViewControllerStoryboardID = @"ProfileViewControllerStoryboardID";
static NSString * const kParkingProfileViewControllerStoryboardID = @"ParkingProfileViewControllerStoryboardID";
static NSString * const kFindViewControllerStoryboardID = @"FindViewControllerStoryboardID";
static NSString * const kNavFindViewControllerStoryboardID = @"NavFindViewControllerStoryboardID";



@interface AppDelegate ()

@property (nonatomic, strong, readonly) UIStoryboard *mainStoryboard;

@end

@implementation AppDelegate

@synthesize mainStoryboard = _mainStoryboard;

static AppDelegate *sharedDelegate;

+ (AppDelegate *)sharedDelegate
{
    if (!sharedDelegate) {
        sharedDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    return sharedDelegate;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow new];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    [self.window setFrame:bounds];
    [self.window setBounds:bounds];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [GMSServices provideAPIKey:kGoogleMapAPIKey];
    
    [FIRApp configure];

    //---------------------------------------------------------------
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    [application setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
    
    LaunchScreenVC *welcomeVC = [[LaunchScreenVC alloc] init];
    self.window.rootViewController = welcomeVC;
    [self.window makeKeyAndVisible];
    
    self.window.frame = [[UIScreen mainScreen] bounds];
    
    
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:setting];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    
    
   // Init Singletons
   [g_Setting initSetting];
    
    [self configureDrawerViewController];

    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation
            ];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)setupWelcomeScreen {
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:kFPLaunchStoryboardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [loginStoryboard instantiateInitialViewController];
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.window.rootViewController = viewController;
                    }
                    completion:nil];
}

- (void)setupMainScreen {
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    UIViewController *viewController = [mainStoryboard instantiateInitialViewController];
//    self.window.rootViewController = viewController;
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.drawerViewController;
    [self.window makeKeyAndVisible];
}

//- (void)mainScreenWithNav {
//    [(UINavigationController*)self.navMainMapViewController popViewControllerAnimated:YES];
//}

- (void)mainScreen {
    self.window.rootViewController = self.drawerViewController;
    [self.window makeKeyAndVisible];
    
    if( self.drawerViewController.currentlyOpenedSide == JVFloatingDrawerSideLeft)
    {
        [self.drawerViewController setCenterViewController:_mainMapViewController];
        [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:YES completion:nil];
    }
    
}

- (void)findScreen {
//    self.window.rootViewController = self.findViewController;
    self.window.rootViewController = self.navFindViewController;
    [self.window makeKeyAndVisible];
}

- (void)profileScreen {
    self.window.rootViewController = self.profileViewController;
    [self.window makeKeyAndVisible];
}

- (void)signinScreen {
    self.window.rootViewController = self.signinViewController;
    [self.window makeKeyAndVisible];
}

- (void)signupScreen {
    self.window.rootViewController = self.signupViewController;
    [self.window makeKeyAndVisible];
}

- (void)mapNavigationScreen {
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.window.rootViewController = self.mapNavigationViewController;
                    }
                    completion:nil];
}

- (void)parkingProfile {
//    self.window.rootViewController = self.parkingProfileViewController;
//    [self.window makeKeyAndVisible];
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.window.rootViewController = self.parkingProfileViewController;
                    }
                    completion:nil];
}


#pragma mark - Show alert with message


- (void) showDevelopmentMessage {
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"ParkPanda"
                              message:@"Did you Park your Panda?"
                              delegate:nil
                              cancelButtonTitle:@"NO"
                              otherButtonTitles:nil,
                              nil];
    [alertView addButtonWithTitle:@"YES"];
    [alertView show];
}


#pragma mark - Drawer View Controllers

- (JVFloatingDrawerViewController *)drawerViewController {
    if (!_drawerViewController) {
        _drawerViewController = [[JVFloatingDrawerViewController alloc] init];
    }
    
    return _drawerViewController;
}

#pragma mark Sides

- (UITableViewController *)settingTableViewController {
    if (!_settingTableViewController) {
        _settingTableViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kFPSettingViewControllerStoryboardID];
    }
    
    return _settingTableViewController;
}

- (UIViewController *)profileViewController {
    if (!_profileViewController) {
        _profileViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kProfileViewControllerStoryboardID];
    }
    
    return _profileViewController;
}

- (UIViewController *)signinViewController {
    if (!_signinViewController) {
        _signinViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kSignInViewControllerStoryboardID];
    }
    
    return _signinViewController;
}

- (UIViewController *)signupViewController {
    if (!_signupViewController) {
        _signupViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kSignUpViewControllerStoryboardID];
    }
    
    return _signupViewController;
}

- (UIViewController *)parkingProfileViewController {
    if (!_parkingProfileViewController) {
        _parkingProfileViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kParkingProfileViewControllerStoryboardID];
    }
    
    return _parkingProfileViewController;
}

- (UIViewController *)navFindViewController{
    if (!_navFindViewController) {
        _navFindViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kNavFindViewControllerStoryboardID];
    }
    
    return _navFindViewController;
    
}

- (UIViewController *)findViewController {
    if (!_findViewController) {
        _findViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kFindViewControllerStoryboardID];
    }
    
    return _findViewController;
}

#pragma mark Center

- (UIViewController *)mainMapViewController {
    if (!_mainMapViewController) {
        _mainMapViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:kFPMainMapViewControllerStoryboardID];
    }
    
    return _mainMapViewController;
}

- (UIViewController *)mapNavigationViewController {
    if (!_mapNavigationViewController) {
        _mapNavigationViewController = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"MapNavigationViewControllerStoryboardID"];
    }
    
    return _mapNavigationViewController;
}


- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    if (!_drawerAnimator) {
        _drawerAnimator = [[JVFloatingDrawerSpringAnimator alloc] init];
    }
    
    return _drawerAnimator;
}

- (UIStoryboard *)mainStoryboard {
    if(!_mainStoryboard) {
        _mainStoryboard = [UIStoryboard storyboardWithName:kFPMainStoryboardName bundle:[NSBundle mainBundle]];
    }
    
    return _mainStoryboard;
}

- (void)configureDrawerViewController {
    self.drawerViewController.leftViewController = self.settingTableViewController;
//    self.drawerViewController.rightViewController = self.settingTableViewController;
    self.drawerViewController.centerViewController = self.mainMapViewController;
//    self.drawerViewController.centerViewController = self.settingTableViewController;
    
    self.drawerViewController.animator = self.drawerAnimator;
    
    self.drawerViewController.backgroundImage = [UIImage imageNamed:@"NavDrawerImage"];
}

- (void)toggleSettingViewController:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];
}

- (void)toggleLeftDrawer:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];
}

- (void)toggleSettingViewControllerWithMain:(id)sender animated:(BOOL)animated {
    
    [self.drawerViewController setCenterViewController:_mainMapViewController];
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:nil];
}

- (void)toggleSettingViewControllerWithHelper:(id)sender animated:(BOOL)animated {
    [self.drawerViewController toggleDrawerWithSide:JVFloatingDrawerSideLeft animated:animated completion:^(BOOL finished){
        if(finished)
        {
            [((MainMapViewController*)self.mainMapViewController) showHelperViewController];
        }
    }];
}

@end
