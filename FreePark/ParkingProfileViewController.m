//
//  ProfileViewController.m
//  Parking
//
//  Created by Tonny on 5/6/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "ParkingProfileViewController.h"
#import "FPGlobal.h"
#import "ParkingInfo.h"
#import "ParkPanaDatabaseAPI.h"
#import "AppDelegate.h"
#import "MapNavigationViewController.h"
#import "MainMapViewController.h"
#import "AFHTTPRequestOperationManager.h"

@import Firebase;

//#define BRAINTREE_SERVER @"parkpanda-1372.firebaseapp.com:3000"
#define BRAINTREE_SERVER @"http://ec2-54-254-198-176.ap-southeast-1.compute.amazonaws.com:3000"

@import GoogleMaps;

@interface ParkingProfileViewController ()

@end

@implementation ParkingProfileViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showProfileInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [self showProfileInfo];
}

- (void)viewDidUnload
{
    _imgView = nil;
    _barImgView = nil;
    _nameLbl = nil;
    _addressLbl = nil;
    _timeLbl = nil;
    _infoLbl = nil;
    _priceLbl = nil;
    _freelots = nil;
    totalLotsLbl = nil;
    
    [super viewDidUnload];
}

- (void)showProfileInfo
{
    if( parkingInfo == nil )
        return;
    
//    _imgView.image = [UIImage imageNamed:parkingInfo.bigPicture];
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage referenceForURL:@"gs://parkpanda-1372.appspot.com"];
    // Create a reference to the file you want to download
    FIRStorageReference *starsRef = [storageRef child:parkingInfo.image];
    // Fetch the download URL
    [starsRef downloadURLWithCompletion:^(NSURL *URL, NSError *error){
        if (error != nil) {
            // Handle any errors
        } else {
            // Get the download URL for 'images/stars.jpg'
            _imgView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:URL]];;
        }
    }];
    
    _nameLbl.text = parkingInfo.name;
    _addressLbl.text = parkingInfo.address;
    
    _timeLbl.text = parkingInfo.time;

    _infoLbl.text = parkingInfo.desc;

    _priceLbl.text = [NSString stringWithFormat:@"%d", parkingInfo.price];
    
    UIImage *image = nil;
    NSUInteger left = parkingInfo.freeSpace;
    if(left < 10){
        image = [UIImage imageNamed:@"bar_re"];
    }else if(left < 20){
        image = [UIImage imageNamed:@"bar_ye"];
    }else{
        image = [UIImage imageNamed:@"bar_gr"];
    }
    _barImgView.image = image;

    _freelots.text = [NSString stringWithFormat:@"%d", parkingInfo.freeSpace];
    totalLotsLbl.text = [NSString stringWithFormat:@"%d", parkingInfo.totalSpace];
}

- (IBAction)touchUpInsidePayment:(id)sender {
    // If you haven't already, create and retain a `BTAPIClient` instance with a tokenization
    // key or a client token from your server.
    // Typically, you only need to do this once per session.
    //NSString *tokenizationKey = @"sandbox_8vcb75vs_fny889dtvrnpn64g";
    //self.braintreeClient = [[BTAPIClient alloc] initWithAuthorization:tokenizationKey];
    
    // This is where you might want to customize your view controller (see below)
    
    // The way you present your BTDropInViewController instance is up to you.
    // In this example, we wrap it in a new, modally-presented navigation controller:
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager GET:[NSString stringWithFormat:@"%@/token", BRAINTREE_SERVER ]
      parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSString *clientToken = responseObject[@"clientToken"];
          
//                           NSString *clientToken = @"eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJlNDI3OTcwYWQ5YWU4MWNjMDRjNDdkNWJkNWRjOWFiN2IyNGFkY2FmZWE4ZTI1NzI2NzcyNGE4YjBmOTg2OTQwfGNyZWF0ZWRfYXQ9MjAxNi0wNy0yOFQxNTo1Nzo1MS4yNjM5MzE2ODkrMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tLzM0OHBrOWNnZjNiZ3l3MmIifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJjb2luYmFzZUVuYWJsZWQiOmZhbHNlLCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";
             
            NSLog(@"Braintree: Get Token OK: %@", clientToken);
            self.braintreeClient = [[BTAPIClient alloc] initWithAuthorization:clientToken];
             
          
            // Create a BTDropInViewController
            dropInViewController = [[BTDropInViewController alloc]
                                        initWithAPIClient:self.braintreeClient];
            dropInViewController.delegate = self;

          
            BTPaymentRequest *paymentRequest = [[BTPaymentRequest alloc] init];
            paymentRequest.summaryTitle = @"Amount";
            paymentRequest.summaryDescription = [NSString stringWithFormat:@"%@, %d£ / h", parkingInfo.name, parkingInfo.price];
            paymentRequest.displayAmount = [NSString stringWithFormat:@"%d£", parkingInfo.price];
            paymentRequest.callToActionText = [NSString stringWithFormat:@"%d£  --> Payment  ",parkingInfo.price];
            dropInViewController.paymentRequest = paymentRequest;
          
            UIBarButtonItem *item = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                      target:self
                                      action:@selector(userDidCancelPayment)];
             dropInViewController.navigationItem.leftBarButtonItem = item;
             UINavigationController *navigationController = [[UINavigationController alloc]
                                                             initWithRootViewController:dropInViewController];
             [self presentViewController:navigationController animated:YES completion:nil];
             
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Braintree: Token Error");
    }];
}

