# HDCameraCrashDemo



### 问题描述

iOS13及以上的系统，使用Xcode11.2编译器运行，在特定的路径下唤起系统拍照/录像会直接Crash，使用该Demo的Crash的日志如下：

```objective-c
2019-12-24 10:28:40.709607+0800 HDCameraCrashDemo[3338:1286515] *** Assertion failure in -[FBSSerialQueue assertOnQueue], /BuildRoot/Library/Caches/com.apple.xbs/Sources/FrontBoardServices/FrontBoard-626.4.1/FrontBoardServices/FBSSerialQueue.m:98
2019-12-24 10:28:40.709836+0800 HDCameraCrashDemo[3338:1286515] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'threading violation: expected the main thread'
*** First throw call stack:
(0x1beebc96c 0x1bebd5028 0x1bedb94fc 0x1bf1fa700 0x1c40eb7ec 0x1c409d460 0x1c409d6ec 0x1c409d5e4 0x1c2b1f120 0x1c2c0ed50 0x1c2c0fb20 0x1e13c3514 0x1bebef3f8 0x1e1466118 0x1bebd4130 0x1bebe6f80 0x1bebede44 0x1e145b2c4 0x1bebef3f8 0x1bee0243c 0x1bed8cfc0 0x1bebef3f8 0x1e14be704 0x1bebd4130 0x1bebe6f80 0x1bebede44 0x1e14af8ac 0x1bebef3f8 0x1beadfa08 0x1bebef3f8 0x1beadfa08 0x1004ef27c 0x1004f690c 0x1004f74fc 0x1005024dc 0x1bebc76d0 0x1bebcd9e8)
libc++abi.dylib: terminating with uncaught exception of type NSException
(lldb) bt
* thread #4, queue = 'com.apple.camera.capture-engine.session-queue', stop reason = signal SIGABRT
  * frame #0: 0x00000001beca6efc libsystem_kernel.dylib`__pthread_kill + 8
    frame #1: 0x00000001bebc68b8 libsystem_pthread.dylib`pthread_kill + 228
    frame #2: 0x00000001beb56a74 libsystem_c.dylib`abort + 104
    frame #3: 0x00000001bec6e3c8 libc++abi.dylib`abort_message + 132
    frame #4: 0x00000001bec6e5c0 libc++abi.dylib`demangling_terminate_handler() + 308
    frame #5: 0x00000001bebd5308 libobjc.A.dylib`_objc_terminate() + 124
    frame #6: 0x00000001bec7b634 libc++abi.dylib`std::__terminate(void (*)()) + 20
    frame #7: 0x00000001bec7b5c0 libc++abi.dylib`std::terminate() + 44
    frame #8: 0x00000001bebd528c libobjc.A.dylib`objc_terminate + 16
    frame #9: 0x00000001004ef290 libdispatch.dylib`_dispatch_client_callout + 40
    frame #10: 0x00000001004f690c libdispatch.dylib`_dispatch_lane_serial_drain + 720
    frame #11: 0x00000001004f74fc libdispatch.dylib`_dispatch_lane_invoke + 408
    frame #12: 0x00000001005024dc libdispatch.dylib`_dispatch_workloop_worker_thread + 1344
    frame #13: 0x00000001bebc76d0 libsystem_pthread.dylib`_pthread_wqthread + 280
