//
//  CrashTest.m
//  OCTest
//
//  Created by yangzijiang on 09/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "CrashTest.h"

@implementation CrashTest

+ (void)arrayCrashTest{
    // 对空数组遍历并不会崩溃，所以不需要事先判断数组是否为空
    NSArray *array;
    for (id item in array) {
        NSLog(@"item = %@", item);
    }
    
    if (!array.count) {
        NSLog(@"array.count == 0");
    }
    
    NSLog(@"arrayCrashTest end");
}
@end
