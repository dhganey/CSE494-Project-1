//
//  AlarmItem.m
//  Project 1
//
//  Created by Connor Alfheim on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "AlarmItem.h"

@implementation AlarmItem

//overload init method to init with attributes
-(id)init:(NSString *)title andDate:(NSDate *)date andDays:(NSArray *)days;
{
    self = [super init];
    self.title = title;
    self.time = date;
    self.days =days;
    self.sound = @"defaultSong" ;
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.title = [aDecoder decodeObjectForKey:@"alarmTitle"];
        self.time = [aDecoder decodeObjectForKey:@"alarmTime"];
        self.days = [aDecoder decodeObjectForKey:@"alarmDays"];
        self.sound = [aDecoder decodeObjectForKey:@"alarmSound"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"alarmTitle"];
    [aCoder encodeObject:self.time forKey:@"alarmTime"];    [aCoder encodeObject:self.days forKey:@"alarmDays"];
    [aCoder encodeObject:self.sound forKey:@"alarmSound"];
}

@end
