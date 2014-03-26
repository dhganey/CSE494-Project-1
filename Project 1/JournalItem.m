//
//  JournalItem.m
//  Project 1
//
//  Created by David Ganey on 3/19/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "JournalItem.h"

@implementation JournalItem

//overload init method to init with attributes
-(id)init:(NSString *)t andContent:(NSString *)c andDate:(NSDate *)d
{
    self = [super init];
    self.entryTitle = t;
    self.entryContent = c;
    self.entryDate = d;
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.entryContent = [aDecoder decodeObjectForKey:@"EntryContent"];
        self.entryTitle = [aDecoder decodeObjectForKey:@"EntryTitle"];
        self.entryDate = [aDecoder decodeObjectForKey:@"EntryDate"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.entryContent forKey:@"EntryContent"];
    [aCoder encodeObject:self.entryTitle forKey:@"EntryTitle"];
    [aCoder encodeObject:self.entryDate forKey:@"EntryDate"];
}



@end
