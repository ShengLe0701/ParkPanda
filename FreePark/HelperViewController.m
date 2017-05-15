//
//  HelperViewController.m
//  FreePark
//
//  Created by LovelyPony on 29/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import "HelperViewController.h"

@interface HelperViewController ()

@end

@implementation HelperViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsideExit:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

@end
