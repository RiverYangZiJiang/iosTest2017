//
//  ViewController1.m
//  InstrumentsTest
//
//  Created by yangzijiang on 2018/11/17.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self timer];
}

- (void)dealloc{
    NSLog(@"%s", __func__);
    // 当timer和self循环引用时，返回到上一层vc时，self的dealloc并不会被调用到，导致以下代码用于不会被调用
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)handleTimer:(NSTimer *)timer{
    NSLog(@"%s", __func__);
}

- (NSTimer *)timer{
    if (!_timer) {
        // 执行一个timer的时候会用(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti  target:(id)aTarget  selector:(SEL)aSelector  userInfo:(id)userInfo  repeats:(BOOL)yesOrNo   这里的aTarget一般是self，这时候就需要注意了，如果在你退出的时候这个timer还在执行的话由于这个timer会持有self，所以delloc也不会调用，这里可以用weakSelf代替self也是没有问题的。[1]
        // repeats参数被设置成YES时，target中的对象将永远不会被释放，只有调用invalidate方法之后才会释放target对象，从而释放接收处理target对象。
        
        // target使用self会导致循环引用，即返回时timer还没有结束，则会导致内存泄漏
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
        
        // 如此就不会导致循环引用
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"%s", __func__);
//        }];
        
        // 如此也不会导致循环引用
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:NO];
        
        // 如此也会导致循环引用
        __weak __typeof(self)weakSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
    return _timer;
}

/*
 [1]https://www.jianshu.com/p/1d2f0cb0c2bf
 */

@end
