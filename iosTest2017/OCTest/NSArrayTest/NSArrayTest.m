//
//  NSArrayTest.m
//  OCTest
//
//  Created by yangzijiang on 2018/4/30.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSArrayTest.h"

@interface NSArrayTest()

@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation NSArrayTest

- (void)arrayTest{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self sortAndRemoveCrash];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self sortAndRemoveCrash];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self sortAndRemoveCrash];
    });
}

- (void)sortAndRemoveCrash{
    @synchronized(self){
        NSLog(@"%s, currentThread = %@", __func__, [NSThread currentThread]);
        self.arrayM = [NSMutableArray array];
        for(NSInteger i = 0; i <1000; i++){
            [self.arrayM addObject:[NSString stringWithFormat:@"%ld", (long)i]];
        }
        
        [self.arrayM sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSLog(@"%s, obj1 = %@, obj2 = %@", __func__, obj1, obj2);
            return obj1 > obj2;
        }];
        
        if(self.arrayM.count > 10){
            [self.arrayM removeObjectsInRange:NSMakeRange(10, self.arrayM.count - 10)];
            NSLog(@"%s after arrayM removeObjectsInRange", __func__);
        }
    }
}

@end
