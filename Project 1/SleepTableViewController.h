//
//  SleepTableViewController.h
//  Project 1
//
//  Created by David Ganey on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#pragma once

#import <UIKit/UIKit.h>

#include "SleepItem.h"
#include "SleepStatsViewController.h"

@interface SleepTableViewController : UITableViewController

@property NSMutableArray *entries;
@property NSMutableString *entries2;
- (IBAction)statsPressed:(id)sender;

@end
