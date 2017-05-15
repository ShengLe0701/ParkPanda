//
//  LaunchScreenVC.m
//  Discount
//
//  Created by iDeveloper on 9/10/15.
//  Copyright (c) 2015 Justin. All rights reserved.
//

#import "LaunchScreenVC.h"
#import "FPSetting.h"
#import "AppDelegate.h"

@interface LaunchScreenVC ()

@end

@implementation LaunchScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"Logo"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;

    [self.view addSubview:imageView];
    
    UIActivityIndicatorView *loadAnimation = [[UIActivityIndicatorView alloc] init];
    loadAnimation.center = self.view.center;
    [loadAnimation startAnimating];
    
    [self.view addSubview:loadAnimation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (g_Setting.isLogined) {
        [[AppDelegate sharedDelegate] setupMainScreen];
    } else {
        [[AppDelegate sharedDelegate] setupWelcomeScreen];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
