//
//  AddAlarmViewController.m
//  Project 1
//
//  Created by alfheim on 3/27/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "AddAlarmViewController.h"

@implementation AddAlarmViewController

/********* App methods ********/
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
    self.titleField.delegate = self;
    
    
	// Do any additional setup after loading the view.
    // listens to keyboard
    [self registerForKeyboardNotifications];
    self.responseLabel.hidden = YES;
    
    // check and set preset values
    if(self.presetTitle)
        self.titleField.text = self.presetTitle;
    if (self.presetDate)
        self.timePicker.date = self.presetDate;
    if(self.alarmItem)
        self.alarmSoundLabel.text =[self.alarmItem valueForProperty:MPMediaItemPropertyTitle];
    int BUTTON_BASE = 21;
    if (self.days)
    {
        
        for (int i = 0; i <[self.days count]; i++){
            UIButton *day = (UIButton*)[self.scrollView viewWithTag:BUTTON_BASE+i];
            day.selected = [(NSNumber *)[self.days objectAtIndex:i] boolValue];
            if (day.selected)
                day.backgroundColor = [UIColor greenColor];
            else
                day.backgroundColor = [UIColor redColor];
        }
    }
    else {
        for (int i = 0; i < 7; i++)
        {
            UIButton *day = (UIButton*)[self.scrollView viewWithTag:BUTTON_BASE+i];
            day.selected = 1;
            day.backgroundColor = [UIColor greenColor];
        }
            
    }
}

/************ Lazy method of toggling days ********/
- (IBAction)toggleSunday:(id)sender {
    UIButton *sunday = (UIButton *) sender;
    sunday.selected = !sunday.selected;
    if (sunday.selected)
        sunday.backgroundColor = [UIColor greenColor];
    else
        sunday.backgroundColor = [UIColor redColor];
}

- (IBAction)toggleMonday:(id)sender {
    UIButton *monday = (UIButton *) sender;
    monday.selected = !monday.selected;
    if (monday.selected)
        monday.backgroundColor = [UIColor greenColor];
    else
        monday.backgroundColor = [UIColor redColor];
}

- (IBAction)toggleTuesday:(id)sender {
    UIButton *tuesday = (UIButton *) sender;
    tuesday.selected = !tuesday.selected;
    if (tuesday.selected)
        tuesday.backgroundColor = [UIColor greenColor];
    else
        tuesday.backgroundColor = [UIColor redColor];
}

- (IBAction)toggleWednesday:(id)sender {
    UIButton *wednesday = (UIButton *) sender;
    wednesday.selected = !wednesday.selected;
    if (wednesday.selected)
        wednesday.backgroundColor = [UIColor greenColor];
    else
        wednesday.backgroundColor = [UIColor redColor];
}

- (IBAction)toggleThursday:(id)sender {
    UIButton *thursday = (UIButton *) sender;
    thursday.selected = !thursday.selected;
    if (thursday.selected)
        thursday.backgroundColor = [UIColor greenColor];
    else
        thursday.backgroundColor = [UIColor redColor];
}

- (IBAction)toggleFriday:(id)sender {
    UIButton *friday = (UIButton *) sender;
    friday.selected = !friday.selected;
    if (friday.selected)
        friday.backgroundColor = [UIColor greenColor];
    else
        friday.backgroundColor = [UIColor redColor];
}

- (IBAction)toggleSaturday:(id)sender {
    UIButton *saturday = (UIButton *) sender;
    saturday.selected = !saturday.selected;
    if (saturday.selected)
        saturday.backgroundColor = [UIColor greenColor];
    else
        saturday.backgroundColor = [UIColor redColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**** keyboard methods ****/
//Should hide the keyboard when return pressed
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#warning this method is not right
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

//Hides the keyboard when touched (does not work in UITextArea)
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.scrollView endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

//Should hide the keyboard when return pressed
- (BOOL)textFieldShouldReturn:(UITextField *)depositText
{
    // Any additional checks to ensure you have the correct textField here.
    //[self.scrollView endEditing:YES];
    [self.titleField resignFirstResponder];
    return true;
}

// returns an nsmutablearray of the status of the seven day buttons
-(NSMutableArray*)getDaysSelected{
    int BUTTON_BASE = 21;
    NSMutableArray *daysSelected = [[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++){
        UIButton *day = (UIButton*)[self.scrollView viewWithTag:BUTTON_BASE+i];
        NSNumber *isSelected = [NSNumber numberWithBool:day.selected];
        [daysSelected addObject:isSelected];
    }
    return daysSelected;
}


// this scrolls the window to the input field
/*
-(void)keyboardWillShow:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGSize keyboardSize = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey]CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height -= keyboardSize.height;
    self.scrollView.frame = viewFrame;
}
// this scrolls the window back to the bottom
-(void)keyboardWillHide:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGSize keyboardSize = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey]CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.size.height += keyboardSize.height;
    self.scrollView.frame = viewFrame;
}

- (BOOL)textFieldShouldReturn:(UITextField *)field
{
    // Any additional checks to ensure you have the correct textField here.
    [self.titleField endEditing:YES];
    //[withdrawalText resignFirstResponder];
    return true;
}
*/
-(void) tapped
{
    [self.view endEditing:YES];
}

/******** send information to create item********/
-(IBAction)createButtonClicked:(id)sender{
    if( [self.titleField.text length] >0){
        AlarmItem *item = [[AlarmItem alloc] init];
        item.title = self.titleField.text;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self.timePicker.date];
        item.hours = [NSNumber numberWithInteger:[components hour]];
        item.minutes = [NSNumber numberWithInteger:[components minute]];
        item.weekdays = [self getDaysSelected];
        item.alarmSoundItem = self.alarmItem;
        [self.delegate addItemViewController:self didFinishEnteringItem:item];
        // return to previous view
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.responseLabel.hidden = NO;
    }
}

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// segues to alarm sound view controller
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AlarmSoundViewController *nextVC = segue.destinationViewController;
    nextVC.delegate = self;
}

// sets the alarm item
-(void)addItemViewController:(AlarmSoundViewController *)controller didFinishEnteringItem:(MPMediaItem*) item{
    self.alarmItem = item;
    self.alarmSoundLabel.text =[self.alarmItem valueForProperty:MPMediaItemPropertyTitle];
}


@end
