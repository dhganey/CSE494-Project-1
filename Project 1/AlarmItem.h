//
//  AlarmItem.h
//  Project 1
//
//  Created by Connor Alfheim on 3/26/14.
//  Copyright (c) 2014 Ganey/Alfheim Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface AlarmItem : NSObject <NSCoding>{
    AVAudioPlayer *audioPlayer;
}

@property NSString *title;
@property NSNumber *hours;
@property NSNumber *minutes;
@property NSNumber *isOn;
//@property (nonatomic, strong) WeekItem *days;
@property (nonatomic, strong) NSMutableArray *weekdays;
@property (nonatomic, strong) NSString *sound;
@property (nonatomic, strong) NSTimer  *timer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer2;
-(void) modifyDay:(int)day setValue:(BOOL)newValue;
-(void) setAlarm;

@end
