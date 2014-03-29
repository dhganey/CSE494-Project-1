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
    NSMutableArray* entries; //contains all entries in the table
    int selectedRow; //set when user clicks a row
    JournalItem* newItem;
    bool viewing; //determines whether to create a new node, or update the old one, when returning from Add controller
    int rowEdited; //redundant? don't delete
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

//Loads the array of entries from local storage
-(void) loadJournalItems
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
        entries = [unarchiver decodeObjectForKey:@"JournalItems"];
        // we've finished choosing keys that we want, unpack them!
        [unarchiver finishDecoding];
    }
    // if not then we'll just make a new storage
    else
    {
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

        //[self saveJournalItems];
    }
    
    NSLog(@"loaded :%@", entries);

}

//Saves the array of entries from local storage
-(void) saveJournalItems
{
    // create a generic data storage object
    NSMutableData *data = [[NSMutableData alloc] init];
    // tell the archiver to use the storage we jut allocated, the archiver will do the
    // encoding steps and then write the result into that data object
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:entries forKey:@"JournalItems"];
    // this is an important step to say that we are done adding items to encode
    // and we want the data to be encoded now
    // the archiver waits until it is finished so it is able to get the most efficient
    // encoding of the data
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
    NSLog(@"saved; %@", entries);
}

//Initializes the array and loads it from local storage
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
        entries = [[NSMutableArray alloc] init];
    }
    NSLog(@"%@", entries);
    
    [self loadJournalItems];

    /*
    if ([entries count] == 0)
    {
        JournalItem* myItem = [[JournalItem alloc] init];
        myItem.entryTitle = @"New Note";
        myItem.entryContent = @"You can write a note here!";
        myItem.entryDate = nil;
        [entries addObject:myItem];
    }
     */
}

- (void)didReceiveMemoryWarning
{
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Sets boolean value and saves journal items
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
    
    //[self saveJournalItems];
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
    
    [self saveJournalItems];
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
        
        /* just removed
        JournalEntryViewController* nextVC = segue.destinationViewController;
        JournalItem* temp = [entries objectAtIndex:selectedRow];
        nextVC.entryContent = temp.entryContent;
         */
        
        JournalAddEntryViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
        JournalItem* temp = [entries objectAtIndex:selectedRow];
        nextVC.entryContent = temp.entryContent;
        nextVC.entryTitle = temp.entryTitle;
        
        //viewing = false;
        rowEdited = selectedRow;
    }
    else //moving to add
    {
        /*
        JournalAddEntryViewController *nextVC = [[JournalAddEntryViewController alloc] initWithNibName:@"JournalAddEntryViewController" bundle:nil];
        nextVC.delegate = self;
        [[self navigationController] pushViewController:nextVC animated:YES];
         */
        JournalAddEntryViewController* nextVC = segue.destinationViewController;
        nextVC.entryTitle = @"New Post";
        nextVC.entryContent = @"Type your note here";
        nextVC.delegate = self;
        viewing = false;
    }
    
    [self saveJournalItems];
}

//Saves the items
-(void)viewWillDisappear:(BOOL)animated
{
    [self saveJournalItems];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    viewing = true;
    selectedRow = indexPath.row;
    //[self performSegueWithIdentifier:@"journalEntryViewSegue" sender:self];
    [self performSegueWithIdentifier:@"journalAddEntrySegue" sender:self];
}

-(void) addItemViewController:(JournalAddEntryViewController *)controller didFinishEnteringItem:(JournalItem *)item
{

    if (viewing) //simply update the content
    {
        JournalItem* temp = [entries objectAtIndex:rowEdited];
        temp.entryTitle = item.entryTitle;
        temp.entryContent = item.entryContent;
        [entries replaceObjectAtIndex:rowEdited withObject:temp];
        
    }
    else //add a new entry
    {
        [entries addObject:item];
    }
    [self.tableView reloadData];
}

@end
