//
//  MLAppDetailDescriptionCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailDescriptionCell.h"
#import "MLRatingStarView.h"
#import "MLMoreView.h"

@interface MLAppDetailDescriptionCell ()<MLMoreViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

/// 描述
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *descriptionContentLabel;
@property (strong, nonatomic) MLMoreView *moreView;


/// 分割线
@property (strong, nonatomic) UIView *separatorLine;

@end

@implementation MLAppDetailDescriptionCell

+ (MLAppDetailDescriptionCell *)cellWithTableView:(UITableView *)tableView{
    MLAppDetailDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLAppDetailDescriptionCell"];
    if (!cell) {
        cell = [[MLAppDetailDescriptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MLAppDetailDescriptionCell"];
        cell.tableView = tableView;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 2.描述Description
        [self.contentView addSubview:self.descriptionLabel];
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.contentView).offset(16);
            make.height.equalTo(@21);
        }];
        
        CGFloat descriptionContentLabelHeight = [self.descriptionContentLabel.text heightForFont:self.descriptionContentLabel.font width:(ScreenWidth - (8 * 2) - (16 * 2))];
        CGFloat lineHeight = self.descriptionContentLabel.font.lineHeight;
        [self.contentView addSubview:self.descriptionContentLabel];
        CGFloat numberOfLines = descriptionContentLabelHeight / lineHeight;
        [self.descriptionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.top.equalTo(self.descriptionLabel.mas_bottom).offset(8);
            if (numberOfLines > 3) {
                make.height.equalTo(@(3 * lineHeight));
            }else{
                make.height.equalTo(@(numberOfLines * lineHeight));
            }
        }];
        
        NSLog(@"(self.contentView.width - (16 * 2)) = %f, numberOfLines = %f, descriptionContentLabelHeight = %f, lineHeight = %f", (self.contentView.width - (16 * 2)), numberOfLines, descriptionContentLabelHeight, lineHeight);
        if (numberOfLines > 3) {
            self.descriptionContentLabel.numberOfLines = 3;
            [self.contentView addSubview:self.moreView];
            [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(self.moreView.moreViewWidth));
                make.right.equalTo(self.contentView).offset(-16);
                make.bottom.equalTo(self.descriptionContentLabel).offset(2);
                make.height.equalTo(@18);
            }];
        }else{
            self.descriptionContentLabel.numberOfLines = numberOfLines;
        }
        
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

#pragma mark - MLMoreViewDelegate
- (void)moreViewMoreButtonClicked:(UIButton *)button{
    NSLog(@"%s", __func__);

    [self.moreView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.moreView.moreViewWidth));
    }];
    
    [self.tableView reloadData];
    
}
#pragma mark - Custom Accessors
- (void)setCommentModel:(CommentModel *)commentModel{
    _commentModel = commentModel;
}

#pragma mark --- 描述Description
- (UILabel *)descriptionLabel{
    if (!_descriptionLabel) {
        _descriptionLabel = UILabel.new;
        _descriptionLabel.textColor = [UIColor colorWithHexString:@"485465"];
        _descriptionLabel.font = [UIFont boldSystemFontOfSize:16];
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionLabel.text = @"Description";
    }
    return _descriptionLabel;
}

- (UILabel *)descriptionContentLabel{
    if (!_descriptionContentLabel) {
        _descriptionContentLabel = UILabel.new;
        _descriptionContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _descriptionContentLabel.font = [UIFont systemFontOfSize:12];
        _descriptionContentLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionContentLabel.text = @"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet speed through thoug. Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet speed through thoug";
        _descriptionContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionContentLabel.numberOfLines = 3;
    }
    return _descriptionContentLabel;
}

- (MLMoreView *)moreView{
    if (!_moreView) {
        _moreView = [[MLMoreView alloc] init];
        _moreView.delegate = self;
    }
    return _moreView;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = UIView.new;
        _separatorLine.backgroundColor = color_neutral_grey_light;
    }
    return _separatorLine;
}

@end
