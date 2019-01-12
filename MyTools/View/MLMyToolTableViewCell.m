//
//  MLMyToolTableViewCell.m
//  Mateline
//
//  Created by yangzijiang on 2019/1/10.
//

#import "MLMyToolTableViewCell.h"
static NSString * const MLMyToolTableViewCellID = @"MLMyToolTableViewCellID";
@interface MLMyToolTableViewCell ()
/// Icon图片
@property (strong, nonatomic) UIImageView *iconImageView;
/// Icon图片右上角红点
@property (strong, nonatomic) UIView *redDot;
/// 名称，如Speed Test
@property (strong, nonatomic) UILabel *nameLabel;
/// 版本号，如5.2.0
@property (strong, nonatomic) UILabel *versionLabel;
/// 大小，如25M
@property (strong, nonatomic) UILabel *sizeLabel;
/// 类型图片
@property (strong, nonatomic) UIImageView *typeImageView;
/// 类型，如PLUGIN、APP
@property (strong, nonatomic) UILabel *typeLabel;
/// 动作按钮，如下载、更新
@property (strong, nonatomic) UIButton *actinButon;
/// 描述
@property (strong, nonatomic) UILabel *descriptionLabel;
/// 更多按钮，点击会展开描述信息
@property (strong, nonatomic) UIButton *moreButon;


@end
@implementation MLMyToolTableViewCell

+ (MLMyToolTableViewCell *)cellWithTableView:(UITableView *)tableView{
    
    MLMyToolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MLMyToolTableViewCellID];
    if (!cell) {
        cell = [[MLMyToolTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MLMyToolTableViewCellID];
    };
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(20);
            make.height.width.equalTo(@40);
        }];
        
        [self.contentView addSubview:self.redDot];
        [self.redDot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.iconImageView);
            make.height.width.equalTo(@11);
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(72);
            make.top.equalTo(self.contentView).offset(16);
            make.height.equalTo(@24);
            make.width.equalTo(@136);
        }];
        
        [self.contentView addSubview:self.versionLabel];
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
            make.height.equalTo(@18);
            make.width.equalTo(@40);
        }];
        
        [self.contentView addSubview:self.sizeLabel];
        [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionLabel.mas_right).offset(4);
            make.centerY.equalTo(self.versionLabel);
            make.height.equalTo(@18);
            make.width.equalTo(@40);
        }];

        [self.contentView addSubview:self.typeImageView];
        [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sizeLabel.mas_right).offset(4);
            make.centerY.equalTo(self.versionLabel);
            make.height.equalTo(@16);
            make.width.equalTo(@16);
        }];

        [self.contentView addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeImageView.mas_right).offset(4);
            make.centerY.equalTo(self.versionLabel);
            make.height.equalTo(@18);
            make.width.equalTo(@120);
        }];

        [self.contentView addSubview:self.actinButon];
        [self.actinButon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.top.equalTo(self.contentView).offset(20);
            make.height.equalTo(@24);
            make.width.equalTo(@96);
        }];

        [self.contentView addSubview:self.descriptionLabel];
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.versionLabel.mas_bottom).offset(8);
            make.height.equalTo(@56);
            make.right.equalTo(self.contentView).offset(-16);
        }];

        [self.contentView addSubview:self.moreButon];
        [self.moreButon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-15.5);
            make.height.equalTo(@59);
            make.width.equalTo(@17.5);
            make.right.equalTo(self.contentView).offset(-16);
        }];
        
    }
    return self;
}

#pragma mark - Public
/**
 单元格高度
 
 @return 单元格高度
 */
- (CGFloat)cellHeight{
    if (self.moreButon.hidden) {
        return 146;
    }else{
        return 146;
    }
}

#pragma mark - Selectors
- (void)actinButonClicked:(UIButton *)button{
    MLDDLogInfo(@"");
}

- (void)moreButonClicked:(UIButton *)button{
    MLDDLogInfo(@"");
}

#pragma mark - Custom Accessors
- (void)setAppItem:(DiscoverAppItem *)appItem{
    _appItem = appItem;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:appItem.iconUrl] placeholderImage:IMAGE_BY_NAME(@"ic_checkin_oval")];
    self.nameLabel.text = appItem.getDisplayName;
    self.versionLabel.text = appItem.version;
    self.sizeLabel.text = appItem.size;
    [self.typeImageView setImage:IMAGE_BY_NAME(@"ic_plugin")];
    self.typeLabel.text = appItem.type;
    self.descriptionLabel.text = appItem.appDesc;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UIView *)redDot{
    if (!_redDot) {
        _redDot = [[UIView alloc] init];
        _redDot.backgroundColor = color_neutral_white;
        _redDot.layer.cornerRadius = 5.5;
        _redDot.layer.masksToBounds = YES;
        
        UIView *redDotInner = [[UIView alloc] init];
        redDotInner.backgroundColor = color_functional_red2;
        redDotInner.layer.cornerRadius = 3.5;
        redDotInner.layer.masksToBounds = YES;
        
        [_redDot addSubview:redDotInner];
    }
    return _redDot;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = color_functional_485465;
        _nameLabel.font = font_size_bold_16;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.textColor = color_neutral_charcoal_light;
        _versionLabel.font = font_size_caption;
        _versionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _versionLabel;
}

- (UILabel *)sizeLabel{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.textColor = color_neutral_charcoal_light;
        _sizeLabel.font = font_size_caption;
        _sizeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sizeLabel;
}

- (UIImageView *)typeImageView{
    if (!_typeImageView) {
        _typeImageView = [[UIImageView alloc] init];
    }
    return _typeImageView;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = color_neutral_charcoal_light;
        _typeLabel.font = font_size_caption;
        _typeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _typeLabel;
}

- (UIButton *)actinButon{
    if (!_actinButon) {
        _actinButon = [UIButton buttonWithType:UIButtonTypeCustom];
        _actinButon.layer.cornerRadius = 12;
        _actinButon.layer.masksToBounds = YES;
        [_actinButon setTitle:@"DOWNLOAD" forState:UIControlStateNormal];
        [_actinButon setTitleColor:color_brand_primary forState:UIControlStateNormal];
        _actinButon.titleLabel.font = font_size_bold_14;
        _actinButon.layer.borderWidth = 0.5;
        _actinButon.layer.borderColor = color_brand_primary.CGColor;
        
        [_actinButon addTarget:self action:@selector(actinButonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actinButon;
}

- (UILabel *)descriptionLabel{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textColor = color_neutral_charcoal_light;
        _descriptionLabel.font = font_size_caption;
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        // 默认最多显示3行
        _descriptionLabel.numberOfLines = 3;
    }
    return _descriptionLabel;
}

- (UIButton *)moreButon{
    if (!_moreButon) {
        _moreButon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButon setTitle:@"MORE" forState:UIControlStateNormal];
        [_moreButon setTitleColor:color_functional_blue_dark forState:UIControlStateNormal];
        _moreButon.titleLabel.font = font_bold_size_caption;
        [_moreButon addTarget:self action:@selector(moreButonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _moreButon.hidden = YES;  // 更多按钮默认隐藏
    }
    return _moreButon;
}
@end
