//
//  HRMusic.m
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRMusic.h"

@implementation HRMusic

- (NSString *)description {
    return [NSString stringWithFormat:@"name=%@,filename=%@,singer=%@",self.name,self.filename,self.singer];
}

- (BOOL)isEqual:(HRMusic *)other {
    return [self.filename isEqualToString:other.filename];
}

@end
