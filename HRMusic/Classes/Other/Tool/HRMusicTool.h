//
//  HRMusicTool.h
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRMusic.h"
#import <AVFoundation/AVFoundation.h>

@interface HRMusicTool : NSObject

+ (void)setCurrentMusic:(HRMusic *)music;

+ (AVAudioPlayer *) getCurrentMusicPlayer;

+ (void)startPlayMusic;

+ (NSMutableArray *)getMusicList;

+ (HRMusic *)previousMusic;
+ (HRMusic *)nextMusic;



@end
