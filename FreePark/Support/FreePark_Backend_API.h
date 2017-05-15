//
//  FreePark_Backend_API.h
//  FreePark
//
//  Created by LovelyPony on 19/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileInfo.h"
#import "ParkingInfo.h"
#import "ParkingLogInfo.h"
#import "FPSetting.h"

@interface FreePark_Backend_API : NSObject

+ (NSMutableArray *) getParkingInfoInBound:(float)fLatitude Longitude:(float)fLongitude;

+ (ParkingInfo *) getParkingInfoWithID:(NSString *)parkingID;

+ (NSMutableArray *) getParkingLog:(NSUserDefaults *)accountInfo;

+ (UserProfileInfo *) getUserProfileInfo:(NSUserDefaults *)accountInfo;

+ (bool) setUserProfileInfo:(NSUserDefaults *)accountInfo ProfileInfo:(UserProfileInfo *)accountProfileInfo;

@end
