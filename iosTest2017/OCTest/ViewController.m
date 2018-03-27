//
//  ViewController.m
//  OCTest
//
//  Created by yangzijiang on 07/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "OCDevelopmentNorms.h"
#import "CrashTest.h"
#import "NSStringTest.h"
#import "NSTimerTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    OCDevelopmentNorms *ocdn = [[OCDevelopmentNorms alloc] init];
//    [ocdn setName:@"zs"];
//    NSLog(@"ocdn name = %@", [ocdn name]);
    
//    [CrashTest arrayCrashTest];
//    [CrashTest avoidCrashTest];
    [NSStringTest compareTest];
    
//    NSTimerTest *timerTest = [NSTimerTest defaultInstance];
//    [timerTest startTimer];
//    [timerTest startTimerFire];
}




@end
