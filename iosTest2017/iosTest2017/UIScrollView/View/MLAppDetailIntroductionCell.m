//
//  MLAppDetailIntroductionCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailIntroductionCell.h"
#import "MLRatingStarView.h"

@interface MLAppDetailIntroductionCell ()
/// 介绍
@property (strong, nonatomic) UILabel *introductionLabel;
/// 版本
@property (strong, nonatomic) UILabel *versionLabel;
@property (strong, nonatomic) UILabel *versionContentLabel;
@property (strong, nonatomic) UILabel *releasedOnLabel;
@property (strong, nonatomic) UILabel *releasedOnContentLabel;
@property (strong, nonatomic) UILabel *developerLabel;
@property (strong, nonatomic) UILabel *developerContentLabel;

/// 分割线
@property (strong, nonatomic) UIView *separatorLine;

@end

@implementation MLAppDetailIntroductionCell

+ (MLAppDetailIntroductionCell *)cellWithTableView:(UITableView *)tableView{
    MLAppDetailIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLAppDetailIntroductionCell"];
    if (!cell) {
        cell = [[MLAppDetailIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MLAppDetailIntroductionCell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.介绍Introduction
        [self.contentView addSubview:self.introductionLabel];
        [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.contentView).offset(16);
            make.height.equalTo(@21);
        }];
        
        [self.contentView addSubview:self.versionLabel];
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.width.equalTo(@90);
            make.top.equalTo(self.introductionLabel.mas_bottom).offset(8);
            make.height.equalTo(@18);
        }];
        
        [self.contentView addSubview:self.versionContentLabel];
        [self.versionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionLabel.mas_right).offset(22);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.versionLabel);
            make.height.equalTo(self.versionLabel);
        }];
        
        [self.contentView addSubview:self.releasedOnLabel];
        [self.releasedOnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionLabel);
            make.width.equalTo(@90);
            make.top.equalTo(self.versionLabel.mas_bottom).offset(4);
            make.height.equalTo(@21);
        }];
        
        [self.contentView addSubview:self.releasedOnContentLabel];
        [self.releasedOnContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.releasedOnLabel.mas_right).offset(22);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.releasedOnLabel);
            make.height.equalTo(self.releasedOnLabel);
        }];
        
        [self.contentView addSubview:self.developerLabel];
        [self.developerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionLabel);
            make.width.equalTo(@90);
            make.top.equalTo(self.releasedOnLabel.mas_bottom).offset(4);
            make.height.equalTo(@21);
        }];
        
        [self.contentView addSubview:self.developerContentLabel];
        [self.developerContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.developerLabel.mas_right).offset(22);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.developerLabel);
            make.height.equalTo(self.developerLabel);
        }];
        
        [self.contentView addSubview:self.separatorLine];
        [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)cellHeightByCommentModel:(CommentModel *)commentModel{
    CGSize size = [commentModel.feedback_desc sizeForFont:font_size_body size:CGSizeMake((ScreenWidth - (8 + 18) * 2 ), MAXFLOAT) mode:NSLineBreakByWordWrapping];
    return 62.5 + size.height + 1;
}

#pragma mark - Custom Accessors
- (void)setCommentModel:(CommentModel *)commentModel{
    _commentModel = commentModel;
}

#pragma mark --- 介绍Introduction
- (UILabel *)introductionLabel{
    if (!_introductionLabel) {
        _introductionLabel = UILabel.new;
        _introductionLabel.textColor = [UIColor colorWithHexString:@"242a34"];
        _introductionLabel.font = [UIFont boldSystemFontOfSize:14];
        _introductionLabel.textAlignment = NSTextAlignmentLeft;
        _introductionLabel.text = @"Introduction";
    }
    return _introductionLabel;
}

- (UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = UILabel.new;
        _versionLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _versionLabel.font = [UIFont systemFontOfSize:12];
        _versionLabel.textAlignment = NSTextAlignmentLeft;
        _versionLabel.text = @"Version:";
    }
    return _versionLabel;
}

- (UILabel *)versionContentLabel{
    if (!_versionContentLabel) {
        _versionContentLabel = UILabel.new;
        _versionContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _versionContentLabel.font = [UIFont systemFontOfSize:12];
        _versionContentLabel.textAlignment = NSTextAlignmentLeft;
        _versionContentLabel.text = @"7.2.0";
    }
    return _versionContentLabel;
}

- (UILabel *)releasedOnLabel{
    if (!_releasedOnLabel) {
        _releasedOnLabel = UILabel.new;
        _releasedOnLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _releasedOnLabel.font = [UIFont systemFontOfSize:12];
        _releasedOnLabel.textAlignment = NSTextAlignmentLeft;
        _releasedOnLabel.text = @"Released on:";
    }
    return _releasedOnLabel;
}

- (UILabel *)releasedOnContentLabel{
    if (!_releasedOnContentLabel) {
        _releasedOnContentLabel = UILabel.new;
        _releasedOnContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _releasedOnContentLabel.font = [UIFont systemFontOfSize:12];
        _releasedOnContentLabel.textAlignment = NSTextAlignmentLeft;
        _releasedOnContentLabel.text = @"RulePrioritySiteB";
    }
    return _releasedOnContentLabel;
}

- (UILabel *)developerLabel{
    if (!_developerLabel) {
        _developerLabel = UILabel.new;
        _developerLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _developerLabel.font = [UIFont systemFontOfSize:12];
        _developerLabel.textAlignment = NSTextAlignmentLeft;
        _developerLabel.text = @"Developer:";
    }
    return _developerLabel;
}

- (UILabel *)developerContentLabel{
    if (!_developerContentLabel) {
        _developerContentLabel = UILabel.new;
        _developerContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _developerContentLabel.font = [UIFont systemFontOfSize:12];
        _developerContentLabel.textAlignment = NSTextAlignmentLeft;
        _developerContentLabel.text = @"Gwx601027";
    }
    return _developerContentLabel;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = UIView.new;
        _separatorLine.backgroundColor = color_neutral_grey_light;
    }
    return _separatorLine;
}

@end
