//
//  HRAudioTool.m
//  HRMusic
//
//  Created by Yangwei on 15/12/28.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRAudioTool.h"
#import <AVFoundation/AVFoundation.h>

static NSMutableDictionary *_audios;

@implementation HRAudioTool

+ (void)initialize {
    if (_audios == nil) {
        _audios = [NSMutableDictionary dictionary];
    }
}

+ (void)playAudioWithFileName:(NSString *)filename {
    SystemSoundID soudID = [_audios[filename] unsignedIntValue];
    if (!soudID) {
        NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:filename ofType:nil]];
        if (!url) {
            NSLog(@"url 错误");
            return;
        }
        NSLog(@"创建%@",filename);
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soudID);
        _audios[filename] = [NSString stringWithFormat:@"%zd",soudID];
    }
    
    AudioServicesPlaySystemSound(soudID);
}

@end
