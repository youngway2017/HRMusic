//
//  HRLrc.m
//  HRLrc
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRLrc.h"

@implementation HRLrc

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeArray = [NSMutableArray array];
        _wordArray = [NSMutableArray array];
    }
    return self;
}


/**
 解析歌词
 */
- (void)parseLrcWithFileName:(NSString *)filename{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    NSString *content = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    [_timeArray removeAllObjects];
    [_wordArray removeAllObjects];
    NSArray *sepArray = [content componentsSeparatedByString:@"["];
    for (int i = 5; i < sepArray.count; i ++) {
        //有两个元素，一个是时间，一个是歌词
        NSArray *arr = [sepArray[i] componentsSeparatedByString:@"]"];
        
        [_timeArray addObject:arr[0]];
        [_wordArray addObject:arr[1]];
        
    }
}

@end
