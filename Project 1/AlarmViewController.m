//
//  AlarmViewController.m
//  Project 1
//
//  Created by Connor Alfheim on 3/7/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//
/*
 *TODO:
    create nsmutable array of alarm items
    attach alarm object to this
    have prototype cells display items from this index
    create the initialization view
 */
#import "AlarmViewController.h"
#import "AlarmItem.h"

@interface AlarmViewController ()

@end

@implementation AlarmViewController
{
    NSMutableArray* alarms; //contains all entries in the table
    int selectedRow; //set when user clicks a row
    AlarmItem* newAlarm;
    bool viewing; //determines whether to create a new node, or update the old one, when returning from Add controller
    int rowEdited; //redundant? don't delete
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
    newAlarm = [[AlarmItem alloc] init];
    alarms  = [[NSMutableArray alloc] init];
    [alarms addObject:newAlarm];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [alarms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlarmItem"];
    
    //title of cell
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    AlarmItem *cellAlarm = [alarms objectAtIndex:indexPath.row];
    titleLabel.text = cellAlarm.title;
    
    //time of alarm
    UILabel *timeLabel = (UILabel *) [cell viewWithTag:2];
    timeLabel.text = [NSString stringWithFormat:@"%i:%.2i",
                      [cellAlarm.hours integerValue], [cellAlarm.minutes integerValue]];
    
    
    // alarm switch
    UISwitch *alarmSwitch = (UISwitch *)[cell.contentView viewWithTag:100];
    alarmSwitch.on = [cellAlarm.isOn boolValue];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
