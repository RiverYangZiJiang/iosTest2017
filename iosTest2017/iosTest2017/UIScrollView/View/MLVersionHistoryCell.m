//
//  MLVersionHistoryCell.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLVersionHistoryCell.h"
#import "UILabel+MLCategory.h"

@interface MLVersionHistoryCell ()
/// 版本
@property (strong, nonatomic) UILabel *versionLabel;
/// 时间
@property (strong, nonatomic) UILabel *timeLabel;
/// 描述
@property (strong, nonatomic) UILabel *descLabel;
@end

@implementation MLVersionHistoryCell
#pragma mark - LifeCycle
+ (MLVersionHistoryCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MLVersionHistoryCell";
    MLVersionHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MLVersionHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = color_neutral_white;
        [self.contentView addSubview:self.versionLabel];
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(12.5);
            make.height.equalTo(@17.5);
            make.width.equalTo(@100);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.centerY.equalTo(self.versionLabel);
            make.height.equalTo(@14);
            make.width.equalTo(@150);
        }];
        
        [self.contentView addSubview:self.descLabel];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)heightForCellOfModel:(MLVersionHistory *)model{
    CGFloat descLabelW = ScreenWidth - 20 - 13;
    CGFloat descLabelH = [model.desc heightForFont:font_size_caption width:descLabelW];
    
    return 45 + descLabelH + 20;
}

#pragma mark - Getters & Setters
- (void)setVersionHistory:(MLVersionHistory *)versionHistory{
    _versionHistory = versionHistory;
    
    self.versionLabel.text = versionHistory.version;
    self.timeLabel.text = versionHistory.time;
    self.descLabel.text = versionHistory.desc;
    
    CGFloat descLabelW = ScreenWidth - 20 - 13;
    CGFloat descLabelH = [self.descLabel heightForWidth:descLabelW];
    [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-13);
        make.top.equalTo(self.versionLabel.mas_bottom).offset(15);
        make.height.equalTo(@(descLabelH));
    }];
}

- (UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [UILabel labelWithText:@"V2.3.0" font:font_size_15 textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:0];
    }
    return _versionLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithText:@"2018-12-12" font:font_size_caption textColor:color_functional_b5c1d1 textAlignment:NSTextAlignmentRight numberOfLines:0];
    }
    return _timeLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel labelWithText:@"-Experience optimization and bug fixes" font:font_size_caption textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:0];
    }
    return _descLabel;
}

@end
