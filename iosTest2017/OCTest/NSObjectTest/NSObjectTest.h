//
//  NSObjectTest.h
//  OCTest
//
//  Created by yangzijiang on 02/04/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 1.OC中所有类都继承自NSObject类，NSObject类中所有方法，其他类都可以执行
 2.NSObject有很多分类，但是不在NSObject.h中，而是散落在各类中，如
 */
@interface NSObjectTest : NSObject
+ (void)test;
@end
