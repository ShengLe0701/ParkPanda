//
//  MapNavigationViewController.h
//  FreePark
//
//  Created by LovelyPony on 26/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ParkingInfo.h"
#import "NJKWebViewProgress.h"

@interface MapNavigationViewController : UIViewController  <CLLocationManagerDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UIWebView *m_WebView;
    ParkingInfo *parkingInfo;
    
    CLLocationManager *locationManager;
    
}

/* Load Progress Manager */
//@property (nonatomic,strong) NJKWebViewProgress *progressManager;

- (IBAction)touchInSideBack:(id)sender;
- (void)setNavigationInfoWithSrcLatitude:(float)srcLat SrcLongitude:(float)srcLong DstLatitude:(float)dstLat DstLongitude:(float)dstLong;

- (void)setParkingInfo:(ParkingInfo*)aParkingInfo;



@end
