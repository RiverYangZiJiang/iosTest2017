//
//  MLRatingStarView.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLRatingStarView.h"

@implementation MLRatingStarView

- (instancetype)initWithRating:(NSString *)rating
{
    self = [super init];
    if (self) {
        // 按评论星级增加星星视图
        self.rating = rating;
        for (NSUInteger index = 0; index < 5; index++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(index * 12);
                make.top.equalTo(self);
                make.height.width.equalTo(@12);
            }];
            
            NSString *imageName = @"ic_star_big-1";
            if ((index + 1) > rating.integerValue) {
                imageName = @"ic_star_big";
            }
            imageView.image = [UIImage imageNamed:imageName];
        }
    }
    return self;
}

- (void)setRating:(NSString *)rating{
    _rating = rating;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = (UIImageView *)obj;
        
        NSString *imageName = @"ic_star_big-1";
        if ((idx + 1) > rating.integerValue) {
            imageName = @"ic_star_big";
        }
        imageView.image = [UIImage imageNamed:imageName];
    }];
}

@end
