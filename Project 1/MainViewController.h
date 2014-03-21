//
//  MainViewController.h
//  Project 1
//
//  Created by David Ganey on 3/7/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "ProjectUser.h"

@interface MainViewController : UIViewController

- (IBAction)alarmPressed:(id)sender;
- (IBAction)journalPressed:(id)sender;
- (IBAction)sleepPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mainText;

@property ProjectUser* user;

@end
