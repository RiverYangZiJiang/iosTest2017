//
//  MLCommentCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLCommentCell.h"
#import "MLRatingStarView.h"

@interface MLCommentCell ()
@property (strong, nonatomic) UILabel *userLabel;

@property (strong, nonatomic) UILabel *feedback_descLabel;

@property (strong, nonatomic) UILabel *feedback_timeLabel;

@property (strong, nonatomic) MLRatingStarView *ratingStarView;

/// 分割线
@property (strong, nonatomic) UIView *separatorLine;

@end

@implementation MLCommentCell

+ (MLCommentCell *)cellWithTableView:(UITableView *)tableView{
    MLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLCommentCell"];
    if (!cell) {
        cell = [[MLCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MLCommentCell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.userLabel];
        [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.top.equalTo(self).offset(8);
            make.height.equalTo(@18);
            make.width.equalTo(@120);
        }];
        
        [self.contentView addSubview:self.feedback_timeLabel];
        [self.feedback_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.top.equalTo(self).offset(8);
            make.height.equalTo(@18);
            make.width.equalTo(@120);
        }];
        
        [self.contentView addSubview:self.ratingStarView];
        [self.ratingStarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.userLabel.mas_bottom).offset(4);
            make.height.equalTo(@12);
            make.width.equalTo(@60);
        }];
        
        [self.contentView addSubview:self.feedback_descLabel];
        [self.feedback_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.top.equalTo(self.ratingStarView.mas_bottom).offset(12);
            make.bottom.equalTo(self.contentView).mas_offset(-8.5);
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
    
    self.userLabel.text = commentModel.user;
    self.feedback_descLabel.text = commentModel.feedback_desc;
    self.feedback_timeLabel.text = commentModel.feedback_time;
    self.ratingStarView.rating = commentModel.rating;
}

- (UILabel *)userLabel{
    if (!_userLabel) {
        _userLabel = UILabel.new;
        _userLabel.textColor = color_neutral_charcoal_light;
        _userLabel.font = [UIFont boldSystemFontOfSize:12];
        _userLabel.textAlignment = NSTextAlignmentLeft;
        _userLabel.text = @"Gwe6293289";
    }
    return _userLabel;
}

- (UILabel *)feedback_timeLabel{
    if (!_feedback_timeLabel) {
        _feedback_timeLabel = UILabel.new;
        _feedback_timeLabel.textColor = color_neutral_charcoal_light;
        _feedback_timeLabel.font = [UIFont boldSystemFontOfSize:12];
        _feedback_timeLabel.textAlignment = NSTextAlignmentRight;
        _feedback_timeLabel.text = @"2018-11-14";
    }
    return _feedback_timeLabel;
}

- (UILabel *)feedback_descLabel{
    if (!_feedback_descLabel) {
        _feedback_descLabel = UILabel.new;
        _feedback_descLabel.textColor = color_neutral_charcoal_medium;
        _feedback_descLabel.font = font_size_body;
        _feedback_descLabel.textAlignment = NSTextAlignmentLeft;
        _feedback_descLabel.text = @"You can use it for daily attendance You can use it for daily attendance.";
        _feedback_descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _feedback_descLabel.numberOfLines = 0;
    }
    return _feedback_descLabel;
}

- (MLRatingStarView *)ratingStarView{
    if (!_ratingStarView) {
        _ratingStarView = [[MLRatingStarView alloc] initWithRating:self.commentModel.rating];
    }
    return _ratingStarView;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = UIView.new;
        _separatorLine.backgroundColor = color_neutral_grey_light;
    }
    return _separatorLine;
}

@end
