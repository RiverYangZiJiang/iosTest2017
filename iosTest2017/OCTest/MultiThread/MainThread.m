//
//  MainThread.m
//  OCTest
//
//  Created by yangzijiang on 31/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "MainThread.h"
#import "YZJDownloadImageOperation.h"

@implementation MainThread

+ (void)MainThreadTest{
//    [[MainThread defaultInstance] subThreadNotification];
    [MainThread dispatch_group_tTest];
}

+ (instancetype)defaultInstance {
    static MainThread *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(subThreadNotificationHandle) name:@"notificationThread" object:nil];
    });
    return sharedInstance;
}

#pragma mark - 在子线程发送的通知，selector对应方法在子线程中执行
- (void)subThreadNotification{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationThread" object:self];
    });
}

- (void)subThreadNotificationHandle{
    // 在子线程发送的通知，selector对应方法在子线程中执行
    NSLog(@"%s currentThread = %@", __func__, [NSThread currentThread]);  // {number = 3, name = (null)}
}



+ (void)GCDMainThread{
    // 主队列是一个串行队列
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"i = %d, currentThread = %@", i, [NSThread currentThread]);
        }
    });
    
    NSLog(@"end of GCDMainThread, currentThread = %@", [NSThread currentThread]);
    
    /**
     最终日志打印如下：
     2018-03-31 11:22:12.045499+0800 OCTest[49781:20418079] end of GCDMainThread, currentThread = <NSThread: 0x604000261040>{number = 1, name = main}
     2018-03-31 11:22:12.048543+0800 OCTest[49781:20418079] i = 0, currentThread = <NSThread: 0x604000261040>{number = 1, name = main}
     2018-03-31 11:22:12.048664+0800 OCTest[49781:20418079] i = 1, currentThread = <NSThread: 0x604000261040>{number = 1, name = main}
     */
}

#pragma mark - dispatch_group_t
+ (void)dispatch_group_tTest{
    dispatch_group_t dg = dispatch_group_create();
    for (NSUInteger i = 0; i < 10; i++) {
        dispatch_group_enter(dg);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (NSUInteger j = 0; j < 10; j++) {
                NSLog(@"i = %lu, j = %lu, currentThread = %@", (unsigned long)i, (unsigned long)j, [NSThread currentThread]);
            }
            dispatch_group_leave(dg);
        });
    }
    
    dispatch_group_notify(dg, dispatch_get_main_queue(), ^{
        // 要等所有的都leave之后，才会调用
        NSLog(@"dispatch_group_notify, currentThread = %@", [NSThread currentThread]);
    });
    
    // 最先打印
    NSLog(@"end");
}

/**
 ios 将一个函数在主线程执行的4种方法 http://blog.sina.com.cn/s/blog_a1d242c90102wjda.html
 1.GCD方法，通过向主线程队列发送一个block块，使block里的方法可以在主线程中执行。
 dispatch_async(dispatch_get_main_queue(), ^{ //需要执行的方法 });
 2.NSOperation 方法
 NSOperationQueue *mainQueue = [NSOperationQueue mainQueue]; //主队列 NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{ //需要执行的方法 }]; [mainQueue addOperation:operation];
 3.NSThread 方法
 [self performSelector:@selector(method) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES modes:nil]; [self performSelectorOnMainThread:@selector(method) withObject:nil waitUntilDone:YES]; [[NSThread mainThread] performSelector:@selector(method) withObject:nil];
 4.RunLoop方法
 [[NSRunLoop mainRunLoop] performSelector:@selector(method) withObject:nil];

 */
@end
