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
    self.contentView.text = self.entryContent;
    self.titleView.text = self.entryTitle;
    
    
    self.navigationController.navigationBar.topItem.title = @"Save Entry";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)depositText
{
    // Any additional checks to ensure you have the correct textField here.
    [self.contentView endEditing:YES];
    //[withdrawalText resignFirstResponder];
    return true;
}

#pragma mark - Navigation

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
