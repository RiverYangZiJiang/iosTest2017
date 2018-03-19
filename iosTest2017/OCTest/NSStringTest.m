//
//  NSStringTest.m
//  OCTest
//
//  Created by yangzijiang on 09/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSStringTest.h"

@implementation NSStringTest

+ (void)compareTest{
    NSString *arg1 = @"0";
    NSString *arg2 = nil;
    NSComparisonResult result = [arg1 compare:arg2 options:NSNumericSearch];
    NSLog(@"result = %ld", (long)result);  // result = 1
}
@end