(lldb) 
```

在实际项目中的Crash日志及堆栈信息如下：

```objective-c
* thread #67, queue = 'com.apple.camera.capture-engine.session-queue', stop reason = breakpoint 3.1
    frame #0: 0x00000001bebd4fec libobjc.A.dylib`objc_exception_throw
    frame #1: 0x00000001bedb94fc CoreFoundation`+[NSException raise:format:arguments:] + 100
    frame #2: 0x00000001bf1fa700 Foundation`-[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:] + 132
    frame #3: 0x00000001c40eb7ec FrontBoardServices`-[FBSSerialQueue assertOnQueue] + 236
    frame #4: 0x00000001c409d460 FrontBoardServices`-[FBSSceneImpl updateClientSettings:withTransitionContext:] + 80
    frame #5: 0x00000001c409d6ec FrontBoardServices`-[FBSSceneImpl updateClientSettingsWithTransitionBlock:] + 168
    frame #6: 0x00000001c409d5e4 FrontBoardServices`-[FBSSceneImpl updateClientSettingsWithBlock:] + 128
    frame #7: 0x00000001c2b1f120 UIKitCore`-[FBSScene(UIApp) updateUIClientSettingsWithBlock:] + 184
    frame #8: 0x00000001c2c0ed50 UIKitCore`-[UIDevice(Private) _enableDeviceOrientationEvents:] + 156
  * frame #9: 0x00000001c2c0fb20 UIKitCore`-[UIDevice endGeneratingDeviceOrientationNotifications] + 60
    frame #10: 0x00000001e13c3514 CameraUI`-[CAMMotionController dealloc] + 68
    frame #11: 0x00000001bebef3f8 libobjc.A.dylib`objc_release + 136
    frame #12: 0x00000001e1466118 CameraUI`-[CUCaptureController .cxx_destruct] + 92
    frame #13: 0x00000001bebd4130 libobjc.A.dylib`object_cxxDestructFromClass(objc_object*, objc_class*) + 116
    frame #14: 0x00000001bebe6f80 libobjc.A.dylib`objc_destructInstance + 92
    frame #15: 0x00000001bebede44 libobjc.A.dylib`_objc_rootDealloc + 52
    frame #16: 0x00000001e145b2c4 CameraUI`-[CUCaptureController dealloc] + 120
    frame #17: 0x00000001bebef3f8 libobjc.A.dylib`objc_release + 136
    frame #18: 0x00000001bee0243c CoreFoundation`__RELEASE_OBJECTS_IN_THE_ARRAY__ + 116
    frame #19: 0x00000001bed8cfc0 CoreFoundation`-[__NSArrayM dealloc] + 172
    frame #20: 0x00000001bebef3f8 libobjc.A.dylib`objc_release + 136
    frame #21: 0x00000001e14be704 CameraUI`-[CAMCaptureEngine .cxx_destruct] + 176
    frame #22: 0x00000001bebd4130 libobjc.A.dylib`object_cxxDestructFromClass(objc_object*, objc_class*) + 116
    frame #23: 0x00000001bebe6f80 libobjc.A.dylib`objc_destructInstance + 92
    frame #24: 0x00000001bebede44 libobjc.A.dylib`_objc_rootDealloc + 52
    frame #25: 0x00000001e14af8ac CameraUI`-[CAMCaptureEngine dealloc] + 168
    frame #26: 0x00000001bebef3f8 libobjc.A.dylib`objc_release + 136
    frame #27: 0x00000001beadfa08 libsystem_blocks.dylib`_Block_release + 168
    frame #28: 0x00000001bebef3f8 libobjc.A.dylib`objc_release + 136
    frame #29: 0x00000001beadfa08 libsystem_blocks.dylib`_Block_release + 168
    frame #30: 0x00000001088ff27c libdispatch.dylib`_dispatch_client_callout + 20
    frame #31: 0x000000010890690c libdispatch.dylib`_dispatch_lane_serial_drain + 720
    frame #32: 0x00000001089074fc libdispatch.dylib`_dispatch_lane_invoke + 408
    frame #33: 0x00000001089124dc libdispatch.dylib`_dispatch_workloop_worker_thread + 1344
    frame #34: 0x00000001bebc76d0 libsystem_pthread.dylib`_pthread_wqthread + 280
```

<video src="./HDCameraCrashDemo.mp4" controls="true" />





### 问题分析

在iOS13中，系统对在子线程进行UI操作做了更加严格的检验，会直接抛出 `threading violation: expected the main thread` 。该问题在真实项目中，我们对堆栈信息中的 `[UIDevice endGeneratingDeviceOrientationNotifications]` 进行 hook 处理，通过 Crash必现的路径，看到这个方法会发生在子线程中：

```objective-c
@implementation UIDevice (PG)

static inline void pg_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)load {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        pg_swizzleSelector(UIDevice.class, @selector(endGeneratingDeviceOrientationNotifications), @selector(pgEndGeneratingDeviceOrientationNotifications));
    }
}

- (void)pgEndGeneratingDeviceOrientationNotifications {
    NSLog(@"pgEndGeneratingDeviceOrientationNotifications isMainThread:%d", [NSThread isMainThread]);
    [self pgEndGeneratingDeviceOrientationNotifications];
}

@end
  
pgEndGeneratingDeviceOrientationNotifications isMainThread:0
```

也就是说在子线程中，触发了该方法，然后系统监听该通知做了UI操作，然后导致的Crash



### 问题解决

hook  `[UIDevice endGeneratingDeviceOrientationNotifications]` 判断执行该方法是否在主线程中执行，如果不是，则同步到主线程中转发: (最终代码)

```objective-c
@implementation UIDevice (PG)

static inline void pg_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)load {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        pg_swizzleSelector(UIDevice.class, @selector(endGeneratingDeviceOrientationNotifications), @selector(pgEndGeneratingDeviceOrientationNotifications));
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
```





### 问题结束了？

上面的问题解决，其实的确是能解决问题，但是并没有从根源上发现到底是什么地方导致，通过查看代码发现，我们的项目中对 `[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications]` 、`[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications]` 没有成对实现，测试发现，如果 多调用了两次  `[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications]`  ,  然后再唤起H5的拍照/录视频，在iOS13系统上必然Crash，可以在下载 [HDCameraCrashDemo](https://github.com/erduoniba/HDCameraCrashDemo/tree/master) 进行验证

**可以在  `[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications]` 、`[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications]`  添加一个 `BOOL` 类型的变量来控制他们的成对出现，从根本上解决这类问题。**

**所以这个并不一定是iOS13系统的问题，只要在调用系统方法合理，并不会有该类型的Crash发生。**



