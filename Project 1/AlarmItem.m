//
//  AlarmItem.m
//  Project 1
//
//  Created by Connor Alfheim on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//
/*done*/
#import "AlarmItem.h"
#import "WeekItem.h"


@implementation AlarmItem

//overload init method to init with attributes
-(id)init;
{
    self = [super init];
    self.title = @"New Alarm";
    self.hours = 0;
    self.minutes = 0;
    self.days = [[WeekItem alloc] init];
    self.sound = @"defaultSong";
    self.isOn = [NSNumber numberWithBool:YES];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.title = [aDecoder decodeObjectForKey:@"alarmTitle"];
        self.hours = [aDecoder decodeObjectForKey:@"alarmHours"];
        self.minutes = [aDecoder decodeObjectForKey:@"alarmMinutes"];
        self.days = [aDecoder decodeObjectForKey:@"alarmDays"];
        self.sound = [aDecoder decodeObjectForKey:@"alarmSound"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"alarmTitle"];
    [aCoder encodeObject:self.hours forKey:@"alarmHours"];
    [aCoder encodeObject:self.minutes forKey:@"alarmMinutes"];
    [aCoder encodeObject:self.days forKey:@"alarmDays"];
    [aCoder encodeObject:self.sound forKey:@"alarmSound"];
}

-(void) modifyDay:(NSString*)day setValue:(BOOL)newValue{
    if( [day  isEqual: @"sunday"])
        self.days.sunday = [NSNumber numberWithBool:newValue];
    else if( [day  isEqual: @"monday"])
        self.days.monday = [NSNumber numberWithBool:newValue];
    else if( [day  isEqual: @"tuesday"])
        self.days.tuesday= [NSNumber numberWithBool:newValue];
    else if( [day  isEqual: @"wednesday"])
        self.days.wednesday = [NSNumber numberWithBool:newValue];
    else if( [day  isEqual: @"thursday"])
        self.days.thursday = [NSNumber numberWithBool:newValue];
    else if( [day  isEqual: @"friday"])
        self.days.friday = [NSNumber numberWithBool:newValue];
    else if( [day  isEqual: @"saturday"])
        self.days.saturday = [NSNumber numberWithBool:newValue];
}

@end
