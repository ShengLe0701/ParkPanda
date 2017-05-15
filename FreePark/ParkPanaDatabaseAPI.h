//
//  ParkPanaDatabaseAPI.h
//  FreePark
//
//  Created by LovelyPony on 19/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParkingInfo.h"
#import "CityInfo.h"


@interface ParkPanaDatabaseAPI : NSObject
{
}

+ (Boolean *)AddProfile:(NSMutableDictionary *)profileItem;
+ (Boolean *)UpdateProfile:(NSMutableDictionary *)profileItem;
+ (Boolean *)DeleteProfile;
+ (NSMutableDictionary *)GetProfile:(void (^)(NSMutableDictionary *profileItem))completion;

+ (void)GetCityInfoList:(void (^)(NSMutableArray *cityInfoList))completion;
+ (void)GetCityInfo:(NSString*)cityID callback:(void (^)(CityInfo *acityInfo))completion;
+ (void)GetParkingInfoListInCity:(NSString*)cityID callback:(void (^)(NSMutableArray *parkingInfoList))completion;
+ (void)GetParkingInfo:(NSString*)parkingID cityID:(NSString*)cityID callback:(void (^)(ParkingInfo *aparkingInfo))completion;


@end
