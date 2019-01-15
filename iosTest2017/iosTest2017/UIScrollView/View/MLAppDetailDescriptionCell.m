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
        
        [self.contentView addSubview:self.descriptionContentLabel];
        
        [self.contentView addSubview:self.moreView];
        [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(self.moreView.moreViewWidth));
            make.right.equalTo(self.contentView).offset(-16);
//            make.bottom.equalTo(self.descriptionContentLabel).offset(2);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
            make.height.equalTo(@18);
        }];
        
        [self.contentView addSubview:self.separatorLine];
        [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
        
        [MLAppDetailDescriptionCell cellHeightByCommentModel:self.commentModel];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)cellHeightByCommentModel:(CommentModel *)commentModel{
    CGSize size = [commentModel.feedback_desc sizeForFont:font_size_caption size:CGSizeMake((ScreenWidth - (8 * 2) - (16 * 2)), MAXFLOAT) mode:NSLineBreakByWordWrapping];
    CGFloat lineHeight = font_size_caption.lineHeight;
    CGFloat numberOfLines = size.height / lineHeight;
    CGFloat cellHeight;
    if (commentModel.moreButtonIsSelected) {  // 展示COLLAPSE状态
        // 57为MORE状态时，除描述信息之外的高度；18为展示COLLAPSE按钮的高度；12为COLLAPSE相对描述信息之间的间距
        cellHeight = 57 + size.height + 18 + 12;
    }else{  // 展示MORE状态
        if (numberOfLines > 3) {
            cellHeight = 57 + 3 * lineHeight;
        }else{
            cellHeight = 57 + size.height;
        }
    }
    
    commentModel.cellHeight = cellHeight;
    NSLog(@"%s cellHeight = %f", __func__, cellHeight);
    
    return cellHeight;
}

#pragma mark - MLMoreViewDelegate
- (void)moreViewMoreButtonClicked:(UIButton *)button{
    NSLog(@"%s", __func__);

    [self.moreView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.moreView.moreViewWidth));
    }];
    
//    if (button.isSelected) {
//        [self.moreView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
//        }];
//    }else{
//        [self.moreView mas_updateConstraints:^(MASConstraintMaker *make) {
////            make.bottom.equalTo(self.descriptionContentLabel).offset(2);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
//        }];
//    }
    
    self.commentModel.moreButtonIsSelected = button.isSelected;
//    [MLAppDetailDescriptionCell cellHeightByCommentModel:self.commentModel];
    
    [self.tableView reloadData];
    
}
#pragma mark - Custom Accessors
- (void)setCommentModel:(CommentModel *)commentModel{
    _commentModel = commentModel;
    self.descriptionContentLabel.text = commentModel.feedback_desc;
    
    CGFloat height = [MLAppDetailDescriptionCell cellHeightByCommentModel:commentModel] - 57;
    [self.descriptionContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.descriptionLabel.mas_bottom).offset(8);
        make.height.equalTo(@(height));
    }];
    
    CGSize size = [commentModel.feedback_desc sizeForFont:font_size_caption size:CGSizeMake((ScreenWidth - (8 * 2) - (16 * 2)), MAXFLOAT) mode:NSLineBreakByWordWrapping];
    CGFloat lineHeight = font_size_caption.lineHeight;
    CGFloat numberOfLines = size.height / lineHeight;
    NSLog(@"(self.contentView.width - (16 * 2)) = %f, numberOfLines = %f, lineHeight = %f", (self.contentView.width - (16 * 2)), numberOfLines, lineHeight);
    if (numberOfLines > 3) {
        self.moreView.hidden = NO;
    }else{
        self.moreView.hidden = YES;
    }
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
        _descriptionContentLabel.textColor = color_neutral_charcoal_medium;
        _descriptionContentLabel.font = font_size_caption;
        _descriptionContentLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionContentLabel.numberOfLines = 0;
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
