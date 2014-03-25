//
//  JournalAddEntryViewController.h
//  Project 1
//
//  Created by David Ganey on 3/19/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

//#include "JournalEntryViewController.h"

#include "JournalItem.h"

@class JournalAddEntryViewController;

@protocol JournalAddEntryViewControllerDelegate <NSObject>

-(void) addItemViewController:(JournalAddEntryViewController *)controller didFinishEnteringItem:(JournalItem*) item;

@end

@interface JournalAddEntryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (nonatomic, weak) id <JournalAddEntryViewControllerDelegate> delegate;

@end
