//
//  AlarmItem.h
//  Project 1
//
//  Created by Connor Alfheim on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmItem : NSObject <NSCoding>

@property NSString *title;
@property NSDate *time;
@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSString *sound;

@end
