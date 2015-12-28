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

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation HRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSString *filename = [NSString stringWithFormat:@"m_%.2d.wav",arc4random_uniform(17)];
//    NSLog(@"%@",filename);
//    [HRAudioTool playAudioWithFileName:filename];
//    NSString *musicName = @"10405520.mp3";
//    NSURL *url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:musicName ofType:nil]];
//    NSURL *url = [NSURL URLWithString:@"http://play.baidu.com/?__m=mboxCtrl.playSong&__a=623748&__o=song/623748||playBtn&fr=altg_new3||www.baidu.com#"];
//    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    self.player = player;
//    [player prepareToPlay];
//    [player play];
    
    NSString *urlStr = @"http://play.baidu.com/?__m=mboxCtrl.playSong&__a=623748&__o=song/623748||playBtn&fr=altg_new3||www.baidu.com#";
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    
    //将数据保存到本地指定位置
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
    [audioData writeToFile:filePath atomically:YES];
    
    //播放本地音乐
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    self.player = player;
    [player play];
    
}

@end
