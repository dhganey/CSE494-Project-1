//
//  MainViewController.m
//  Project 1
//
//  Created by David Ganey on 3/7/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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

- (IBAction)alarmPressed:(id)sender
{
    [self performSegueWithIdentifier:@"alarmSegue" sender:self];
}

- (IBAction)journalPressed:(id)sender
{
    [self performSegueWithIdentifier:@"journalSegue" sender:self];
}

- (IBAction)sleepPressed:(id)sender
{
    [self performSegueWithIdentifier:@"sleepSegue" sender:self];
}
@end
