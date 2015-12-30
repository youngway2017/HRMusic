//
//  HRMusicDetailController.m
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRMusicDetailController.h"
#import "UIView+Extension.h"
#import "HRMusicTool.h"

@interface HRMusicDetailController ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *singerNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIView *progressBackView;

@property (strong, nonatomic) IBOutlet UIButton *sliderButton;

@property (strong, nonatomic) IBOutlet UIImageView *backImageView;

@property (strong, nonatomic) IBOutlet UIButton *playOrPauseButton;

- (IBAction)playOrPause;

- (IBAction)previous;

- (IBAction)next;


- (IBAction)dismissClick;
- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender;

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HRMusicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 懒加载
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)updateProgress {
    double progress = self.player.currentTime / self.player.duration;
    self.progressView.width = self.progressBackView.width * progress;
    self.sliderButton.centerX = self.progressBackView.width * progress + self.currentTimeLabel.width;
    self.currentTimeLabel.text = [self sencondsToString:self.player.currentTime];
}

- (instancetype)init {
    if (self = [super init]) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        self.view.frame = keyWindow.bounds;
        self.view.y = keyWindow.height;
        [keyWindow addSubview:self.view];
    }
    return self;
}

- (void)setMusic:(HRMusic *)music {
    if (_music == music) {
        return;
    }
    _music = music;
    [HRMusicTool setCurrentMusic:music];
    self.player = [HRMusicTool getCurrentMusicPlayer];
    self.player.delegate = self;
    [HRMusicTool startPlayMusic];
    self.playOrPauseButton.selected = NO;
    
    self.musicNameLabel.text = music.name;
    self.singerNameLabel.text = music.singer;
    self.backImageView.image = [UIImage imageNamed:music.icon];
    
    
    
    self.durationLabel.text = [self sencondsToString:self.player.duration];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (NSString *)sencondsToString:(NSTimeInterval)senconds {
    return [NSString stringWithFormat:@"%.2d:%.2d",(int)senconds/60,(int)senconds%60];
}

#pragma mark - 显示 隐藏

- (void)show {
    [UIView animateWithDuration:1 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
//        <#code#>
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:1 animations:^{
        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
//        <#code#>
    }];
}

- (IBAction)playOrPause {
    if (self.playOrPauseButton.selected) {
        [self.player play];
    } else {
        [self.player pause];
        
    }
    
    self.playOrPauseButton.selected = !self.playOrPauseButton.selected;
    
}

- (IBAction)previous {
    HRMusic *music = [HRMusicTool previousMusic];
    [self setMusic:music];
}

- (IBAction)next {
    HRMusic *music = [HRMusicTool nextMusic];
    [self setMusic:music];
}

- (IBAction)dismissClick {
    [self dismiss];
}

#pragma mark - 手势
- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.progressBackView];
    
    [self updateProgressWithPoint:point];
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.progressBackView];
    
    [self updateProgressWithPoint:point];
}

- (void)updateProgressWithPoint:(CGPoint)point {
    if (point.x <= 0) {
        point.x = 0;
    }
    if (point.x >= self.progressBackView.width) {
        point.x = self.progressBackView.width;
    }
    self.sliderButton.centerX = point.x + self.currentTimeLabel.width;
    self.progressView.width = point.x;
    
    double progress = point.x / self.progressBackView.width;
    self.player.currentTime = progress * self.player.duration;
    self.currentTimeLabel.text = [self sencondsToString:self.player.currentTime];
    
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self next];
}

@end
