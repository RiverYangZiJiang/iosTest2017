//
//  NSTimerTest.h
//  OCTest
//
//  Created by yangzijiang on 10/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimerTest : NSObject
+ (instancetype)defaultInstance;
- (void)startTimer;
- (void)startTimerFire;
@end
