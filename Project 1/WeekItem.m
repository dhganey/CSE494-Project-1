//
//  DayItem.m
//  Project 1
//
//  Created by alfheim on 3/27/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

/*complete*/

#import "WeekItem.h"

@implementation WeekItem

-(id) init{
    self = [super init];
    self.sunday = [NSNumber numberWithBool:YES];
    self.monday = [NSNumber numberWithBool:YES];
    self.tuesday = [NSNumber numberWithBool:YES];
    self.wednesday = [NSNumber numberWithBool:YES];
    self.thursday = [NSNumber numberWithBool:YES];
    self.friday = [NSNumber numberWithBool:YES];
    self.saturday = [NSNumber numberWithBool:YES];
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        self.sunday = [aDecoder decodeObjectForKey:@"sunday"];
        self.monday = [aDecoder decodeObjectForKey:@"monday"];
        self.tuesday = [aDecoder decodeObjectForKey:@"tuesday"];
        self.wednesday = [aDecoder decodeObjectForKey:@"wednesday"];
        self.thursday = [aDecoder decodeObjectForKey:@"thursday"];
        self.friday = [aDecoder decodeObjectForKey:@"friday"];
        self.saturday = [aDecoder decodeObjectForKey:@"saturday"];
    }
    return self;
}
-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.sunday forKey:@"sunday"];
    [aCoder encodeObject:self.monday forKey:@"monday"];
    [aCoder encodeObject:self.tuesday forKey:@"tuesday"];
    [aCoder encodeObject:self.wednesday forKey:@"wednesday"];
    [aCoder encodeObject:self.thursday forKey:@"thursday"];
    [aCoder encodeObject:self.friday forKey:@"friday"];
    [aCoder encodeObject:self.saturday forKey:@"saturday"];
}

@end
