//
//  MLSettingCell.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLSettingCell.h"
#import "UILabel+MLCategory.h"
#import "UIButton+MLCategory.h"

@interface MLSettingCell ()
/// 标题
@property (strong, nonatomic) UILabel *titleLabel;
/// 标题下方的描述信息
@property (strong, nonatomic) UILabel *descLabel;
/// 标题右边的字符串
@property (strong, nonatomic) UILabel *accessoryLabel;
/// 箭头
@property (strong, nonatomic) UIImageView *arrowImageView;
/// 开关视图
@property (strong, nonatomic) UIImageView *switchImageView;
/// 单元格底部的分割线
@property (strong, nonatomic) UIView *separatorLine;
@end

@implementation MLSettingCell

#pragma mark - LifeCycle
+ (MLSettingCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MLSettingCell";
    MLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MLSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        
        [self.contentView addSubview:self.descLabel];
        
        [self.contentView addSubview:self.accessoryLabel];
        
        // 箭头视图
        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@12);
            make.width.equalTo(@12);
        }];
        
        // 开关视图
        [self.contentView addSubview:self.switchImageView];
        [self.switchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@24);
            make.width.equalTo(@40);
        }];
        
        // 分割线
        [self.contentView addSubview:self.separatorLine];
        [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)heightForCellOfModel:(MLSetting *)model{
    if (!model.desc.length) {
        return 48;
    }
    CGFloat descLabelW = ScreenWidth - 16 - 65;
    CGFloat descLabelH = [model.desc heightForFont:font_size_caption width:descLabelW];
    
    return 36.5 + descLabelH + 15.5;
}

#pragma mark - Getters & Setters
- (void)setSetting:(MLSetting *)setting{
    self.titleLabel.text = setting.title;
    CGFloat titleLabelW = [setting.title widthForFont:self.titleLabel.font] + 1;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(13.5);
        make.height.equalTo(@21);
        make.width.equalTo(@(titleLabelW));
    }];
    
    // 描述
    if (setting.desc.length) {
        self.descLabel.text = setting.desc;
        CGFloat descLabelW = ScreenWidth - 16 - 65;
        CGFloat descLabelH = [self.descLabel heightForWidth:descLabelW] + 1;
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
            make.width.equalTo(@(descLabelW));
            make.height.equalTo(@(descLabelH));
        }];
    }
    
    // accessory
    if (setting.accessoryText.length) {
        self.accessoryLabel.text = setting.accessoryText;
        CGFloat accessoryLabelW = [self.accessoryLabel widthForSingleLine] + 1;
        [self.accessoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.mas_left).offset(-4);
            make.centerY.equalTo(self.arrowImageView);
            make.height.equalTo(@18);
            make.width.equalTo(@(accessoryLabelW));
        }];
    }

    if (setting.type == MLSettingCellTypeArrow) {  // 箭头类型
        self.arrowImageView.hidden = NO;
        self.switchImageView.hidden = YES;
    }else{  // 开关类型
        self.arrowImageView.hidden = YES;
        self.switchImageView.hidden = NO;
        if (setting.isOn) {
            [self.switchImageView setImage:IMAGE_BY_NAME(@"switch_on")];
        }else{
            [self.switchImageView setImage:IMAGE_BY_NAME(@"switch_off")];
        }
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"Latest Version" font:font_size_body textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:1];
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel labelWithText:@"Latest Version" font:font_size_caption textColor:color_functional_b5c1d1 textAlignment:NSTextAlignmentLeft numberOfLines:0];
    }
    return _descLabel;
}

- (UILabel *)accessoryLabel{
    if (!_accessoryLabel) {
        _accessoryLabel = [UILabel labelWithText:@"Latest Version" font:font_size_caption textColor:color_neutral_charcoal_medium textAlignment:NSTextAlignmentRight numberOfLines:1];
    }
    return _accessoryLabel;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:IMAGE_BY_NAME(@"rectangle")];
    }
    return _arrowImageView;
}

- (UIImageView *)switchImageView{
    if (!_switchImageView) {
        _switchImageView = [UIImageView new];
    }
    return _switchImageView;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = UIView.new;
        _separatorLine.backgroundColor = color_neutral_grey;
    }
    return _separatorLine;
}
@end
