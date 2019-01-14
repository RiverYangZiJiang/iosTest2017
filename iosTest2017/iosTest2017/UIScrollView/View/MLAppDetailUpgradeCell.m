//
//  MLAppDetailUpgradeCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailUpgradeCell.h"
#import "MLRatingStarView.h"

@interface MLAppDetailUpgradeCell ()
/// Upgrade
@property (strong, nonatomic) UILabel *upgradeLabel;

@end

@implementation MLAppDetailUpgradeCell

+ (MLAppDetailUpgradeCell *)cellWithTableView:(UITableView *)tableView{
    MLAppDetailUpgradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLAppDetailUpgradeCell"];
    if (!cell) {
        cell = [[MLAppDetailUpgradeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MLAppDetailUpgradeCell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.upgradeLabel];
        [self.upgradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.contentView).offset(16);
            make.height.equalTo(@21);
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

- (UILabel *)upgradeLabel{
    if (!_upgradeLabel) {
        _upgradeLabel = UILabel.new;
        _upgradeLabel.textColor = [UIColor colorWithHexString:@"485465"];
        _upgradeLabel.font = [UIFont boldSystemFontOfSize:16];
        _upgradeLabel.textAlignment = NSTextAlignmentLeft;
        _upgradeLabel.text = @"Upgrade";
    }
    return _upgradeLabel;
}

@end
