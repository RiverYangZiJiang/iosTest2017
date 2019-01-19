//
//  MLAppDetailUpgradeInfoCell.m
//  iosTest2017
//
//  Created by 杨子江 on 1/19/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailUpgradeInfoCell.h"
@interface MLAppDetailUpgradeInfoCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@end

@implementation MLAppDetailUpgradeInfoCell

+ (MLAppDetailUpgradeInfoCell *)cellForTableView:(UITableView *)tableView{
    MLAppDetailUpgradeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLAppDetailUpgradeInfoCell"];
    if (!cell) {
        cell = [[MLAppDetailUpgradeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MLAppDetailUpgradeInfoCell"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-16);
            make.height.equalTo(@18);
            make.width.equalTo(@92.5);
        }];
  
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.timeLabel.mas_left);
            make.height.equalTo(@18);
        }];

        [self.contentView addSubview:self.descriptionLabel];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)cellHeightByUpgradeInfo:(MLAppDetailUpgradeInfo *)upgradeInfo{
    CGSize size = [upgradeInfo.descriptionInfo sizeForFont:font_size_bold_12 size:CGSizeMake(ScreenWidth - (8 * 2) - (16 * 2), MAXFLOAT) mode:NSLineBreakByWordWrapping];
    CGFloat height = 18 + 4 + size.height + 8;
    NSLog(@"%s height = %f", __func__, height);
    return height;
}

#pragma mark - Custom Accessors
- (void)setUpgradeInfo:(MLAppDetailUpgradeInfo *)upgradeInfo{
    _upgradeInfo = upgradeInfo;
    
    self.titleLabel.text = upgradeInfo.title;
    self.timeLabel.text = upgradeInfo.time;
    self.descriptionLabel.text = upgradeInfo.descriptionInfo;
    
    CGSize size = [upgradeInfo.descriptionInfo sizeForFont:self.descriptionLabel.font size:CGSizeMake(ScreenWidth - (8 * 2) - (16 * 2), MAXFLOAT) mode:NSLineBreakByWordWrapping];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.height.equalTo(@(size.height));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.textColor = color_functional_1c2b4d;
        _titleLabel.font = font_size_bold_12;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = UILabel.new;
        _timeLabel.textColor = color_functional_78849c;
        _timeLabel.font = font_size_caption;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)descriptionLabel{
    if (!_descriptionLabel) {
        _descriptionLabel = UILabel.new;
        _descriptionLabel.textColor = color_functional_53627c;
        _descriptionLabel.font = font_size_bold_12;
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionLabel.numberOfLines = 0;
    }
    return _descriptionLabel;
}


@end
