//
//  SleepViewController.h
//  Project 1
//
//  Created by David Ganey on 3/7/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *sleepLabel;
- (IBAction)sleepButtonPressed:(id)sender;
- (IBAction)historyPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sleepButton;

@property (strong, nonatomic) NSTimer* sleepTimer;
@property (strong, nonatomic) NSDate* startDate;

@end
