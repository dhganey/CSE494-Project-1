//
//  SleepItem.m
//  Project 1
//
//  Created by David Ganey on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "SleepItem.h"

@implementation SleepItem

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.dateSlept = [aDecoder decodeObjectForKey:@"dateSlept"];
        self.timeSlept = [aDecoder decodeObjectForKey:@"timeSlept"];
        self.secondsSlept = [aDecoder decodeDoubleForKey:@"secondsSlept"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dateSlept forKey:@"dateSlept"];
    [aCoder encodeObject:self.timeSlept forKey:@"timeSlept"];
    [aCoder encodeDouble:self.secondsSlept forKey:@"secondsSlept"];
}

@end
