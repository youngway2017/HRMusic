//
//  ViewController.m
//  HRMusic
//
//  Created by Yangwei on 15/12/28.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HRAudioTool.h"

@interface HRViewController ()

@end

@implementation HRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *filename = [NSString stringWithFormat:@"m_%.2d.wav",arc4random_uniform(17)];
    NSLog(@"%@",filename);
    [HRAudioTool playAudioWithFileName:filename];
}

@end
