//
//  AlarmItem.m
//  Project 1
//
//  Created by Connor Alfheim on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//
/*done*/
#import "AlarmItem.h"


@implementation AlarmItem

//overload init method to init with attributes
-(id)init;
{
    self = [super init];
    self.title = @"New Alarm";
    self.hours = 0;
    self.minutes = 0;
    //self.days = [[WeekItem alloc] init];
    self.weekdays = [self initializeWeekdays];
    self.sound = @"defaultSong";
    self.isOn = [NSNumber numberWithBool:YES];
    return self;
}

-(NSMutableArray*)initializeWeekdays{
    NSNumber *sunday = [NSNumber numberWithBool:1];
    NSNumber *monday = [NSNumber numberWithBool:1];
    NSNumber *tuesday = [NSNumber numberWithBool:1];
    NSNumber *wednesday = [NSNumber numberWithBool:1];
    NSNumber *thursday = [NSNumber numberWithBool:1];
    NSNumber *friday = [NSNumber numberWithBool:1];
    NSNumber *saturday = [NSNumber numberWithBool:1];
    NSMutableArray *weekdays = [NSMutableArray arrayWithObjects:sunday,monday,tuesday,wednesday,thursday,friday,saturday, nil];
    return weekdays;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.title = [aDecoder decodeObjectForKey:@"alarmTitle"];
        self.hours = [aDecoder decodeObjectForKey:@"alarmHours"];
        self.minutes = [aDecoder decodeObjectForKey:@"alarmMinutes"];
       // self.days = [aDecoder decodeObjectForKey:@"alarmDays"];
        self.sound = [aDecoder decodeObjectForKey:@"alarmSound"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"alarmTitle"];
    [aCoder encodeObject:self.hours forKey:@"alarmHours"];
    [aCoder encodeObject:self.minutes forKey:@"alarmMinutes"];
   // [aCoder encodeObject:self.days forKey:@"alarmDays"];
    [aCoder encodeObject:self.sound forKey:@"alarmSound"];
}

-(void) modifyDay:(int)day setValue:(BOOL)newValue{
    //confirm valid imputs
    if(day < 7 && (newValue ==0 || newValue ==1)) {
        [self.weekdays replaceObjectAtIndex:day withObject:[NSNumber numberWithBool:newValue]];
    }
}

@end
