//
//  NSObjectTest.m
//  OCTest
//
//  Created by yangzijiang on 02/04/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSObjectTest.h"

@implementation NSObjectTest

+ (void)test{
    
}

/**
 1.OC中任何对象在被释放时都会调用dealloc方法，可以在该方法中打印日志来查看对象是否被释放，如视图控制器等
 2.dealloc不能手动调用
 */
- (void)dealloc{
    NSLog(@"dealloc");
}
@end
