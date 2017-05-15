//
//  CityInfo.h
//  FreePark
//
//  Created by LovelyPony on 06/09/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cityid;

@property float lat;
@property float lon;

@end
