

#import "ParkingInfo.h"

@implementation ParkingInfo

- (double)degreesStringToDecimal:(NSString*)string
{
    // split the string
    NSArray *splitDegs = [string componentsSeparatedByString:@"\u00B0"];  // unicode for degree symbol
    NSArray *splitMins = [splitDegs[1] componentsSeparatedByString:@"'"];
    NSArray *splitSecs = [splitMins[1] componentsSeparatedByString:@"\""];
    
    // get each segment of the dms string
    NSString *degreesString = splitDegs[0];
    NSString *minutesString = splitMins[0];
    NSString *secondsString = splitSecs[0];
    NSString *direction = splitSecs[1];
    
    // convert degrees
    double degrees = [degreesString doubleValue];
    
    // convert minutes
    double minutes = [minutesString doubleValue] / 60;  // 60 degrees in a minute
    
    // convert seconds
    double seconds = [secondsString doubleValue] / 3600; // 60 seconds in a minute, or 3600 in a degree
    
    // add them all together
    double decimal = degrees + minutes + seconds;
    
    // determine if this is negative. south and west would be negative values
    if ([direction.uppercaseString isEqualToString:@"W"] || [direction.uppercaseString isEqualToString:@"S"])
    {
        decimal = -decimal;
    }
    
    return decimal;
}

@end
