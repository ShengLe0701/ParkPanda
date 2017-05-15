//
//  ProfileViewController.h
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPSetting.h"
#import "BraintreeCore.h"
#import "BraintreeUI.h"

@class ParkingInfo;
@class ParkingLogInfo;

@interface ParkingProfileViewController : UIViewController <UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, BTDropInViewControllerDelegate >{

    __weak IBOutlet UIImageView *_barImgView;
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel     *_nameLbl;
    __weak IBOutlet UILabel     *_addressLbl;
    __weak IBOutlet UILabel     *_timeLbl;
    __weak IBOutlet UILabel     *_infoLbl;
    __weak IBOutlet UILabel     *_priceLbl;
    __weak IBOutlet UILabel     *_freelots;
    __weak IBOutlet UILabel     *totalLotsLbl;
    
    ParkingInfo *parkingInfo;
    NSMutableArray *parkingLogInfos;
    
    BTDropInViewController *dropInViewController;
}

@property (nonatomic, strong) BTAPIClient *braintreeClient;

- (IBAction)touchUpInsidePayment:(id)sender;
- (IBAction)touchUpInsideBack:(id)sender;
- (IBAction)touchInsideTracking:(id)sender;
- (void)setProfileData:(ParkingInfo*)aParkingInfo;

@end
