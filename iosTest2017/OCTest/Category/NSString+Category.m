//
//  NSString+Category.m
//  OCTest
//
//  Created by yangzijiang on 2018/4/29.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (NSUInteger)length{
    NSLog(@"%s", __func__);
    if (![self isKindOfClass:[NSString class]]) {
        return 0;
    }
    
    return self.length;
}

@end
