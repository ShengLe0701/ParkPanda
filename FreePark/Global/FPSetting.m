//
//  DNSetting.m
//  Discount
//
//  Created by YRH on 1/28/15.
//  Copyright (c) 2015 AcapellaMedia. All rights reserved.
//
#include "FPSetting.h"

@implementation NSUserDefaults (FreePark)

@dynamic isInitialized;
@dynamic isFirstLaunch;
@dynamic isLogined;
@dynamic useCurrentLoc;

@dynamic latestLat;
@dynamic latestLng;


@dynamic socialFB;
@dynamic postDibsFB;
@dynamic postFavsFB;

@dynamic socialTW;
@dynamic postDibsTW;
@dynamic postFavsTW;

@dynamic authToken;
@dynamic usrEmail;
@dynamic usrType;
@dynamic usrId;

@dynamic twUsrId;
@dynamic twUsrName;

- (void)initSetting {
  if (self.isInitialized)
    return;
  
  self.isInitialized = YES;
  self.isFirstLaunch = YES;
  self.useCurrentLoc = NO;
  
  self.latestLat = 0;
  self.latestLng = 0;
  
  self.socialFB = NO;
  self.postDibsFB = NO;
  self.postFavsFB = NO;
  
  self.socialTW = NO;
  self.postDibsTW = NO;
  self.postFavsTW = NO;
  
  self.twUsrId = nil;
  self.twUsrName = nil;
  
  [self logout];
}

- (void)logined:(NSString *)authToken {
  self.isLogined = YES;
  self.authToken = authToken;
}

- (void)logout {
  self.isLogined = NO;
  self.usrId = nil;
  self.authToken = nil;
  self.usrEmail = nil;
  self.usrType = nil;
}
@end
