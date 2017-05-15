//
//  UIViewController+Addition.m
//  Parking
//
//  Created by Tonny on 5/23/12.
//  Copyright (c) 2012 Parking. All rights reserved.
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

- (void)setSubtitle:(NSString *)subtitle{
    if(self.navigationController == nil) return;
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    
    UILabel *subLbl = (UILabel *)[bar viewWithTag:100];
    if(!subLbl){
        subLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 28, 220, 15)];
        subLbl.tag = 100;
        subLbl.backgroundColor = [UIColor clearColor];
        subLbl.font = [UIFont boldSystemFontOfSize:10];
        
        subLbl.textColor = [bar.titleTextAttributes objectForKey:UITextAttributeTextColor];
        subLbl.shadowColor = [bar.titleTextAttributes objectForKey:UITextAttributeTextShadowColor];
        
        CGSize size;
        [[bar.titleTextAttributes objectForKey:UITextAttributeTextShadowOffset] getValue:&size];
        subLbl.shadowOffset = size;
        
        subLbl.textAlignment = UITextAlignmentCenter;
        [bar addSubview:subLbl];
    }
    
    subLbl.text = subtitle;
}

@end
