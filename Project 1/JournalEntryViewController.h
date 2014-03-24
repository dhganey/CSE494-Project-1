//
//  JournalEntryViewController.h
//  Project 1
//
//  Created by David Ganey on 3/19/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JournalEntryViewController : UIViewController

@property NSString* entryContent;
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@end
