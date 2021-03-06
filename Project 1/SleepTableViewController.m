//
//  SleepTableViewController.m
//  Project 1
//
//  Created by David Ganey on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "SleepTableViewController.h"

#define NUM_SECTIONS 1

@interface SleepTableViewController ()

@end

@implementation SleepTableViewController
{
    //NSMutableArray *entries;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (!self.entries)
    {
        self.entries = [[NSMutableArray alloc] init];
    }
    
    //[self loadSleepItems];
}

-(void) viewWillDisappear:(BOOL)animated
{
    //[self saveSleepItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.entries count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sleepItem" forIndexPath:indexPath];
    
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:567];
    UILabel *sleptLabel = (UILabel *)[cell viewWithTag:333];
    
    SleepItem *temp = [self.entries objectAtIndex:indexPath.row];
    NSString *dateSlept = temp.dateSlept;
    //NSString *timeSlept = temp.timeSlept;
    NSString *timeSlept = [NSString stringWithFormat:@"%f", (temp.secondsSlept / 3600)]; //divide by 60 to show hours
    
    dateLabel.text = dateSlept;
    sleptLabel.text = timeSlept;
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)statsPressed:(id)sender
{
    [self performSegueWithIdentifier:@"sleepStatsSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SleepStatsViewController* nextVC = segue.destinationViewController;
    nextVC.entries = self.entries; //pass the entries to the next VC
}
@end
