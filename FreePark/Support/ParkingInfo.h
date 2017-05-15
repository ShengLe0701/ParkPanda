

#import <Foundation/Foundation.h>


@interface ParkingInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *parkID;

@property float lat;
@property float lon;

@property (nonatomic, strong) NSString *image;

@property int totalSpace;
@property int freeSpace;

@property int price;      //price

@property (nonatomic, strong) NSString *time;       //time
@property (nonatomic, strong) NSString *address;    //address
@property (nonatomic, strong) NSString *desc;       //quick dscription

@end