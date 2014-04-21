//
//  SleepStatsViewController.m
//  Project 1
//
//  Created by David Ganey on 4/14/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "SleepStatsViewController.h"


@interface SleepStatsViewController ()

@end

@implementation SleepStatsViewController

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
    
    NSMutableArray *reversed = [[[self.entries reverseObjectEnumerator] allObjects] mutableCopy];
    self.entries = reversed;
    
    //add hostview
    CPTGraphHostingView *hostView = [[CPTGraphHostingView alloc] initWithFrame:self.view.frame];
    //[self.view addSubview:hostView];
    
    //create graph object and add to hostview
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    hostView.hostedGraph = graph;
    
   
    //new stuff for formatting
    hostView.allowPinchScaling = YES;
    graph.paddingBottom = 30.0f;
    graph.paddingLeft = 30.0f;
    graph.paddingRight = -5.0f;
    graph.paddingTop = -1.0f;
    [graph applyTheme:[CPTTheme themeNamed:kCPTSlateTheme]];
    
    NSString *title = @"Time Asleep";
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.fontName = @"Helvetica Bold";
    titleStyle.fontSize = 16.0f;
    graph.title = title;
    
    
    //get default plotspace
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    //calculate ranges
    float xMin, xMax, yMin, yMax;
    //xMax = [self.entries count] + ((.25)*[self.entries count]); //add 25%
    //xMin = 0 - ((.2)*[self.entries count]);
    xMin = 0;
    xMax = [self.entries count];
    
    //yMax = [self maxSleepEntry] + ((.25)*[self maxSleepEntry]);
    //yMin = 0 - ((.3)*[self minSleepEntry]);
    yMin = 0;
    yMax = [self maxSleepEntry];
    
    //set ranges
    [plotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)]];
    [plotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)]];
    
    //create the plot
    CPTScatterPlot *plot = [[CPTScatterPlot alloc] initWithFrame:self.view.frame];
    
    plot.dataSource = self; //this uses protocol in .h file
    
    [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
    //[graph.defaultPlotSpace scaleToFitPlots:[graph allPlots]];
    
    [self.view addSubview:hostView];

}

-(float) maxSleepEntry
{
    double max = 0;
    if ([self.entries count] > 0)
    {
        SleepItem *temp = [self.entries objectAtIndex:0];
        max = temp.secondsSlept;
        for (int i = 1; i < [self.entries count]; i++)
        {
            temp = [self.entries objectAtIndex:i];
            if (temp.secondsSlept > max)
            {
                max = temp.secondsSlept;
            }
        }
    }
    
    NSLog(@"max: %f", max);
    return max;
}

-(float) minSleepEntry
{
    double min = 0;
    if ([self.entries count] > 0)
    {
        SleepItem* temp = [self.entries objectAtIndex:0];
        min = temp.secondsSlept;
        for (int i = 1; i < [self.entries count]; i++)
        {
            temp = [self.entries objectAtIndex:i];
            if (temp.secondsSlept < min)
            {
                min = temp.secondsSlept;
            }
        }
    }
    
    NSLog(@"min: %f", min);
    return min;
}

//defined to handle CPTProtocol in .h file
-(NSUInteger) numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.entries count];
    //return 9;
}

//also for datasource protocol
-(NSNumber*)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{
    SleepItem* temp = [self.entries objectAtIndex:idx];
    if (fieldEnum == CPTScatterPlotFieldX)
    {
        NSLog(@"index :%d", idx);
        return [NSNumber numberWithInt:idx];
    }
    else
    {
        NSLog(@"value: %f", temp.secondsSlept);
        return [NSNumber numberWithDouble:temp.secondsSlept];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
