//
//  HDVideoDemo.m
//  HDCameraCrashDemo
//
//  Created by 邓立兵 on 2019/12/23.
//  Copyright © 2019 denglibing. All rights reserved.
//

#import "HDVideoDemo.h"

@implementation HDVideoDemo

- (void)dealloc {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    if (@available(iOS 13.0, *)) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeClose];
        btn.frame = CGRectMake(100, 100, 100, 100);
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        btn.frame = CGRectMake(100, 100, 100, 100);
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)backViewController {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
