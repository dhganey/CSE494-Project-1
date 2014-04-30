//
//  AlarmItem.m
//  Project 1
//
//  Created by Connor Alfheim on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//
/*done*/
#import "AlarmItem.h"


@implementation AlarmItem

//overload init method to init with attributes
-(id)init;
{
    self = [super init];
    self.title = @"New Alarm";
    self.hours = 0;
    self.minutes = 0;
    //self.days = [[WeekItem alloc] init];
    self.weekdays = [self initializeWeekdays];
    self.sound = @"defaultSong";
    self.isOn = [NSNumber numberWithBool:YES];
    return self;
}

-(NSMutableArray*)initializeWeekdays{
    NSNumber *sunday = [NSNumber numberWithBool:1];
    NSNumber *monday = [NSNumber numberWithBool:1];
    NSNumber *tuesday = [NSNumber numberWithBool:1];
    NSNumber *wednesday = [NSNumber numberWithBool:1];
    NSNumber *thursday = [NSNumber numberWithBool:1];
    NSNumber *friday = [NSNumber numberWithBool:1];
    NSNumber *saturday = [NSNumber numberWithBool:1];
    NSMutableArray *weekdays = [NSMutableArray arrayWithObjects:sunday,monday,tuesday,wednesday,thursday,friday,saturday, nil];
    return weekdays;
}

// timer is generated after loading by superior method
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.title = [aDecoder decodeObjectForKey:@"alarmTitle"];
        self.hours = [aDecoder decodeObjectForKey:@"alarmHours"];
        self.weekdays = [aDecoder decodeObjectForKey:@"alarmWeekdays"];
        self.minutes = [aDecoder decodeObjectForKey:@"alarmMinutes"];
        self.sound = [aDecoder decodeObjectForKey:@"alarmSound"];
        self.isOn = [aDecoder decodeObjectForKey:@"alarmIsOn"];
    }
    return self;
}

// encodes things
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"alarmTitle"];
    [aCoder encodeObject:self.hours forKey:@"alarmHours"];
    [aCoder encodeObject:self.minutes forKey:@"alarmMinutes"];
    [aCoder encodeObject:self.weekdays forKey:@"alarmWeekdays"];
    [aCoder encodeObject:self.sound forKey:@"alarmSound"];
    [aCoder encodeObject:self.isOn forKey:@"alarmIsOn"];
}

// adds a nstimer to the application for the set time
-(void) setAlarm{
    // if current alarm has timer, disable it and overwrite
    if(self.timer){
        [self.timer invalidate];
    }
    // todo fix;
    NSDate *currentDate = [NSDate date];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components= [cal components:NSIntegerMax fromDate:currentDate];
    [components setHour:[self.hours integerValue]];
    [components setMinute:[self.minutes integerValue]];
    [components setSecond:0];
    // create date of today with current alarm time
    NSDate *fireDate = [cal dateFromComponents:components];
    
    // checks alarm every 24 hours- proper day and alarm on is checked in called method
    self.timer = [[NSTimer alloc ]initWithFireDate:fireDate interval:86400 target:self selector:@selector(alarmCheck) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// checks to guarentee day, alarm is on, and proper time is met
-(void) alarmCheck{
    // get day of week
    NSDate *now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned units = NSWeekdayCalendarUnit| NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [cal components:units fromDate:now];
    int currentDay = [components weekday]-1;
    int currentHour = [components hour];
    int currentMinute = [components minute];
    int currentSecond = [components second];
    
    // check to see if alarm should go off
    if([[self.weekdays objectAtIndex:(currentDay)] boolValue] && self.isOn &&
            [self.hours intValue] == currentHour && [self.minutes intValue] == currentMinute &&
                currentSecond <10){
        [self playAudio];
        //[self alarmAlert];
        //alarm notification
        
    }
}

-(void) alarmAlert{
    UIAlertView *alarm = [[UIAlertView alloc] initWithTitle:self.title message:self.title delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"snooze", nil];
    [alarm setTag:100];
    [alarm show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 100) { //alarm tag
        if (buttonIndex == 0) {     // dismiss.
            [self.audioPlayer2 stop];
        }
        if (buttonIndex == 1){ // snooze
            [self.audioPlayer2 stop];
            
            // creates new snooze alarm that will go directly to playing audio
            NSDate *snoozeTime = [NSDate dateWithTimeIntervalSinceNow:60];
            NSTimer *alarm =[[NSTimer alloc ]initWithFireDate:snoozeTime interval:86400 target:self selector:@selector(playAudio) userInfo:nil repeats:NO];
            [[NSRunLoop currentRunLoop] addTimer:alarm forMode:NSRunLoopCommonModes];
        }
    }
}

/*****sound ******/
// sound effect from http://www.soundjay.com/beep-sounds-1.html
// plays the audio clip which is about 6 seconds long
-(void)playAudio{
    UIAlertView *alarm = [[UIAlertView alloc] initWithTitle:self.title message:self.title delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"snooze", nil];
    [alarm setTag:100];
    [alarm show];
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"Fire-alarm" ofType:@"mp3"];
    self.audioPlayer2 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [self.audioPlayer2 play];
}
@end
