//
//  MLRatingStarView.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLRatingStarView.h"

@implementation MLRatingStarView

- (instancetype)initWithRating:(NSString *)rating width:(CGFloat)width
{
    self = [super init];
    if (self) {
        for (NSUInteger index = 0; index < 5; index++) {
            UIButton *button = [[UIButton alloc] init];
            button.tag = index + 1;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(index * width);
                make.top.equalTo(self);
                make.height.width.equalTo(@(width));
            }];
            
            NSString *imageName = @"ic_star_big-1";
            if ((index + 1) > rating.integerValue) {
                imageName = @"ic_star_big";
            }
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            // 为适应不同尺寸，UIButton设置图片显示contentmode
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [[button imageView] setContentMode:UIViewContentModeScaleAspectFill];
            button.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;
            button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        }
        // 按评论星级增加星星视图
        self.rating = rating;
    }
    return self;
}

- (void)starButtonClicked:(UIButton *)button{
    NSUInteger rating;
    if (button.tag > 1) {  // 非第一个星星，点击第几个就表示几星
        rating = button.tag;
    }else{  // 如果点击的是第一个星星，第一次相当于选择1星，再次点击就是选择0星
        button.selected = !button.selected;
        rating = button.selected;
    }
    [self setRating:[NSString stringWithFormat:@"%lu", rating]];
}

- (void)setRating:(NSString *)rating{
    _rating = rating;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = (UIButton *)obj;
        
        NSString *imageName = @"ic_star_big-1";
        if ((idx + 1) > rating.integerValue) {
            imageName = @"ic_star_big";
        }
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }];
}

@end
