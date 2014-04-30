//
//  AddAlarmViewController.h
//  Project 1
//
//  Created by alfheim on 3/27/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AlarmItem.h"
#import "AlarmSoundViewController.h"

@class AddAlarmViewController;
@protocol AddAlarmViewControllerDelegate //<NSObject>
-(void) addItemViewController:(AddAlarmViewController *)controller didFinishEnteringItem:(AlarmItem*) item;
@end


@interface AddAlarmViewController : UIViewController <UITextFieldDelegate>{
}

@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic ) UITextField * activeField;
@property (nonatomic, weak) id <AddAlarmViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;


@property NSDate *presetDate;
@property NSString *presetTitle;
@property NSMutableArray *presetWeekdays;
@property MPMediaItem * alarmItem;
@property (weak, nonatomic) IBOutlet UILabel *alarmSoundLabel;
@property NSMutableArray * days;

@end



