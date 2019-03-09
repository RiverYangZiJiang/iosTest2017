//
//  MLTitleView.m
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLTitleView.h"
#import "UILabel+MLCategory.h"

@interface MLTitleView ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@end
@implementation MLTitleView

+ titleViewWithTitle:(NSString *)title imageType:(MLTitleViewImageType)imageType{
    MLTitleView *titleView = [[MLTitleView alloc] initWithTitle:title imageType:imageType];
    return titleView;
}

- (MLTitleView *)initWithTitle:(NSString *)title imageType:(MLTitleViewImageType)imageType{
    self = [super init];
    if (self) {
        self.titleLabel.text = title;
        [self addSubview:self.titleLabel];
        CGFloat titleLabelW = [title widthForFont:self.titleLabel.font] + 1;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.height.centerY.equalTo(self);
            make.width.equalTo(@(titleLabelW));
        }];
        
        switch (imageType) {
            case MLTitleViewImageTypeNone:
                [self.imageView setImage:nil];
                break;
            case MLTitleViewImageTypeMust:
                [self.imageView setImage:IMAGE_BY_NAME(@"ic_asterisk")];
                break;
            case MLTitleViewImageTypeInfo:
                [self.imageView setImage:IMAGE_BY_NAME(@"ic_info")];
                break;
            default:
                break;
        }

        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(4);
            make.centerY.equalTo(self);
            make.height.width.equalTo(@16);
        }];
    }
    return self;
}

#pragma mark - Getters & Setters
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"Label Name" font:font_size_bold_12 textColor:color_neutral_charcoal_medium textAlignment:NSTextAlignmentLeft numberOfLines:1];
    }
    return _titleLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
