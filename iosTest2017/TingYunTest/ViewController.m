//
//  ViewController.m
//  TingYunTest
//
//  Created by yangzijiang on 02/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自定义Trace，由于自定义Trace是成对出现的，请勿跨方法、跨进程以及在异步加载和递归调用中使用该接口。
    // 听云SDK默认采集系统类和方法的性能数据，无法采集开发者自定义类和方法的性能数据。使用“自定义Trace”接口就可以帮助开发者时刻了解所写代码的健壮性及其性能数据。如：开发者想要了解某个自定义方法的初始化耗时及性能消耗情况，就可以在该自定义方法前后添加“自定义Trace”接口即可。
    beginTracer(@"beginTracer");
    
    // 设置面包屑，面包屑能够更好的协助用户调查崩溃发生的原因，可以知晓用户发生崩溃之前的代码逻辑与崩溃轨迹结合使用能够更好的复现用户崩溃场景。
    [NBSAppAgent leaveBreadcrumb:@"leaveBreadcrumb viewDidLoad"];
    
    // 自定义Event，自定义事件用于统计App中的任意事件，开发者可以在SDK初始化后的任意位置添加自定义事件，并设置对应上传参数。如：真实用户操作时候点击某个功能按钮或触发了某个功能事件等。
    // 自定义Event在用户行为可看到，免费版本看不到。另外一个产品听云ba有用户行为功能，需要额外部署一套环境 ——听云深圳邹威 13828830675
    [NBSAppAgent trackEvent:@"viewDidLoad event"];
    
    // 自定义ID，用户自定义ID为当前用户设置唯一标示码，在MainActivity的onCreate里用初始化方法传入UserID。
    [NBSAppAgent setUserIdentifier:@"setUserIdentifier TingYunTest"];
    
    endTracer(@"endTracer");
    
    [self addCrashButton];
}

- (void)addCrashButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 100, 100);
    [button setTitle:@"crash" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(crash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [NBSAppAgent setCustomerData:@"setCustomerData addCrashButton" forKey:@"addCrashButton"];
}

- (void)crash:(UIButton *)button{
    [self crashTest];
}
- (void)crashTest {
    
    // 会报Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSCFConstantString stringByAppendingString:]: nil argument'
    [@"str" stringByAppendingString:nil];
}


@end
