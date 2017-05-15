//
//  AccountInfo.h
//  FreePark
//
//  Created by LovelyPony on 25/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAccoutType_Facebook    1

@interface AccountInfo : NSObject

@property int *type;
@property (nonatomic, strong) NSObject *account;

@end
