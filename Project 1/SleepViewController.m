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
    NSMutableArray *entries;
    NSDate *currentEntry;
    NSString* currentString;
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
    
    [self loadSleepItems];
    if (!entries)
    {
        entries = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self saveSleepItems];
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SleepTableViewController* nextVC = segue.destinationViewController;
    nextVC.entries = entries; //pass the entries to the next VC
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
    currentEntry = timerDate;
    self.sleepLabel.text = timeString;
    currentString = timeString;
}

-(void) stopTimer
{
    [self.sleepTimer invalidate];
    self.sleepTimer = nil;
    [self updateTimer];
    SleepItem *newItem = [[SleepItem alloc] init];
    newItem.timeSlept = currentString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yy"];
    NSString *dateSlept = [dateFormatter stringFromDate:self.startDate];
    newItem.dateSlept = dateSlept;
    //[entries addObject:newItem];
    [entries insertObject:newItem atIndex:0];
    
    NSLog(@"%@", entries);

}

-(NSString *) documentsDirectory
{
    return [@"~/Documents" stringByExpandingTildeInPath];
}

- (NSString *)dataFilePath
{
    NSLog(@"%@",[self documentsDirectory]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklist.plist"];
}


-(void) loadSleepItems
{
    NSString *path = [self dataFilePath];
    
    //do we have anything in our documents directory?  If we have anything then load it up
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        // same way, except this time since we aren't adding anything to our data
        // we don't need mutable data, just what we are loading
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // make an unarchiver, and point it to our data
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        entries = [unarchiver decodeObjectForKey:@"SleepItems"];
        // we've finished choosing keys that we want, unpack them!
        [unarchiver finishDecoding];
    }
    // if not then we'll just make a new storage
    else
    {
        //nothing
    }
    
}

-(void) saveSleepItems
{
    // create a generic data storage object
    NSMutableData *data = [[NSMutableData alloc] init];
    // tell the archiver to use the storage we jut allocated, the archiver will do the
    // encoding steps and then write the result into that data object
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:entries forKey:@"SleepItems"];
    // this is an important step to say that we are done adding items to encode
    // and we want the data to be encoded now
    // the archiver waits until it is finished so it is able to get the most efficient
    // encoding of the data
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}


@end
