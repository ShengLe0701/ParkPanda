//
//  ParkPanaDatabaseAPI.m
//  FreePark
//
//  Created by LovelyPony on 19/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "ParkPanaDatabaseAPI.h"
#import "JSONKit.h"


@import Firebase;
@import Foundation;

@implementation ParkPanaDatabaseAPI



+ (Boolean *)AddProfile:(NSMutableDictionary *)profileItem
{
    NSString *firstName = (NSString *)profileItem[@"firstname"];
    NSString *lastName = (NSString *)profileItem[@"lastname"];
    NSString *carLicenseNumber = (NSString *)profileItem[@"carlicensenumber"];
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSString *key = [[ref child:@"users"] childByAutoId].key;
    
    NSDictionary *profileitem = @{@"uid": userID,
                                  @"firstname": firstName,
                                  @"lastname": lastName,
                                  @"carlicensenumber": carLicenseNumber};
    
   [[[ref child:@"profiles"] child:userID] setValue:profileitem];
    
    return true;
}

+ (Boolean *)UpdateProfile:(NSMutableDictionary *)profileItem
{
    NSString *firstName = (NSString *)profileItem[@"firstname"];
    NSString *lastName = (NSString *)profileItem[@"lastname"];
    NSString *carLicenseNumber = (NSString *)profileItem[@"carlicensenumber"];
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSString *key = [[ref child:@"users"] childByAutoId].key;
    
    NSDictionary *profileitem = @{@"uid": userID,
                                  @"firstname": firstName,
                                  @"lastname": lastName,
                                  @"carlicensenumber": carLicenseNumber};
    
    [[[ref child:@"profiles"] child:userID] setValue:profileitem];
    
    return true;
}

+ (Boolean *)DeleteProfile
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSString *key = [[ref child:@"users"] childByAutoId].key;
    
    [[[ref child:@"profiles"] child:userID] removeValue];
    
    return true;
}

+ (void)GetProfile:(void (^)(NSMutableDictionary *profileItem))completion
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSString *key = [[ref child:@"users"] childByAutoId].key;
    
    [[[ref child:@"profiles"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableDictionary *Item = (NSMutableDictionary *)snapshot.value;
        if( completion )
            completion(Item);
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

+ (void)GetCityInfoList:(void (^)(NSMutableArray *cityList))completion
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[ref child:@"cityinfos"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshots) {
        
        NSMutableArray *cityinfos  = [[NSMutableArray alloc] init];

        for( FIRDataSnapshot *snapshot in [snapshots children] )
        {
            NSMutableDictionary *item = (NSMutableDictionary*)snapshot.value;
            
            CityInfo *cityInfo = [[CityInfo alloc] init];
            
            cityInfo.cityid = snapshot.key;
            
            cityInfo.name = item[@"name"];
            cityInfo.lat = [item[@"lat"] floatValue];
            cityInfo.lon = [item[@"lon"] floatValue];
            
            [cityinfos addObject:cityInfo];
            
        }
        
        if( completion )
            completion(cityinfos);
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}

+ (void)GetCityInfo:(NSString*)cityID callback:(void (^)(CityInfo *acityInfo))completion;
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[ref child:@"cityinfos"] child:cityID ] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableDictionary *item = (NSMutableDictionary *)snapshot.value;
        
        CityInfo *cityInfo = [[CityInfo alloc] init];
        cityInfo.cityid = snapshot.key;
        cityInfo.name = item[@"name"];
        cityInfo.lat = [item[@"lat"] floatValue];
        cityInfo.lon = [item[@"lon"] floatValue];
        
        if( completion )
            completion(cityInfo);
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

/*
+ (Boolean *)GetCityList:(void (^)(NSMutableArray *cityList))completion
{
    
    NSMutableArray* vCityList = [[NSMutableArray alloc] initWithObjects:@"Warwick University", nil];
    
    if( completion )
        completion(vCityList);
    
    return true;
}
 
+ (void)GetParkingInfoListInCity:(NSString*)cityID callback:(void (^)(NSMutableArray *parkingInfoList))completion
{
    NSMutableArray *parkingInfos = [[NSMutableArray alloc] init];
    
    NSArray *_exhibits;     // Array of JSON exhibit data.
    
    // Load the exhibits configuration from JSON
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"parkinginfo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    
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
    
    if(completion)
        completion(parkingInfos);
}
*/

+ (void)GetParkingInfoListInCity:(NSString*)cityID callback:(void (^)(NSMutableArray *parkingInfoList))completion
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"parkinginfos"] child:cityID] child:@"parkinginfos" ] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshots) {
        
        NSMutableArray *parkingInfos  = [[NSMutableArray alloc] init];
        
//        snapshots = [(NSMutableDictionary*)snapshots.value objectForKey:@"parkinginfos"];
        
        for( FIRDataSnapshot *snapshot in [snapshots children] )
        {
            NSMutableDictionary *item = (NSMutableDictionary*)snapshot.value;
            
            ParkingInfo *parkingInfo = [[ParkingInfo alloc] init];
            
            parkingInfo.name = item[@"name"];
            parkingInfo.parkID = snapshot.key;
            
            parkingInfo.image = item[@"image"];
            
//            parkingInfo.iconPicture = item[@"iconPicture"];
//            parkingInfo.bigPicture = item[@"bigPicture"];
            
            parkingInfo.lat = [item[@"lat"] floatValue];
            parkingInfo.lon = [item[@"lon"] floatValue];
            
            parkingInfo.freeSpace = [item[@"freeSpace"] intValue];
            parkingInfo.totalSpace = [item[@"totalSpace"] intValue];
            
            parkingInfo.time = item[@"time"];
            parkingInfo.price = [item[@"price"] intValue];
            parkingInfo.address = item[@"address"];
            parkingInfo.desc = item[@"desc"];
            
            [parkingInfos addObject:parkingInfo];
            
        }
        
        if( completion )
            completion(parkingInfos);
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

+ (void)GetParkingInfo:(NSString*)parkingID cityID:(NSString*)cityID callback:(void (^)(ParkingInfo *aparkingInfo))completion
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[[[ref child:@"parkinginfos"] child:cityID] child:@"parkinginfos"] child:parkingID ] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshots) {
        
            NSMutableDictionary *item = (NSMutableDictionary*)snapshots.value;
            
            ParkingInfo *parkingInfo = [[ParkingInfo alloc] init];
            
            parkingInfo.name = item[@"name"];
            parkingInfo.parkID = snapshots.key;
        
            parkingInfo.image = item[@"image"];
        
            parkingInfo.lat = [item[@"lat"] floatValue];
            parkingInfo.lon = [item[@"lon"] floatValue];
            
            parkingInfo.freeSpace = [item[@"freeSpace"] intValue];
            parkingInfo.totalSpace = [item[@"totalSpace"] intValue];
            
            parkingInfo.time = item[@"time"];
            parkingInfo.price = [item[@"price"] intValue];
            parkingInfo.address = item[@"address"];
            parkingInfo.desc = item[@"desc"];
            
            if( completion )
                completion(parkingInfo);
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end
