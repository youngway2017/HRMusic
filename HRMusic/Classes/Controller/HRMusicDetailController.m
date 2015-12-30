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
#import "HRLrc.h"
#define HRRandomColor [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]


@interface HRMusicDetailController ()<AVAudioPlayerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *lrcTableView;

@property (nonatomic, strong) HRLrc *lrc;

@property (strong, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *singerNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIView *progressBackView;

@property (strong, nonatomic) IBOutlet UIButton *sliderButton;

@property (strong, nonatomic) IBOutlet UIImageView *backImageView;

@property (strong, nonatomic) IBOutlet UIButton *playOrPauseButton;

@property (nonatomic, strong) UIColor *cellTextColor;
@property (nonatomic, assign) NSUInteger currentRow;


- (IBAction)playOrPause;

- (IBAction)previous;

- (IBAction)next;

- (IBAction)lrcClick;

- (IBAction)dismissClick;


- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender;

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HRMusicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (instancetype)init {
    if (self = [super init]) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        self.view.frame = keyWindow.bounds;
        self.view.y = keyWindow.height;
        [keyWindow addSubview:self.view];
        self.lrcTableView.backgroundView = nil;
        
        self.lrcTableView.backgroundColor = [UIColor clearColor];
        self.lrcTableView.allowsSelection = NO;
        self.lrcTableView.separatorStyle = NO;
        self.lrcTableView.showsVerticalScrollIndicator = NO;
        self.lrcTableView.opaque = NO;
        self.lrcTableView.delegate = self;
        self.lrcTableView.dataSource = self;
        
    }
    return self;
}

#pragma mark - 懒加载
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (HRLrc *)lrc {
    if (_lrc == nil) {
        _lrc = [[HRLrc alloc] init];
    }
    return _lrc;
}

- (void)updateProgress {
    double progress = self.player.currentTime / self.player.duration;
    self.progressView.width = self.progressBackView.width * progress;
    self.sliderButton.centerX = self.progressBackView.width * progress + self.currentTimeLabel.width;
    self.currentTimeLabel.text = [self sencondsToString:self.player.currentTime];
    
    CGFloat currentTime = self.player.currentTime;
    
    
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)currentTime / 60, (int)currentTime % 60];

    for (int i = 0; i < self.lrc.timeArray.count; i ++) {
        
        NSArray *arr = [self.lrc.timeArray[i] componentsSeparatedByString:@":"];
        
        CGFloat compTime = [arr[0] integerValue]*60 + [arr[1] floatValue];
        
        if (self.player.currentTime > compTime)
        {
            self.currentRow = i;
        }
        else
        {
            break;
        }
    }
    
    [self.lrcTableView reloadData];
    [self.lrcTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}


- (void)setMusic:(HRMusic *)music {
    if (_music == music) {
        return;
    }
    self.currentRow = 0;
    self.cellTextColor = HRRandomColor;
    _music = music;
    [HRMusicTool setCurrentMusic:music];
    [self.lrc parseLrcWithFileName:music.lrcname];
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

- (IBAction)lrcClick {
    self.lrcTableView.hidden = !self.lrcTableView.isHidden;
    
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

#pragma mark -UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrc.wordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"lrcCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell.textLabel setNumberOfLines:0];
        cell.textLabel.textColor = self.cellTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    
    if (indexPath.row == self.currentRow)
    {
        cell.textLabel.textColor = [UIColor redColor];
    } else {
        cell.textLabel.textColor = self.cellTextColor;
    }
    
    cell.textLabel.text = self.lrc.wordArray[indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat contentWidth = self.lrcTableView.width;

    UIFont *font = [UIFont systemFontOfSize:13];
    

    NSString *content = self.lrc.wordArray[indexPath.row];

    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];

    return size.height;
}


@end
