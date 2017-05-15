//
//  MapNavigationViewController.m
//  FreePark
//
//  Created by LovelyPony on 26/07/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "MapNavigationViewController.h"
#import "MainMapViewController.h"
#import "AppDelegate.h"

@import GoogleMaps;

@interface MapNavigationViewController ()

@end

@implementation MapNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _progressManager = [[NJKWebViewProgress alloc] init];
//    _progressManager.webViewProxyDelegate = self;
//    _progressManager.progressDelegate = self;
//    
//    m_WebView.delegate = self.progressManager;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
//    m_WebView.delegate = self;
//    NSString *urlString = [NSString stringWithFormat:@"https://maps.google.com" ];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    
//    [m_WebView loadRequest:urlRequest];
    
    MainMapViewController *mainMapViewController = [[AppDelegate sharedDelegate] mainMapViewController];
    CLLocationCoordinate2D currentPosition = [mainMapViewController mapView].myLocation.coordinate;

    [self setNavigationInfoWithSrcLatitude:currentPosition.latitude SrcLongitude:currentPosition.longitude DstLatitude:parkingInfo.lat DstLongitude:parkingInfo.lon];
    [locationManager startUpdatingLocation];
    
}

- (void)setParkingInfo:(ParkingInfo*)aParkingInfo
{
    parkingInfo = aParkingInfo;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setNavigationInfoWithSrcLatitude:(float)srcLat SrcLongitude:(float)srcLong DstLatitude:(float)dstLat DstLongitude:(float)dstLong
{
    NSString *urlString = [NSString stringWithFormat:@"https://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&views=traffic", srcLat, srcLong, dstLat, dstLong ];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [m_WebView loadRequest:urlRequest];
}

- (IBAction)touchInSideBack:(id)sender {
    [[AppDelegate sharedDelegate] mainScreen];
}

UIAlertView *alertView1;
int alertViewCount = 0;
UIAlertView *alertView2;

//Delegate CLLocationManager
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
//    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    double distance = getDistanceMetresBetweenLocationCoordinates(newLocation.coordinate, (CLLocationCoordinate2D){.latitude = parkingInfo.lat, .longitude = parkingInfo.lon} );
    
    if( distance < 50 )
    {
        [locationManager stopUpdatingLocation];
        
        alertViewCount = 0;
        alertView1 = [[UIAlertView alloc]
                                  initWithTitle:@"ParkPanda"
                                  message:@"Did you Park your Panda?"
                                  delegate:self
                                  cancelButtonTitle:@"NO"
                                  otherButtonTitles:nil,
                                  nil];
        [alertView1 addButtonWithTitle:@"YES"];
        

        alertView2 = [[UIAlertView alloc]
                      initWithTitle:@"ParkPanda"
                      message:@"Do you want to pay for the parking?"
                      delegate:self
                      cancelButtonTitle:@"NO"
                      otherButtonTitles:nil,
                      nil];
        [alertView2 addButtonWithTitle:@"YES"];

        
        [alertView1 show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if( alertView == alertView1 && alertViewCount < 2){
        alertViewCount ++;
        NSLog(@"Button Index =%ld",buttonIndex);
        if (buttonIndex == 0)
        {
            NSLog(@"You have clicked NO");
            [alertView1 show];
        }
        else if(buttonIndex == 1)
        {
            NSLog(@"You have clicked YES");
            [alertView2 show];
        }
    }
    else if(alertView == alertView2) {
        if (buttonIndex == 0)
        {
            NSLog(@"You have clicked NO");
        }
        else if(buttonIndex == 1)
        {
            NSLog(@"You have clicked YES");
        }
    }
    
}

-(void) processForPayment
{
    
}

double getDistanceMetresBetweenLocationCoordinates(
                                                   CLLocationCoordinate2D coord1,
                                                   CLLocationCoordinate2D coord2)
{
    CLLocation* location1 = [[CLLocation alloc] initWithLatitude: coord1.latitude longitude: coord1.longitude];
    CLLocation* location2 = [[CLLocation alloc] initWithLatitude: coord2.latitude longitude: coord2.longitude];
    
    return [location1 distanceFromLocation: location2];
}
@end
