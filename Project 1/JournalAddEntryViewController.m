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
    
    
    [self setTitle:@"Add Entry"];
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
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    /*
    JournalViewController* nextVC = segue.destinationViewController;
    nextVC.createdContent = self.contentView.text;
    nextVC.createdTitle = @"Newly Created Item";
     */
}

@end
