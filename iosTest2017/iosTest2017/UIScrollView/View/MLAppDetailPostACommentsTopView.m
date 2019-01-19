//
//  MLAppDetailPostACommentsTopView.m
//  iosTest2017
//
//  Created by 杨子江 on 1/18/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailPostACommentsTopView.h"
@interface MLAppDetailPostACommentsTopView ()

@end
@implementation MLAppDetailPostACommentsTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = color_neutral_white;
        
        // 顶部横线
        UIView *topLine = UIView.new;
        topLine.backgroundColor = color_neutral_grey_light;
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        
        // 底部横线
        UIView *bottomLine = UIView.new;
        bottomLine.backgroundColor = color_neutral_grey_light;
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        
        // 编辑图
        UIImageView *imageView = UIImageView.new;
        [self addSubview:imageView];
        imageView.image = IMAGE_BY_NAME(@"ic_rename");
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
            make.height.width.equalTo(@24);
        }];
        
        // Post a comments的Label
        UILabel *label = UILabel.new;
        label.textColor = color_neutral_charcoal_light;
        label.text = @"Post a comments";
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(8);
            make.centerY.equalTo(imageView);
            make.height.equalTo(@24);
            make.right.equalTo(self);
        }];
        
        CGSize size = [self.postButton.titleLabel.text sizeForFont:self.postButton.titleLabel.font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByCharWrapping];
        [self addSubview:self.postButton];
        [self.postButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@24);
            make.width.equalTo(@(size.width));
            make.centerY.equalTo(imageView);
            make.right.equalTo(self).offset(-24);
        }];
        
    }
    return self;
}

- (UIButton *)postButton{
    if (!_postButton) {
        _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postButton setTitle:@"POST" forState:UIControlStateNormal];
        [_postButton setTitleColor:color_brand_primary forState:UIControlStateNormal];
        [_postButton setTitleColor:color_neutral_charcoal_light forState:UIControlStateDisabled];
        _postButton.enabled = NO;
        _postButton.titleLabel.font = font_size_bold_16;
        _postButton.hidden = YES;
    }
    return _postButton;
}
@end
