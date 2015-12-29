//
//  HRMusicTool.h
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRMusic.h"

@interface HRMusicTool : NSObject

+ (void)setCurrentMusic:(HRMusic *)music;
+ (void)startPlayMusic;

+ (NSMutableArray *)getMusicList;

@end
