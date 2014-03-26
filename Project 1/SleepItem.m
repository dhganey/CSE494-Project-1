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
        self.time = [aDecoder decodeObjectForKey:@"time"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.time forKey:@"time"];
}

@end
