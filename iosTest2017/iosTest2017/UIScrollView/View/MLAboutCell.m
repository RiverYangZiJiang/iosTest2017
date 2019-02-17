//
//  MLAboutCell.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAboutCell.h"
#import "UILabel+MLCategory.h"

@interface MLAboutCell ()
/// 标题
@property (strong, nonatomic) UILabel *titleLabel;
/// 显示最新版本的视图
@property (strong, nonatomic) UIView *latestVersionView;
/// 版本
@property (strong, nonatomic) UILabel *versionLabel;
/// 箭头视图
@property (strong, nonatomic) UIImageView *arrowImageView;
/// 单元格底部的分割线
@property (strong, nonatomic) UIView *separatorLine;
@end

@implementation MLAboutCell

#pragma mark - LifeCycle
+ (MLAboutCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MLAboutCell";
    MLAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MLAboutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(16, 16, 160, 16.5);
        
        // 最新版本
        [self.contentView addSubview:self.latestVersionView];
        [self.latestVersionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@14);
            make.width.equalTo(@120);
        }];
        
        // 箭头视图
        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@12);
            make.width.equalTo(@12);
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

#pragma mark - Getters & Setters
- (void)setAbout:(MLAbout *)about{
    self.titleLabel.text = about.title;
    
    if (about.type == MLAboutCellTypeArrow) {
        self.arrowImageView.hidden = NO;
        self.latestVersionView.hidden = YES;
    }else{
        self.arrowImageView.hidden = YES;
        if (about.version.length) {
            self.latestVersionView.hidden = NO;
        }else{
            self.latestVersionView.hidden = YES;
        }
    }
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"Latest Version" font:font_size_body textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:1];
    }
    return _titleLabel;
}

- (UIView *)latestVersionView{
    if (!_latestVersionView) {
        _latestVersionView = UIView.new;
        
        UIView *redDotView = UIView.new;
        redDotView.layer.cornerRadius = 4;
        redDotView.layer.masksToBounds = YES;
        redDotView.backgroundColor = color_functional_red;
        
        [_latestVersionView addSubview:redDotView];
        [redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.equalTo(_latestVersionView);
            make.width.height.equalTo(@8);
        }];
        
        UILabel *versionLabel = [UILabel labelWithText:@"V2.4.0" font:font_size_caption textColor:color_neutral_charcoal_medium textAlignment:NSTextAlignmentRight numberOfLines:1];
        [_latestVersionView addSubview:versionLabel];
        self.versionLabel = versionLabel;
        
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(redDotView.mas_left).offset(-4);
            make.centerY.equalTo(_latestVersionView);
            make.height.equalTo(@14);
            make.width.equalTo(@100);
        }];
    }
    return _latestVersionView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:IMAGE_BY_NAME(@"rectangle")];
    }
    return _arrowImageView;
}

- (UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine = UIView.new;
        _separatorLine.backgroundColor = color_neutral_grey;
    }
    return _separatorLine;
}
@end
