//
//  HRLrc.h
//  HRLrc
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRLrc : NSObject

/**
 时间
 */
@property (nonatomic,strong)NSMutableArray *timeArray;
/**
 歌词
 */
@property (nonatomic,strong)NSMutableArray *wordArray;

/**
 解析歌词
 */
- (void)parseLrcWithFileName:(NSString *)filename;

@end
