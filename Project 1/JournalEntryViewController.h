//
//  JournalEntryViewController.h
//  Project 1
//
//  Created by David Ganey on 3/19/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

//NOTE: THIS CLASS IS NOW DEPRICATED AND IS NOT USED AT ALL IN THIS PROJECT

#import <UIKit/UIKit.h>

@interface JournalEntryViewController : UIViewController

@property NSString* entryContent;
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@end
