//
//  MLRequest.h
//  AFNetworkingTest-2017
//
//  Created by 杨子江 on 8/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLRequest : NSObject
/**
 Creates and returns a new `MLRequest` object.
 */
+ (instancetype)request;

@property (copy, nonatomic) NSString *url;

/**
 The parameters for request.
 */
@property (strong, nonatomic) NSDictionary<NSString *, id> *parameters;

/**
 Timeout interval for request, `60` seconds by default.
 */
@property(assign, nonatomic) NSTimeInterval timeoutInterval;

/**
 The retry count for current request when error occurred, `0` by default.
 */
@property(assign, nonatomic) NSUInteger retryCount;
@end
