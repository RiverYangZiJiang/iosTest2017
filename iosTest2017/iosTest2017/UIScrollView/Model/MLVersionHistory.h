//
//  MLVersionHistory.h
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 历史版本模型
 */
@interface MLVersionHistory : NSObject
/// 版本
@property (copy, nonatomic) NSString *version;
/// 时间
@property (copy, nonatomic) NSString *time;
/// 描述
@property (copy, nonatomic) NSString *desc;

@property(assign, nonatomic) NSUInteger cellHeight;

+ (MLVersionHistory *)versionHistoryWith:(NSString *)version time:(NSString *)time desc:(NSString *)desc;
@end

NS_ASSUME_NONNULL_END
