//
//  AlarmItem.h
//  Project 1
//
//  Created by Connor Alfheim on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeekItem.h"

@interface AlarmItem : NSObject <NSCoding>

@property NSString *title;
@property NSNumber *hours;
@property NSNumber *minutes;
@property NSNumber *isOn;
@property (nonatomic, strong) WeekItem *days;
@property (nonatomic, strong) NSString *sound;
-(void) modifyDay:(NSString*)day setValue:(BOOL)newValue;
@end
