//
//  AlarmViewController.h
//  Project 1
//
//  Created by Connor Alfheim on 3/7/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *alarmNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *alarmTimeLabel;
@property (strong, nonatomic) IBOutlet UISwitch *alarmButton;

@end
