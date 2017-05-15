//
//  ViewController.h
//  FreePark
//
//  Created by LovelyPony on 05/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@class ParkingInfo;
@class CityInfo;

@interface MainMapViewController : UIViewController{
    ParkingInfo *tapedParkingInfo;
    NSMutableArray *m_parkingInfos;
    CityInfo *mCityInfo;
}

@property (weak, nonatomic) IBOutlet UIView *m_MapView;

- (IBAction)actionToggleSettingViewController:(id)sender;
- (void) showHelperViewController;
- (IBAction)actionFind:(id)sender;

- (void)showParking;

- (void)setCityInfo:(CityInfo*)cityInfo;
- (GMSMapView *)mapView;


@end

