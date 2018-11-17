//
//  TestNSTimer.m
//  InstrumentsTest
//
//  Created by yangzijiang on 2018/11/17.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "TestNSTimer.h"

@interface TestNSTimer ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TestNSTimer



- (instancetype)init {
    
    if(self = [super init]) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRefresh:) userInfo:nil repeats:YES];
        
    }
    
    return self;
    
}



- (void)timeRefresh:(NSTimer*)timer {
    
    NSLog(@"TimeRefresh...");
    
}



- (void)cleanTimer {
    
    [_timer invalidate];
    
    _timer = nil;
    
}



- (void)dealloc {
    NSLog(@"销毁");
    
    [self cleanTimer];
    
}
@end
