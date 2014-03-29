//
//  AddAlarmViewController.m
//  Project 1
//
//  Created by alfheim on 3/27/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "AddAlarmViewController.h"

@implementation AddAlarmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**** keyboard methods ****/
//Should hide the keyboard when return pressed
- (BOOL)textFieldShouldReturn:(UITextField *)depositText
{
    // Any additional checks to ensure you have the correct textField here.
    [self.titleField endEditing:YES];
    //[withdrawalText resignFirstResponder];
    return true;
}

//Hides the keyboard when touched (does not work in UITextArea)
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(void) viewWillDisappear:(BOOL)animated
{
    AlarmItem *item = [[AlarmItem alloc] init];
    item.title = self.titleField.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"<your date format goes here"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self.timePicker.date];
    item.hours = [NSNumber numberWithInteger:[components hour]];
    item.minutes = [NSNumber numberWithInteger:[components minute]];
    [self.delegate addItemViewController:self didFinishEnteringItem:item];
}
@end
