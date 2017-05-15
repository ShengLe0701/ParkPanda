//
//  SettingTableViewController.h
//  FreePark
//
//  Created by LovelyPony on 22/02/2016.
//  Copyright © 2016 TanWernling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UILabel *txtAccount;
    __weak IBOutlet UILabel *txtDisplayName;
    __weak IBOutlet UILabel *txtEmail;
}

@end
