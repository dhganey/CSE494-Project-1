//
//  ProjectViewController.m
//  Project 1
//
//  Created by David Ganey on 3/6/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectUser.h"

@interface ProjectViewController ()

@end

@implementation ProjectViewController

ProjectUser *user;

- (void)viewDidLoad
{
    [super viewDidLoad];
    user = [[ProjectUser alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nameEdited:(id)sender
{
    user.name = self.nameField.text;
    //TODO: take other info? end editing (implement keyboard hide methods). when user presses enter, call segue
}


@end
