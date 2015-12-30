//
//  AppDelegate.m
//  HRMusic
//
//  Created by Yangwei on 15/12/28.
//  Copyright © 2015年 Yangwei. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIBackgroundTaskIdentifier identifier = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:identifier];
    }];
}

@end
