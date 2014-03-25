//
//  JournalItem.h
//  Project 1
//
//  Created by David Ganey on 3/19/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>

@interface JournalItem : NSObject

@property NSString* entryTitle;
@property NSString* entryContent;
@property NSDate* entryDate;

@end
