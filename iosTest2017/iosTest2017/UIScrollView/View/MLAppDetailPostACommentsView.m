//
//  MLAppDetailPostACommentsView.m
//  iosTest2017
//
//  Created by 杨子江 on 1/19/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailPostACommentsView.h"
#import "MLAppDetailPostACommentsTopView.h"
#import "MLRatingStarView.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>

@interface MLAppDetailPostACommentsView ()<UITextViewDelegate>
/// 背景遮罩，点击隐藏MLAppDetailPostACommentsView视图
@property (strong, nonatomic) UIView *maskView;
/// 用来容纳postACommentsView、starView等评论视图
@property (strong, nonatomic) UIView *blankView;
@property (strong, nonatomic) MLAppDetailPostACommentsTopView *postACommentsTopView;

/// 显示星级的视图
@property (strong, nonatomic) MLRatingStarView *starView;

@property (strong, nonatomic) UILabel *tapTheStarsToRateLabel;
@property (strong, nonatomic) UIView *commentView;
@property (strong, nonatomic) UILabel *showCharNumLabel;
@property (strong, nonatomic) UILabel *pleaceWriteACommentLabel;
@end
@implementation MLAppDetailPostACommentsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.maskView];
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self).offset(-268);
        }];
        
        [self addSubview:self.blankView];
        [self.blankView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.maskView.mas_bottom);
        }];
        
        [self.blankView addSubview:self.postACommentsTopView];
        [self.postACommentsTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.blankView);
            make.height.equalTo(@49);
        }];
        
        [self.blankView addSubview:self.starView];
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.postACommentsTopView.mas_bottom).offset(12);
            make.centerX.equalTo(self.blankView);
            make.width.equalTo(@120);
            make.height.equalTo(@24);
        }];
        
        [self.blankView addSubview:self.tapTheStarsToRateLabel];
        [self.tapTheStarsToRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.blankView);
            make.top.equalTo(self.starView.mas_bottom).offset(8);
            make.height.equalTo(@18);
        }];
        
        [self.blankView addSubview:self.commentView];
        [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tapTheStarsToRateLabel.mas_bottom).offset(16);
            make.left.equalTo(self.blankView).offset(16);
            make.right.equalTo(self.blankView).offset(-16);
            make.height.equalTo(@103.5);
        }];
        
        [self.blankView addSubview:self.comentTextView];
        [self.comentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.commentView).offset(12);
            make.top.equalTo(self.commentView).offset(8);
            make.bottom.equalTo(self.commentView).offset(-0.5);
            make.right.equalTo(self.commentView).offset(-38);
        }];
        
        [self.blankView addSubview:self.showCharNumLabel];
        [self.showCharNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.comentTextView.mas_right);
            make.right.equalTo(self.commentView);
            make.bottom.equalTo(self.commentView).offset(-9);
            make.height.equalTo(@12);
        }];
        
        [self.blankView addSubview:self.pleaceWriteACommentLabel];
        [self.pleaceWriteACommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.commentView);
            make.top.equalTo(self.commentView.mas_bottom).offset(4);
            make.height.equalTo(@18);
        }];
    }
    return self;
}

#pragma mark - Selectors
- (void)postButtonClicked:(UIButton *)button{
    NSLog(@"%s", __func__);
    self.hidden = YES;
    [self endEditing:YES];
}

- (void)maskViewClicked:(UIView *)view{
    self.hidden = YES;
    [self endEditing:YES];
}

#pragma mark - UITextViewDelegate
static const NSUInteger maxCharNum = 400;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%s", __func__);
    if (textView.text.length >= maxCharNum) {
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%s", __func__);
    self.showCharNumLabel.text = [NSString stringWithFormat:@"%lu/%lu", textView.text.length, maxCharNum];
    if (textView.text.length > 0) {
        self.pleaceWriteACommentLabel.hidden = YES;
        self.postACommentsTopView.postButton.enabled = YES;
    }else{
        self.pleaceWriteACommentLabel.hidden = NO;
        self.postACommentsTopView.postButton.enabled = NO;
    }
    
}

#pragma mark - Customer Accessors
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = UIView.new;
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UIGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClicked:)];
        [_maskView addGestureRecognizer:gr];
    }
    return _maskView;
}

- (UIView *)blankView{
    if (!_blankView) {
        _blankView = UIView.new;
        _blankView.backgroundColor = color_neutral_white;
    }
    return _blankView;
}

- (MLAppDetailPostACommentsTopView *)postACommentsTopView{
    if (!_postACommentsTopView) {
        _postACommentsTopView = MLAppDetailPostACommentsTopView.new;
        _postACommentsTopView.postButton.hidden = NO;
        [_postACommentsTopView.postButton addTarget:self action:@selector(postButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postACommentsTopView;
}

- (MLRatingStarView *)starView{
    if (!_starView) {
        _starView = [[MLRatingStarView alloc] initWithRating:@"3" width:24];
    }
    return _starView;
}

-(UILabel *)tapTheStarsToRateLabel{
    if (!_tapTheStarsToRateLabel) {
        _tapTheStarsToRateLabel = UILabel.new;
        _tapTheStarsToRateLabel.text = @"Tap the stars to rat";
        _tapTheStarsToRateLabel.textAlignment = NSTextAlignmentCenter;
        _tapTheStarsToRateLabel.textColor = color_functional_53627c;
        _tapTheStarsToRateLabel.font = font_size_caption;
    }
    return _tapTheStarsToRateLabel;
}

- (UIView *)commentView{
    if (!_commentView) {
        _commentView = UIView.new;
        _commentView.layer.borderColor = color_functional_bdc3cd.CGColor;
        _commentView.layer.borderWidth = 0.5;
    }
    return _commentView;
}

- (UITextView *)comentTextView{
    if (!_comentTextView) {
        _comentTextView = UITextView.new;
        _comentTextView.textColor = color_functional_242a34;
        _comentTextView.font = font_size_body;
        _comentTextView.placeholder = @"Pleace enter your comment（up to 100 characters）";
        _comentTextView.placeholderColor = color_functional_a6aebc;
        _comentTextView.delegate = self;
    }
    return _comentTextView;
}

- (UILabel *)showCharNumLabel{
    if (!_showCharNumLabel) {
        _showCharNumLabel = UILabel.new;
        _showCharNumLabel.textColor = color_functional_78849c;
        _showCharNumLabel.font = font_size_over_line;
        _showCharNumLabel.text = @"0/400";
    }
    return _showCharNumLabel;
}

- (UILabel *)pleaceWriteACommentLabel{
    if (!_pleaceWriteACommentLabel) {
        _pleaceWriteACommentLabel = UILabel.new;
        _pleaceWriteACommentLabel.text = @"Pleace write a comment.";
        _pleaceWriteACommentLabel.textColor = color_functional_e70f08;
        _pleaceWriteACommentLabel.font = font_size_caption;
        _pleaceWriteACommentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _pleaceWriteACommentLabel;
}
@end
