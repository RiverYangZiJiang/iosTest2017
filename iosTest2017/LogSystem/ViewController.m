//
//  ViewController.m
//  LogSystem
//
//  Created by yangzijiang on 21/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "LogUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    LOG_INFO(kModuleViewController,@" ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSDate *startDate = [NSDate date];
    for(int i = 0; i < 10000; i++){
        LOG_INFO(kModuleViewController, @"abc abc abc 中国人 中国人 中国人 %d", i);
    }
    NSDate *endate = [NSDate date];
    NSLog(@"spend time %f", [endate timeIntervalSinceDate:startDate]);
}

@end
