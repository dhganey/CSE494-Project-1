//
//  ProjectViewController.m
//  Project 1
//
//  Created by David Ganey on 3/6/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "ProjectViewController.h"

#include "MainViewController.h"

@interface ProjectViewController ()

@end

@implementation ProjectViewController

ProjectUser *user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    user = [[ProjectUser alloc] init];
    user.name = @""; //just in case
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (IBAction)nameEdited:(id)sender
{
    user.name = self.nameField.text;
    //TODO: take other info? end editing (implement keyboard hide methods). when user presses enter, call segue
}
*/

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)startPressed:(id)sender
{
    user.name = [self.nameField.text capitalizedString]; //capitalize username
    [self performSegueWithIdentifier:@"startSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navController = segue.destinationViewController;
    MainViewController* nextVC = (MainViewController *) [navController topViewController];
    nextVC.user = user;
}
@end
