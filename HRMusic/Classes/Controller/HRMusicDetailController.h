//
//  HRMusicDetailController.h
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRMusic.h"

@interface HRMusicDetailController : UIViewController

@property (nonatomic, strong) HRMusic *music;

- (void)show;

- (void)dismiss;
@end
