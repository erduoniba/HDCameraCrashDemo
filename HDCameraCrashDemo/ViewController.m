//
//  ViewController.m
//  HDCameraCrashDemo
//
//  Created by 邓立兵 on 2019/12/23.
//  Copyright © 2019 denglibing. All rights reserved.
//

#import "ViewController.h"

#import "HDWebViewDemo.h"
#import "HDVideoDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)gotoVideoDemo:(id)sender {
    // endGeneratingDeviceOrientationNotifications 比 beginGeneratingDeviceOrientationNotifications 多两次的时候，iOS13及以上会在特定场景下会Crash
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    UIViewController * _vvv = HDVideoDemo.new;
    _vvv.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:_vvv animated:YES completion:^{
        
    }];
}

- (IBAction)gotoWebViewDemo:(id)sender {
    HDWebViewDemo *vc = HDWebViewDemo.new;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

@end
