//
//  HRMusicDetailController.m
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRMusicDetailController.h"
#import "UIView+Extension.h"

@interface HRMusicDetailController ()

@property (strong, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *singerNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *durationLabel;

@property (strong, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) IBOutlet UIView *progressBackView;

@property (strong, nonatomic) IBOutlet UIButton *sliderButton;

- (IBAction)dismissClick;
- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender;

@end

@implementation HRMusicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    _music = music;
    self.musicNameLabel.text = music.name;
    self.singerNameLabel.text = music.singer;
}

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

- (IBAction)dismissClick {
    [self dismiss];
}

- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.progressBackView];
    self.sliderButton.centerX = point.x;
    self.progressView.width = point.x;
    NSLog(@"xxxx");
}

@end
