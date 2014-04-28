//
//  SleepStatsViewController.m
//  Project 1
//
//  Created by David Ganey on 4/14/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import "SleepStatsViewController.h"


@interface SleepStatsViewController ()

@property (strong, nonatomic) IBOutlet UIView *NewGraphingView;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //dispatch_queue_t graphQueue = dispatch_queue_create("graph view create", NULL);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *reversed = [[[self.entries reverseObjectEnumerator] allObjects] mutableCopy];
        self.entries = reversed;
        
        //hack to force auto-layout
        CPTGraphHostingView *hostView = [[CPTGraphHostingView alloc] initWithFrame:self.NewGraphingView.frame];
        
        //create graph object and add to hostview
        //CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
        CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:CGRectMake(0, 0, 100, 100)]; //part of new hack
        hostView.hostedGraph = graph;
        
        
        //new stuff for formatting
        hostView.allowPinchScaling = YES;
        
        graph.paddingBottom = 10.0f; //30.0f;
        graph.paddingLeft = 10.0f; //30.0f;
        graph.paddingRight = 0; //-5.0f;
        graph.paddingTop = 0; //-1.0f;
         
        //[graph applyTheme:[CPTTheme themeNamed:kCPTSlateTheme]];
        [graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
        
        //graph title stuff
        NSString *title = @"Hours Asleep";
        CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
        titleStyle.fontName = @"Helvetica Bold";
        titleStyle.fontSize = 20.0f;
        graph.titleTextStyle = titleStyle;
        graph.title = title;
        
        /* //axis labels
        
        CPTXYAxisSet *axisSet = [[CPTXYAxisSet alloc] init];
        CPTXYAxis *xAxis = [[CPTXYAxis alloc] init];
        CPTXYAxis *yAxis = [[CPTXYAxis alloc] init];

        CPTMutableTextStyle *labelStyle = [CPTMutableTextStyle textStyle];
        labelStyle.fontName = @"Helvetica Bold";
        labelStyle.fontSize = 10.0f;
        CPTAxisLabel *xLabel = [[CPTAxisLabel alloc] initWithText:@"Sleep Cycle" textStyle:labelStyle];
        CPTAxisLabel *yLabel = [[CPTAxisLabel alloc] initWithText:@"Hours Slept" textStyle:labelStyle];
        xAxis.axisLabels = [[NSSet alloc] initWithObjects:xLabel, nil];
        yAxis.axisLabels = [[NSSet alloc] initWithObjects:yLabel, nil];
        
        NSArray *axes = [[NSArray alloc] initWithObjects:xAxis, yAxis, nil];
        axisSet.axes = axes;
        graph.axisSet = axisSet;
        */
        
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
#define SCALAR_TO_NOT_HIDE_TITLE 1.2
        
        yMin = 0;
        //yMax = [self maxSleepEntry];
        yMax = [self maxSleepEntry] * SCALAR_TO_NOT_HIDE_TITLE;
        
        //set ranges
        [plotSpace setXRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)]];
        [plotSpace setYRange:[CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)]];
        
        //create the plot
        //CPTScatterPlot *plot = [[CPTScatterPlot alloc] initWithFrame:self.view.frame];
        CPTScatterPlot *plot = [[CPTScatterPlot alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        plot.dataSource = self; //this uses protocol in .h file
        
        //line color stuff
        CPTMutableLineStyle *lineStyle = [[CPTMutableLineStyle alloc] init];
        lineStyle.lineColor = [CPTColor cyanColor];
        lineStyle.lineWidth = 2.0f;
        plot.dataLineStyle = lineStyle;
        
        [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
        //[graph.defaultPlotSpace scaleToFitPlots:[graph allPlots]];
        
        [self.view addSubview:hostView];
        [self.view setNeedsDisplay];
    });
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
