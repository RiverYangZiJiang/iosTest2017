//
//  MLRequestManager.m
//  AFNetworkingTest-2017
//
//  Created by 杨子江 on 8/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "MLRequestManager.h"

@implementation MLRequestManager
+ (instancetype)defaultManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSString *)sendRequest:(MLRequestConfigBlock)configBlock
                onSuccess:(nullable MLSuccessBlock)successBlock
                onFailure:(nullable MLFailureBlock)failureBlock
               onFinished:(nullable MLFinishedBlock)finishedBlock{
    NSLog(@"%s", __func__);
    
    MLRequest *requestTemp = [MLRequest request];
    XM_SAFE_BLOCK(configBlock, requestTemp);
    
//    if (failureBlock) {
        if (requestTemp.retryCount > 0) {
            requestTemp.retryCount--;
            NSLog(@"requestTemp.retryCount = %ld", requestTemp.retryCount);
            [MLRequestManager sendRequest:^(MLRequest *request) {
                request.retryCount = requestTemp.retryCount;
            } onSuccess:nil onFailure:nil onFinished:nil];
        }
//    }
    return @"";
}


@end