- (void)userDidCancelPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -  Braintree Delegate
- (void)dropInViewController:(BTDropInViewController *)viewController
  didSucceedWithTokenization:(BTPaymentMethodNonce *)paymentMethodNonce {
    // Send payment method nonce to your server for processing
    [self postNonceToServer:paymentMethodNonce.nonce];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)postNonceToServer:(NSString *)paymentMethodNonce {
    
    NSDictionary *params = nil;
    
        //TODO Add validation here?
    params = @{@"amount": [NSString stringWithFormat:@"%d",parkingInfo.price],
               @"payment_method_nonce" : paymentMethodNonce};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@/payment", BRAINTREE_SERVER ]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Braintree: Payment Successful");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Braintree: Payment Error");
          }];
    
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchUpInsideBack:(id)sender {
    
    [[AppDelegate sharedDelegate] mainScreen];
}

- (IBAction)touchInsideTracking:(id)sender
{
    if( parkingInfo == nil )
        return;
    
    MapNavigationViewController *mapNavigationViewController = [[AppDelegate sharedDelegate] mapNavigationViewController];
    [mapNavigationViewController setParkingInfo:parkingInfo];
    
    [[AppDelegate sharedDelegate] mapNavigationScreen];
}

- (void)setProfileData:(ParkingInfo*)aParkingInfo{
    
    parkingInfo = aParkingInfo;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return parkingLogInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)doMaskMe{

//    [Utility takePhotoWithDelegate:self inViewController:self];
//    
//    [self doSetting];
}

- (void)doLocateMyCar{
//    LocateFreeSapceViewController *suggestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LocateFreeSapceViewController"];
//    suggestVC.point = self.data;
//    ParkNavigationController *naVC = [[ParkNavigationController alloc] initWithRootViewController:suggestVC];
//    [self presentModalViewController:naVC animated:YES];
//    
//    [self doSetting];
}

- (void)doConsum{
    [self doSetting];    
}

- (void)doSetting {
//    if(!_showPopView){
//        _showPopView = YES;
//        
//        _popView = [[[NSBundle mainBundle] loadNibNamed:@"PopoverView" owner:self options:nil] objectAtIndex:0];
//        //        _popView.alpha = 0;
//        _popView.right = 320;
//        _popView.bottom = 0;
//        [self.view addSubview:_popView];
//        
//        if(![DataEnvironment sharedDataEnvironment].isMaskMe){
//            UIButton *button1 = (UIButton *)[_popView viewWithTag:1];
//            [button1 setImage:[UIImage imageNamed:@"btn_mask.png"] forState:UIControlStateNormal];
//            [button1 addTarget:self action:@selector(doMaskMe) forControlEvents:UIControlEventTouchUpInside];
//        }else {
//            UIButton *button1 = (UIButton *)[_popView viewWithTag:1];
//            [button1 setImage:[UIImage imageNamed:@"btn_findcar.png"] forState:UIControlStateNormal];
//            [button1 addTarget:self action:@selector(doLocateMyCar) forControlEvents:UIControlEventTouchUpInside];            
//        }
//        
//        UIButton *button2 = (UIButton *)[_popView viewWithTag:2];
//        [button2 setImage:[UIImage imageNamed:@"btn_pay.png"] forState:UIControlStateNormal];
//        [button2 addTarget:self action:@selector(doConsum) forControlEvents:UIControlEventTouchUpInside];
//        
//        [UIView animateWithDuration:0.3f
//                         animations:^{
//                             //                             _popView.alpha = 1;
//                             _popView.top = 0;
//                         }];
//    }else{
//        _showPopView = NO;
//        [UIView animateWithDuration:0.3f
//                         animations:^{
//                             //                             _popView.alpha = 0;
//                             _popView.bottom = 0;
//                         }completion:^(BOOL finished) {
//                             [_popView removeFromSuperview]; _popView = nil;
//                         }];
//    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSString *string = [actionSheet buttonTitleAtIndex:buttonIndex];
//    if([string isEqualToString:@"Start"]){
//        [DataEnvironment sharedDataEnvironment].isParking = YES;
//        [_rightNavigationBarBtn setImage:[UIImage imageNamed:@"btn_more.png"] forState:UIControlStateNormal];
//        
//        if(_isBelowParking){
//            
//        }else{
//            
//        }
//    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
//    [DataEnvironment sharedDataEnvironment].isMaskMe = YES;
//    
//    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];

}


@end
