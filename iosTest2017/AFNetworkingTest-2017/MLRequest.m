//
//  MLRequest.m
//  AFNetworkingTest-2017
//
//  Created by 杨子江 on 8/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "MLRequest.h"

@implementation MLRequest
/**
 Creates and returns a new `MLRequest` object.
 */
+ (instancetype)request{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _timeoutInterval = 60;
        _retryCount = 0;
    }
    return self;
}
@end
