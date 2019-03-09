//
//  MLChecklistContainerCell.m
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLChecklistContainerCell.h"
#import "UILabel+MLCategory.h"

@interface MLChecklistContainerCell ()
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *itemsLabel;
/// 选择视图，可以是单选，也可以是多选
@property (strong, nonatomic) UIImageView *selectImageView;
@end

@implementation MLChecklistContainerCell

#pragma mark - LifeCycle
+ (MLChecklistContainerCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MLChecklistContainerCell";
    MLChecklistContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MLChecklistContainerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
            make.height.width.equalTo(@20);
        }];
        
        [self.contentView addSubview:self.selectImageView];
        [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-20);
            make.centerY.equalTo(self.contentView);
            make.height.width.equalTo(@24);
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(20);
            make.right.equalTo(self.selectImageView.mas_left).offset(-8);
            make.top.equalTo(self.contentView).offset(8);
            make.height.equalTo(@21);
        }];
        
        [self.contentView addSubview:self.itemsLabel];
        [self.itemsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(20);
            make.right.equalTo(self.selectImageView.mas_left).offset(-8);
            make.top.equalTo(self.nameLabel.mas_bottom);
            make.height.equalTo(@18);
        }];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)height{
    return 55;
}

#pragma mark - Getters & Setters
- (void)setModel:(MLChecklistContainer *)model{
    _model = model;
    self.iconImageView.image = IMAGE_BY_NAME(model.icon);
    self.nameLabel.text = model.name;
    self.itemsLabel.text = [NSString stringWithFormat:@"items:%ld", (long)model.items];
    
    NSString *imageName;
    if (model.isMultiSelect) {
        if (model.isSelected) {
            imageName = @"ic_check_box_filled";
        }else{
            imageName = @"ic_check_box_blank";
        }
    }else{
        if (model.isSelected) {
            imageName = @"radio_button_filled";
        }else{
            imageName = @"radio_button_blank";
        }
    }
    
    [self.selectImageView setImage:IMAGE_BY_NAME(imageName)];
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithText:@"name" font:font_size_body textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:1];
    }
    return _nameLabel;
}

- (UILabel *)itemsLabel{
    if (!_itemsLabel) {
        _itemsLabel = [UILabel labelWithText:@"items:50" font:font_size_caption textColor:color_neutral_charcoal_medium textAlignment:NSTextAlignmentLeft numberOfLines:1];
    }
    return _itemsLabel;
}

- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
    }
    return _selectImageView;
}
@end
