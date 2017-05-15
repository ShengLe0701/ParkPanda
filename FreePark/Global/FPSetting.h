//
//  DNSetting.h
//  Discount
//
//  Created by YRH on 1/28/15.
//  Copyright (c) 2015 AcapellaMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSUserDefaults+Property.h>

#define g_Setting [NSUserDefaults standardUserDefaults]

@interface NSUserDefaults (FreePark)
@property BOOL isInitialized; // This is private.

@property BOOL isFirstLaunch;
@property BOOL isLogined;
@property BOOL useCurrentLoc;

@property double latestLat;
@property double latestLng;

@property BOOL socialFB;
@property BOOL postDibsFB;
@property BOOL postFavsFB;

@property BOOL socialTW;
@property BOOL postDibsTW;
@property BOOL postFavsTW;

@property NSString *authToken;
@property NSString *usrEmail;
@property NSString *usrType;
@property NSString *usrId;

@property NSString *twUsrId;
@property NSString *twUsrName;


- (void)initSetting;

- (void)logined:(NSString *)authToken;

- (void)logout;

@end