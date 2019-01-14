//
//  MLRatingStarView.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用来显示评论级别的星星视图
 */
@interface MLRatingStarView : UIView
@property (nonatomic, copy) NSString *rating;

- (instancetype)initWithRating:(NSString *)rating;
@end

NS_ASSUME_NONNULL_END
