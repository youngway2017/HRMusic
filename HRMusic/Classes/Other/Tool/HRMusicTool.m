//
//  HRMusicTool.m
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRMusicTool.h"
#import <AVFoundation/AVFoundation.h>
#import "MJExtension.h"

@interface HRMusicTool()

@end


@implementation HRMusicTool

static HRMusic *_currentMusic;
static AVAudioPlayer *_currentMusicPlayer;
static NSMutableArray *_musicList;

+ (void)initialize {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Musics.plist" ofType:nil];
    _musicList = [HRMusic mj_objectArrayWithFile:path];
    NSLog(@"%@",_musicList);
}

+ (void)startPlayMusic {
    if (!_currentMusicPlayer) return;
    [_currentMusicPlayer prepareToPlay];
    [_currentMusicPlayer play];
    
}

+ (void)setCurrentMusic:(HRMusic *)music {
    _currentMusic = music;
    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:_currentMusic.filename ofType:nil]];
    _currentMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
}

+ (NSMutableArray *)getMusicList {
    return _musicList;
}

@end
