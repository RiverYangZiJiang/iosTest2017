//
//  CommentModel.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject
@property (nonatomic, copy) NSString *device_model;

@property (nonatomic, copy) NSString *feedback_desc;

@property (nonatomic, copy) NSString *feedback_time;

@property (nonatomic, copy) NSString *rating;

@property (nonatomic, copy) NSString *user;

// 该Model对应的Cell高度。注：缓存高度，这样大数据量场景下也不会卡顿
@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithDeviceModel:(NSString *)device_model feedback_desc:(NSString *)feedback_desc feedback_time:(NSString *)feedback_time rating:(NSString *)rating user:(NSString *)user;

+ (NSMutableArray *)testData;
@end

NS_ASSUME_NONNULL_END
