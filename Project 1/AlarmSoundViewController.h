//
//  AlarmSoundViewController.h
//  Project 1
//
//  Created by alfheim on 4/29/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AddAlarmViewController.h"
@class AlarmSoundViewController;
@protocol AddSoundViewControllerDelegate //<NSObject>
-(void)addItemViewController:(AlarmSoundViewController *)controller didFinishEnteringItem:(MPMediaItem*) item;
@end

@interface AlarmSoundViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSMutableArray *songsList;
@property (nonatomic, weak) id <AddSoundViewControllerDelegate> delegate;

@end
