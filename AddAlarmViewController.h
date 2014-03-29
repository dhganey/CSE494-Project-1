//
//  AddAlarmViewController.h
//  Project 1
//
//  Created by alfheim on 3/27/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AlarmItem.h"

@class AddAlarmViewController;
@protocol AddAlarmViewControllerDelegate <NSObject>
-(void) addItemViewController:(AddAlarmViewController *)controller didFinishEnteringItem:(AlarmItem*) item;
@end


@interface AddAlarmViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (nonatomic, weak) id <AddAlarmViewControllerDelegate> delegate;

@end



