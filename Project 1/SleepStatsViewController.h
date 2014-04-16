//
//  SleepStatsViewController.h
//  Project 1
//
//  Created by David Ganey on 4/14/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#pragma once

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

#include "SleepItem.h"

@interface SleepStatsViewController : UIViewController <CPTPlotDataSource>

@property NSMutableArray *entries;

@end
