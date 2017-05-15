//
//  FreePark_Backend_API.m
//  FreePark
//
//  Created by LovelyPony on 19/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "FreePark_Backend_API.h"
#import "JSON/JSONKit.h"

@implementation FreePark_Backend_API

+ (NSMutableArray *) getParkingInfoInBound:(float)fLatitude Longitude:(float)fLongitude{
  
    NSMutableArray *parkingInfos = [[NSMutableArray alloc] init];
  
    NSArray *_exhibits;     // Array of JSON exhibit data.
  
    // Load the exhibits configuration from JSON
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"parkinginfo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
//    _exhibits = [NSJSONSerialization JSONObjectWithData:data
//                                              options:kNilOptions
//                                                error:nil];
    
    JSONDecoder* decoder = [[JSONDecoder alloc] init];
    _exhibits = [decoder objectWithData:data];

    
    for (NSDictionary *exhibit in _exhibits) {
      
        ParkingInfo *parkingInfo = [[ParkingInfo alloc] init];

        parkingInfo.name = exhibit[@"name"];
        parkingInfo.parkID = exhibit[@"id"];
        
        parkingInfo.iconPicture = exhibit[@"iconPicture"];
        parkingInfo.bigPicture = exhibit[@"bigPicture"];
        
        parkingInfo.lat = [exhibit[@"lat"] floatValue];
        parkingInfo.lon = [exhibit[@"lon"] floatValue];
        
        parkingInfo.freeSpace = [exhibit[@"freeSpace"] intValue];
        parkingInfo.totalSpace = [exhibit[@"totalSpace"] intValue];
        
        parkingInfo.time = exhibit[@"time"];
        parkingInfo.price = [exhibit[@"price"] intValue];
        parkingInfo.address = exhibit[@"address"];
        parkingInfo.desc = exhibit[@"desc"];
        
        [parkingInfos addObject:parkingInfo];

    }
  
    return parkingInfos;
}

+ (ParkingInfo *) getParkingInfoWithID:(NSString *)parkingID{
    
    NSArray *_exhibits;     // Array of JSON exhibit data.
    
    // Load the exhibits configuration from JSON
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"parkinginfo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    //    _exhibits = [NSJSONSerialization JSONObjectWithData:data
    //                                              options:kNilOptions
    //                                                error:nil];
    
    JSONDecoder* decoder = [[JSONDecoder alloc] init];
    _exhibits = [decoder objectWithData:data];
    
    
    for (NSDictionary *exhibit in _exhibits) {
        
        ParkingInfo *parkingInfo = [[ParkingInfo alloc] init];
        
        if( [exhibit[@"id"] isEqualToString:parkingID] == false )
            continue;
        
        parkingInfo.name = exhibit[@"name"];
        parkingInfo.parkID = exhibit[@"id"];
        
        parkingInfo.iconPicture = exhibit[@"iconPicture"];
        parkingInfo.bigPicture = exhibit[@"bigPicture"];
        
        parkingInfo.lat = [exhibit[@"lat"] floatValue];
        parkingInfo.lon = [exhibit[@"lon"] floatValue];
        
        parkingInfo.freeSpace = [exhibit[@"freeSpace"] intValue];
        parkingInfo.totalSpace = [exhibit[@"totalSpace"] intValue];
        
        parkingInfo.time = exhibit[@"time"];
        parkingInfo.price = [exhibit[@"price"] intValue];
        parkingInfo.address = exhibit[@"address"];
        parkingInfo.desc = exhibit[@"desc"];
        
        return parkingInfo;
        
    }
    
    return nil;
}

+ (NSMutableArray *) getParkingLog:(NSUserDefaults *)accountInfo{
    NSMutableArray *parkingLogInfos = [[NSMutableArray alloc] init];
    
    NSArray *_exhibits;     // Array of JSON exhibit data.
    
    // Load the exhibits configuration from JSON
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"parkingloginfo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    //    _exhibits = [NSJSONSerialization JSONObjectWithData:data
    //                                              options:kNilOptions
    //                                                error:nil];
    
    JSONDecoder* decoder = [[JSONDecoder alloc] init];
    _exhibits = [decoder objectWithData:data];
    
    
    for (NSDictionary *exhibit in _exhibits) {
        
        ParkingLogInfo *parkingLogInfo = [[ParkingLogInfo alloc] init];
        
        parkingLogInfo.parkingID = exhibit[@"parkingid"];
        parkingLogInfo.parkingName = exhibit[@"parkingname"];
        
        parkingLogInfo.parkingAddress = exhibit[@"parkingaddress"];
        parkingLogInfo.parkingPrice = [exhibit[@"parkingprice"] intValue];
        
        parkingLogInfo.logDate = exhibit[@"logdate"];
        parkingLogInfo.logTime = exhibit[@"logtime"];
        
        parkingLogInfo.iconPicture = exhibit[@"iconpicture"];
        
        [parkingLogInfos addObject:parkingLogInfo];
        
    }
    
    
    return parkingLogInfos;
}

+ (UserProfileInfo *) getUserProfileInfo:(NSUserDefaults *)accountInfo{
    
    NSArray *_exhibits;     // Array of JSON exhibit data.
    
    // Load the exhibits configuration from JSON
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"userprofileinfo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    //    _exhibits = [NSJSONSerialization JSONObjectWithData:data
    //                                              options:kNilOptions
    //                                                error:nil];
    
    JSONDecoder* decoder = [[JSONDecoder alloc] init];
    _exhibits = [decoder objectWithData:data];
    
    
    for (NSDictionary *exhibit in _exhibits) {
        
        UserProfileInfo *userProfileInfo = [[UserProfileInfo alloc] init];
        
        userProfileInfo.carNumber = exhibit[@"carnumber"];
        
        return userProfileInfo;
    }
    
    return nil;
    
}

+ (bool) setUserProfileInfo:(NSUserDefaults *)accountInfo ProfileInfo:(UserProfileInfo *)accountProfileInfo{
    
    return TRUE;
}


@end
