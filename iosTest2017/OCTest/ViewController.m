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
#import "MainThread.h"
#import "NSObjectTest.h"
#import "NSRegularExpressionTest.h"
#import "NSArrayTest.h"
#import "CLLocationManagerTest.h"
#import "LoopSortTest.h"
#import "NSURLTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *domain = @"com.MyCompany.MyApplication.ErrorDomain";
    NSString *desc = @"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:-101
                                     userInfo:userInfo];
    
    NSLog(@"error.description = %@", error.description);
    NSLog(@"[error description] = %@", [error description]);
//    [NSURLTest NSURLTest];
//    [LoopSortTest loopSortTest];
//    [[[NSArrayTest alloc] init] arrayTest];
//    [NSRegularExpressionTest regularExpressionTest];
//    NSObjectTest *nst = [[NSObjectTest alloc] init];
//    OCDevelopmentNorms *ocdn = [[OCDevelopmentNorms alloc] init];
//    [ocdn setName:@"zs"];
//    NSLog(@"ocdn name = %@", [ocdn name]);
    
//    [CrashTest arrayCrashTest];
//    [CrashTest crashTest];
//    [NSStringTest stringTest];
    
//    NSTimerTest *timerTest = [NSTimerTest defaultInstance];
//    [timerTest startTimer];
//    [timerTest startTimerFire];
    
//    [MainThread MainThreadTest];
    
//    [CLLocationManagerTest defaultInstance];
}




@end
