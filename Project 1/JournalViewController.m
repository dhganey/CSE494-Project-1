//
//  JournalViewController.m
//  Project 1
//
//  Created by David Ganey on 3/7/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "JournalViewController.h"

#include "JournalItem.h"
#include "JournalEntryViewController.h"

#define NUM_SECTIONS 1

@interface JournalViewController ()

@end

@implementation JournalViewController
{
    NSMutableArray* entries;
    int selectedRow;
    JournalItem* newItem;
    bool viewing;
}

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)viewDidLoad
{
    //[super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    viewing = false;
    
    if (!entries)
    {
        entries = [[NSMutableArray alloc] init]; //TODO: update to work with Parse
    }
    
    NSString* testTitle = @"Test title 1";
    NSString* testContent = @"There once was a man from Peru, who dreamed he was eating his shoe. He woke with a fright in the middle of the night to find that his dream had come true!";
    NSDate *testDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    testDate = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:testDate]];
    
    JournalItem* testItem = [[JournalItem alloc] init];
    testItem.entryTitle = testTitle;
    testItem.entryContent = testContent;
    testItem.entryDate = testDate;
    
    [entries addObject:testItem];
}

- (void)didReceiveMemoryWarning
{
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    viewing = false;
    /*
    viewing = false;
    
    if (self.createdTitle != nil)
    {
        JournalItem* myItem = [[JournalItem alloc] init];
        myItem.entryTitle = self.createdTitle;
        myItem.entryContent = self.createdContent;
        NSDate *newDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
        newDate = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:newDate]];
        myItem.entryDate = newDate;
        
        [entries addObject:newItem];
    }
     */
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUM_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JournalItem"];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:123];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:456];

    JournalItem* item = [entries objectAtIndex:indexPath.row];
    titleLabel.text = item.entryTitle;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yy"];
    NSString *stringFromDate = [formatter stringFromDate:item.entryDate];
    dateLabel.text = stringFromDate;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [entries removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (viewing) //moving to view
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        JournalEntryViewController* nextVC = segue.destinationViewController;
        JournalItem* temp = [entries objectAtIndex:selectedRow];
        nextVC.entryContent = temp.entryContent;
    }
    else //moving to add
    {
        /*
        JournalAddEntryViewController *nextVC = [[JournalAddEntryViewController alloc] initWithNibName:@"JournalAddEntryViewController" bundle:nil];
        nextVC.delegate = self;
        [[self navigationController] pushViewController:nextVC animated:YES];
         */
        JournalAddEntryViewController* nextVC = segue.destinationViewController;
        nextVC.delegate = self;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    viewing = true;
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"journalEntryViewSegue" sender:self];
}

-(void) addItemViewController:(JournalAddEntryViewController *)controller didFinishEnteringItem:(JournalItem *)item
{
    [entries addObject:item];
    [self.tableView reloadData];
}

@end
