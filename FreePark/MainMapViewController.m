//
//  ViewController.m
//  FreePark
//
//  Created by LovelyPony on 05/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "MainMapViewController.h"
#import "ParkingInfo.h"
#import "CityInfo.h"
#import "FPGlobal.h"
#import "JVFloatingDrawerSpringAnimator.h"
#import "AppDelegate.h"
#import "ParkingProfileViewController.h"
#import "HelperViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "ParkPanaDatabaseAPI.h"

//#define kParkingProfileViewControllerSegue @"ParkingProfileViewControllerSegue"

@interface MainMapViewController ()<GMSMapViewDelegate>
@property (nonatomic, strong, readonly) JVFloatingDrawerSpringAnimator *drawerAnimator;
@end

@implementation MainMapViewController
{
  GMSMapView *mapView_;
  BOOL _firstLocationUpdate;
}

- (GMSMapView *)mapView
{
    return mapView_;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    mCityInfo = nil;
    _firstLocationUpdate = NO;
    
//    mCityInfo = [[CityInfo alloc] init];
//    @"Warwick University"
    [ParkPanaDatabaseAPI GetCityInfo:@"parkpanda_city_00001" callback:^(CityInfo *acityInfo) {
        mCityInfo = [[CityInfo alloc] init];
        mCityInfo = acityInfo;
        

        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mCityInfo.lat
                                                                longitude:mCityInfo.lon
                                                                     zoom:16];
        mapView_ = [GMSMapView mapWithFrame:self.m_MapView.bounds camera:camera];
        mapView_.myLocationEnabled = YES;
        mapView_.settings.compassButton = YES;
        mapView_.settings.myLocationButton = YES;
        mapView_.mapType = kGMSTypeNormal;
        mapView_.trafficEnabled = YES;
        mapView_.delegate = self;
        
        [self.m_MapView addSubview:mapView_];
        
        [self showParking];
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
//    if( mCityInfo != nil )
//        [self showParking];
}


- (void)dealloc {
  [mapView_ removeObserver:self
                forKeyPath:@"myLocation"
                   context:NULL];
}

#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if([keyPath isEqualToString:@"myLocation"]) {

        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        if (!_firstLocationUpdate) {
            _firstLocationUpdate = YES;
            mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                     zoom:16];
        }
    }

}

- (void)showParking {
  
   //[mapView_ clear];
    
    [ParkPanaDatabaseAPI GetParkingInfoListInCity:mCityInfo.cityid callback:^(NSMutableArray* parkingInfoList) {

//        CLLocation * location = [[CLLocation alloc] initWithLatitude:52.3833666666666 longitude:52.3833666666666];
//        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:16];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mCityInfo.lat
                                                                longitude:mCityInfo.lon
                                                                     zoom:16];
        [mapView_ setCamera:camera];
        
        m_parkingInfos = [parkingInfoList mutableCopy];
        __block NSUInteger count = 0;
        [m_parkingInfos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { //only one
            
            ParkingInfo *parkingInfo = obj;
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake(parkingInfo.lat, parkingInfo.lon);
            marker.title = parkingInfo.name;
            marker.snippet = [NSString stringWithFormat:@"Price: %d£/h, FreeSpots: %d", parkingInfo.price, parkingInfo.freeSpace];
            
            __block UIImage *image = nil;
            image = [self locationImageWithFreeSpace:parkingInfo.freeSpace];
            marker.icon = image;
            
            
            //marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.userData = parkingInfo;
            marker.map = mapView_;
            
            count = idx+1;
            
            
            // Listen to the myLocation property of GMSMapView.
            [mapView_ addObserver:self
                       forKeyPath:@"myLocation"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
            
            // Ask for My Location data after the map has already been added to the UI.
            dispatch_async(dispatch_get_main_queue(), ^{
                mapView_.myLocationEnabled = YES;
            });
            
        }];
        
    }];
  
}

- (UIImage *)locationImageWithFreeSpace:(NSUInteger)space{
    UIImage *image = nil;
    if(space < 10){
        image = [UIImage imageNamed:@"location_re"];
    }else if(space < 20){
        image = [UIImage imageNamed:@"location_ye"];
    }else{
        image = [UIImage imageNamed:@"location_gr"];
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height), NO, 0.0);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    NSString *string = [NSString stringWithFormat:@"%d", space];
    [RGB(70, 70, 70) set];
    
    
    if(string.length == 1){
        [string drawInRect:CGRectMake(8, 2.5, 20, 20) withFont:[UIFont systemFontOfSize:14]];
    }else if(string.length == 2){
        [string drawInRect:CGRectMake(4, 2.5, 20, 20) withFont:[UIFont systemFontOfSize:14]];
    }else{
        [string drawInRect:CGRectMake(0, 2.5, 30, 20) withFont:[UIFont systemFontOfSize:14]];
    }
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

#pragma mark GMSMapViewDelegate

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    return nil;
}

- (void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
//    NSString *message =
//    [NSString stringWithFormat:@"Info window for marker %@ LongPress.", marker.title];
//    [self showMessage:message];
    
    tapedParkingInfo = marker.userData;
    
    //[self performSegueWithIdentifier:kParkingProfileViewControllerSegue sender:nil];
    if( tapedParkingInfo.parkID != nil )
    {
        [ParkPanaDatabaseAPI GetParkingInfo:tapedParkingInfo.parkID cityID:mCityInfo.cityid callback:^(ParkingInfo* vParkingInfo) {
            
            [(ParkingProfileViewController *)[[AppDelegate sharedDelegate] parkingProfileViewController] setProfileData:vParkingInfo];
            
            tapedParkingInfo = nil;

            [[AppDelegate sharedDelegate] parkingProfile];

        }];
        
    }
    
}


#pragma mark Private

- (void)showMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]                               initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    [alertView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}


#pragma mark FloatingDrawer

- (JVFloatingDrawerSpringAnimator *)drawerAnimator {
    return [[AppDelegate sharedDelegate] drawerAnimator];
}


- (IBAction)actionToggleSettingViewController:(id)sender {
    self.drawerAnimator.animationDuration = 0.7;
    self.drawerAnimator.animationDelay = 0;
    self.drawerAnimator.initialSpringVelocity = 9;
    self.drawerAnimator.springDamping = 0.8;

    [[AppDelegate sharedDelegate] toggleSettingViewController:self animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:kParkingProfileViewControllerSegue])
    
//    [[AppDelegate sharedDelegate] parkingProfile];
//    if( tapedParkingInfo )
//    {
//        [(ParkingProfileViewController *)[[AppDelegate sharedDelegate] parkingProfileViewController] setProfileData:g_Setting ParkingID:tapedParkingInfo.parkID];
//            tapedParkingInfo = nil;
//    }
//    else
//    {
//            [(ParkingProfileViewController *)[[AppDelegate sharedDelegate] parkingProfileViewController] setProfileData:g_Setting ParkingID:[self findNearestParking]];
//    }
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    //[self showParking:position.target.latitude Longitude:position.target.longitude Zoom:mapView.camera.zoom];

}

- (void) showHelperViewController{
    HelperViewController *helperViewController = [[HelperViewController alloc] initWithNibName:@"HelperViewController" bundle:nil];
    helperViewController.delegate = self;
    [self presentPopupViewController:helperViewController animationType:MJPopupViewAnimationSlideTopTop];
}

- (IBAction)actionFind:(id)sender {
    [[AppDelegate sharedDelegate] findScreen];
}

- (void)setCityInfo:(CityInfo*)cityInfo
{
    mCityInfo = cityInfo;
}

@end
