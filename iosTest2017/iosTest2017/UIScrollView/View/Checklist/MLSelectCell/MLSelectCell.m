//
//  MLSelectCell.m
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLSelectCell.h"
#import "UILabel+MLCategory.h"

@interface MLSelectCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *selectImageView;
@end

@implementation MLSelectCell

#pragma mark - LifeCycle
+ (MLSelectCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MLSelectCell";
    MLSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MLSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.selectImageView];
        [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.width.height.equalTo(@24);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.selectImageView.mas_left).offset(-16);
            make.height.equalTo(@24);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

#pragma mark - Public

#pragma mark - Private
- (void)setImageView{
    NSString *imageName;
    if (self.isMultiSelect) {
        if (self.isSelected) {
            imageName = @"ic_check_box_filled";
        }else{
            imageName = @"ic_check_box_blank";
        }
    }else{
        if (self.isSelected) {
            imageName = @"radio_button_filled";
        }else{
            imageName = @"radio_button_blank";
        }
    }
    
    [self.selectImageView setImage:IMAGE_BY_NAME(imageName)];
}

#pragma mark - Getters & Setters
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self setImageView];
}

- (void)setIsMultiSelect:(BOOL)isMultiSelect{
    _isMultiSelect = isMultiSelect;
    [self setImageView];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"Check Box Items" font:font_size_body textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:1];
    }
    return _titleLabel;
}

- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        [_selectImageView setImage:IMAGE_BY_NAME(@"radio_button_blank")];
    }
    return _selectImageView;
}

@end
