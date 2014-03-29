//
//  JournalAddEntryViewController.m
//  Project 1
//
//  Created by David Ganey on 3/19/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "JournalAddEntryViewController.h"

#include "JournalViewController.h"

@interface JournalAddEntryViewController ()

//synthesize property?

@end

@implementation JournalAddEntryViewController

//Initializes the entry
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Sets the text in the view to the content passed to the view controller from JournalViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentView.text = self.entryContent;
    //[self.contentView sizeToFit];
    self.titleView.text = self.entryTitle;
    
    self.navigationController.navigationBar.topItem.title = @"Save Entry";
    
    //add observers for notifications
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
    self.contentView.textContainer.lineFragmentPadding = 0;
    self.contentView.textContainerInset = UIEdgeInsetsZero;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//Removes observer from NSNotificationCenter
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyBoardWillShow:(NSNotification*) notification
{
    NSLog(@"Keyboard showing");
    
    CGRect theFrame = self.contentView.frame;
    theFrame.size.height -= 220;
    self.contentView.frame = theFrame;
}

-(void)keyBoardWillHide:(NSNotification *)notification
{
    NSLog(@"Keyboard hiding");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Hides the keyboard when touched (does not work in UITextArea)
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

//Should hide the keyboard when return pressed
- (BOOL)textFieldShouldReturn:(UITextField *)depositText
{
    // Any additional checks to ensure you have the correct textField here.
    [self.contentView endEditing:YES];
    //[withdrawalText resignFirstResponder];
    return true;
}

#pragma mark - Navigation

//DEPRICATED--does not execute
//When segueing, creates a new JournalItem with the content in the view and passes it back to its delegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    JournalItem* myItem = [[JournalItem alloc] init];
    NSString *content = self.contentView.text;
    NSString *title = @"Test title";
    myItem.entryContent = content;
    myItem.entryTitle = title;
    NSDate *newDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    newDate = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:newDate]];
    myItem.entryDate = newDate;
    
    [self.delegate addItemViewController:self didFinishEnteringItem:myItem];
    
}

//When view is going to disappear, creates a new JournalItem with content in view and passes it back to its delegate (JournalViewController)
-(void) viewWillDisappear:(BOOL)animated
{
    /*
     JournalViewController* nextVC = segue.destinationViewController;
     nextVC.createdContent = self.contentView.text;
     nextVC.createdTitle = @"Newly Created Item";
     */
    
    JournalItem* myItem = [[JournalItem alloc] init];
    NSString *content = @"";
    if (self.contentView.text != NULL)
    {
        content = self.contentView.text;
        
    }
    NSString *title = @"";
    if ([self.titleView.text length] != 0)
    {
        title = self.titleView.text;
    }
    else
    {
        title = @"Title";
    }
    
    
    myItem.entryContent = content;
    myItem.entryTitle = title;
    NSDate *newDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    newDate = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:newDate]];
    myItem.entryDate = newDate;
    
    [self.delegate addItemViewController:self didFinishEnteringItem:myItem];
    
}

@end
