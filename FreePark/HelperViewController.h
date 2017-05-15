//
//  HelperViewController.h
//  FreePark
//
//  Created by LovelyPony on 29/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJHelperPopupDelegate;


@interface HelperViewController : UIViewController

- (IBAction)touchUpInsideExit:(id)sender;

@property (assign, nonatomic) id <MJHelperPopupDelegate>delegate;

@end

@protocol MJHelperPopupDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(HelperViewController*)helperViewController;

@end