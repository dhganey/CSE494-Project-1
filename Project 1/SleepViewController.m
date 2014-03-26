//
//  SleepViewController.m
//  Project 1
//
//  Created by David Ganey on 3/7/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "SleepViewController.h"

@interface SleepViewController ()

@end

@implementation SleepViewController
{
    bool sleeping;
}

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
    sleeping = false;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sleepButtonPressed:(id)sender
{
    if (sleeping) //if sleeping, and they press "wake up"
    {
        sleeping = false;
        [self.sleepButton setTitle:@"Go to Sleep" forState:UIControlStateNormal];
        [self stopTimer];
    }
    else //if they're not sleeping and they press "sleep", start the timer TODO
    {
        self.startDate = [NSDate date];
        sleeping = true;
        [self.sleepButton setTitle:@"Wake Up" forState:UIControlStateNormal];
        self.sleepTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
}

- (IBAction)historyPressed:(id)sender
{
    [self performSegueWithIdentifier:@"sleepTableViewSegue" sender:self];
}

-(void) updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //date formatting:
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.sleepLabel.text = timeString;
}

-(void) stopTimer
{
    [self.sleepTimer invalidate];
    self.sleepTimer = nil;
    [self updateTimer];
}

@end
