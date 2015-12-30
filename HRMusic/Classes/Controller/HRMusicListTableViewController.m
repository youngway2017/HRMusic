//
//  HRMusicListTableViewController.m
//  HRMusic
//
//  Created by Yangwei on 15/12/29.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "HRMusicListTableViewController.h"
#import "HRMusicTool.h"
#import "UIImage+Extension.h"
#import "HRMusicDetailController.h"
#import "UIView+Extension.h"

@interface HRMusicListTableViewController ()
@property (nonatomic, strong) HRMusicDetailController *detailMusicVC;

@end

@implementation HRMusicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - 懒加载
- (HRMusicDetailController *)detailMusicVC {
    if (_detailMusicVC == nil) {
        _detailMusicVC = [[HRMusicDetailController alloc] init];
    }
    return _detailMusicVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [HRMusicTool getMusicList].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"MusicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    HRMusic *music = [HRMusicTool getMusicList][indexPath.row];
    
    cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:5 borderColor:[UIColor purpleColor]];
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.singer;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HRMusic *music = [HRMusicTool getMusicList][indexPath.row];
    
    [self.detailMusicVC setMusic:music];
    [self.detailMusicVC show];
    
}



@end
