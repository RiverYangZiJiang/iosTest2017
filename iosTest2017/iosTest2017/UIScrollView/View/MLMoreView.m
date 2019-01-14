//
//  MLMoreView.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLMoreView.h"

@interface MLMoreView ()

@property (strong, nonatomic) UIView *leftView;

@end

@implementation MLMoreView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.leftView];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.equalTo(@19);
        }];
        
        CGSize size = [self.moreButton.titleLabel.text sizeForFont:self.moreButton.titleLabel.font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByCharWrapping];
        [self addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.width.equalTo(@(size.width + 1));
        }];
        
        self.moreViewWidth = 19 + size.width + 1;
    }
    return self;
}

#pragma mark - Selector
- (void)moreButtonClicked:(UIButton *)button{
    NSLog(@"%s", __func__);
    button.selected = !button.selected;
    
    CGSize size = [self.moreButton.titleLabel.text sizeForFont:self.moreButton.titleLabel.font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByCharWrapping];
    
    if (button.selected) {
        self.leftView.hidden = YES;
        self.moreViewWidth = size.width + 1;
    }else{
        self.leftView.hidden = NO;
        self.moreViewWidth = 19 + size.width + 1;
    }
    
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(size.width + 1));
    }];
    
    if ([self.delegate respondsToSelector:@selector(moreViewMoreButtonClicked:)]) {
        [self.delegate moreViewMoreButtonClicked:button];
    }
}

- (UIView *)leftView{
    if (!_leftView) {
        _leftView = UIView.new;
        _leftView.backgroundColor = color_neutral_white;
        _leftView.alpha = 0.8;
    }
    return _leftView;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitleColor:color_functional_blue_dark forState:UIControlStateNormal];
        [_moreButton setBackgroundColor:color_neutral_white];
        _moreButton.titleLabel.font = font_bold_size_caption;
        [_moreButton setTitle:@"MORE" forState:UIControlStateNormal];
        [_moreButton setTitle:@"COLLAPSE" forState:UIControlStateSelected];
        [_moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}
@end
