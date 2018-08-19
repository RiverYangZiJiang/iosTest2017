//
//  MLRequestManager.h
//  AFNetworkingTest-2017
//
//  Created by 杨子江 on 8/18/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLRequest.h"

#define XM_SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })

typedef void (^MLRequestConfigBlock)(MLRequest *request);

typedef void (^MLProgressBlock)(NSProgress *progress);
typedef void (^MLSuccessBlock)(id _Nullable responseObject);
typedef void (^MLFailureBlock)(NSError * _Nullable error);
typedef void (^MLFinishedBlock)(id _Nullable responseObject, NSError * _Nullable error);
typedef void (^MLCancelBlock)(id _Nullable request);

@interface MLRequestManager : NSObject
+ (instancetype)defaultManager;

+ (NSString *)sendRequest:(MLRequestConfigBlock)configBlock
                onSuccess:(nullable MLSuccessBlock)successBlock
                onFailure:(nullable MLFailureBlock)failureBlock
               onFinished:(nullable MLFinishedBlock)finishedBlock;
@end
