//
//  AppDelegate.m
//  HDCameraCrashDemo
//
//  Created by 邓立兵 on 2019/12/23.
//  Copyright © 2019 denglibing. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

@end



// iOS13特定路径唤起系统相机后Crash修护代码
@implementation UIDevice (PG)

static inline void pg_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)load {
    // iOS13下，京喜打开有视频的商详后，再通过webview选择相机，会crash，发现是在异步线程发送了该通知导致
    // 因为对全局代码（很多没有代码权限无法扫描）进行扫描没有发现哪里监听该通知，所以做了如下处理
    // 如果发该通知是异步线程，则同步在主线程进行发送
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//        pg_swizzleSelector(UIDevice.class, @selector(endGeneratingDeviceOrientationNotifications), @selector(pgEndGeneratingDeviceOrientationNotifications));
    }
}

- (void)pgEndGeneratingDeviceOrientationNotifications {
    NSLog(@"pgEndGeneratingDeviceOrientationNotifications isMainThread:%d", [NSThread isMainThread]);
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self pgEndGeneratingDeviceOrientationNotifications];
        });
        return;
    }
    [self pgEndGeneratingDeviceOrientationNotifications];
}

@end
