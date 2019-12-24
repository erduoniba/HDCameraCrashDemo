//
//  HDWebViewDemo.m
//  HDCameraCrashDemo
//
//  Created by 邓立兵 on 2019/12/23.
//  Copyright © 2019 denglibing. All rights reserved.
//

#import "HDWebViewDemo.h"

#import <WebKit/WebKit.h>

@implementation HDWebViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"openCamera" ofType:@"html"];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
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
