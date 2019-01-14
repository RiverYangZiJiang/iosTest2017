//
//  MLAppDetailPreviewCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailPreviewCell.h"
#import "MLRatingStarView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MLAppDetailPreviewCell ()
/// Preview
@property (strong, nonatomic) UILabel *previewLabel;

/// 用来显示多张截图的scrollView
@property (strong, nonatomic) UIScrollView *scrollView;

/// 分割线
@property (strong, nonatomic) UIView *separatorLine;

@end

@implementation MLAppDetailPreviewCell

+ (MLAppDetailPreviewCell *)cellWithTableView:(UITableView *)tableView{
    MLAppDetailPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLAppDetailPreviewCell"];
    if (!cell) {
        cell = [[MLAppDetailPreviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MLAppDetailPreviewCell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 3.Preview
        [self.contentView addSubview:self.previewLabel];
        [self.previewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.contentView).offset(16);
            make.height.equalTo(@21);
        }];
        
        [self.contentView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.previewLabel.mas_bottom).offset(6.5);
            make.height.equalTo(@285);
        }];
        
        NSArray *imageNames = @[@"SpeedTest1", @"SpeedTest2", @"SpeedTest1"];
        [imageNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = UIImageView.new;
            imageView.frame = CGRectMake(16 + idx * (160 + 12), 0, 160, 285);
            [imageView sd_setImageWithURL:nil placeholderImage:IMAGE_BY_NAME(imageNames[idx])];
            [self.scrollView addSubview:imageView];
        }];
        self.scrollView.contentSize = CGSizeMake(16 + imageNames.count * (160 + 12), 285);
        
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

- (UILabel *)previewLabel{
    if (!_previewLabel) {
        _previewLabel = UILabel.new;
        _previewLabel.textColor = [UIColor colorWithHexString:@"485465"];
        _previewLabel.font = [UIFont boldSystemFontOfSize:16];
        _previewLabel.textAlignment = NSTextAlignmentLeft;
        _previewLabel.text = @"Preview";
    }
    return _previewLabel;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = UIView.new;
        _separatorLine.backgroundColor = color_neutral_grey_light;
    }
    return _separatorLine;
}

@end
