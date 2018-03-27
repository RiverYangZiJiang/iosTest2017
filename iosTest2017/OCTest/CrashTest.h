//
//  CrashTest.h
//  OCTest
//
//  Created by yangzijiang on 09/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashTest : NSObject
+ (void)arrayCrashTest;
+ (void)avoidCrashTest;
@end

/**
 Foundation框架存在许多潜在崩溃的危险
 ● 将 nil 插入可变数组中会导致崩溃。
 ● 数组越界会导致崩溃。
 ● 根据key给字典某个元素重新赋值时，若key为 nil 会导致崩溃。
 https://github.com/chenfanfang/AvoidCrash
 
 
 
 */
