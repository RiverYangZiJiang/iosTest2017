//
//  UIScrollViewTestVC.m
//  iosTest2017
//
//  Created by 杨子江 on 1/13/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UIScrollViewTestVC.h"
#import <Masonry/Masonry.h>

@interface UIScrollViewTestVC ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *middleView;
@property (strong, nonatomic) UIView *bottomView;

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) UIView *starView;
@property (strong, nonatomic) UIImageView *starImageView1;
@property (strong, nonatomic) UIImageView *starImageView2;
@property (strong, nonatomic) UIImageView *starImageView3;
@property (strong, nonatomic) UIImageView *starImageView4;
@property (strong, nonatomic) UIImageView *starImageView5;
@property (strong, nonatomic) UIImageView *downloadImageView;
@property (strong, nonatomic) UILabel *downloadTimesLabel;
@property (strong, nonatomic) UIImageView *typeImageView;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UIButton *uninstallButton;
/// 行动按钮，是下载按钮、打开按钮、升级按钮、失败按钮中的一种，并且会随着App状态不同而变化
@property (strong, nonatomic) UIButton *actiondButton;

/// 介绍按钮
@property (strong, nonatomic) UIButton *introductionButton;
/// 介绍按钮下的横线
@property (strong, nonatomic) UIView *introductionButtonLine;
/// 评论按钮
@property (strong, nonatomic) UIButton *commentsButton;
/// 评论按钮下的横线
@property (strong, nonatomic) UIView *commentsButtonLine;

/// 介绍
@property (strong, nonatomic) UILabel *introductionLabel;
/// 版本
@property (strong, nonatomic) UILabel *versionLabel;
@property (strong, nonatomic) UILabel *versionContentLabel;
@property (strong, nonatomic) UILabel *releasedOnLabel;
@property (strong, nonatomic) UILabel *releasedOnContentLabel;
@property (strong, nonatomic) UILabel *developerLabel;
@property (strong, nonatomic) UILabel *developerContentLabel;
@property (strong, nonatomic) UIView *introductionLine;

/// 描述
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *descriptionContentLabel;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIView *descriptionLine;

/// Preview
@property (strong, nonatomic) UILabel *previewLabel;
@property (strong, nonatomic) UIImageView *previweImageView1;
@property (strong, nonatomic) UIImageView *previweImageView2;
@property (strong, nonatomic) UILabel *previewLine;

/// Upgrade
@property (strong, nonatomic) UILabel *upgradeLabel;
@end

@implementation UIScrollViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}
- (void)setupView{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.bottom.equalTo(self.view);
    }];
    
    UIView *contentView = UIView.new;
    contentView.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);  // 必须加上这句，否则scrollView的子控制器没法显示
    }];
    
    [contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.equalTo(@130);
    }];
    [self setupTopView];
    
    [contentView addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@40);
    }];
    [self setupMiddleView];
    
    [contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@883.5);
    }];
    [self setupBottomView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
}

- (void)setupTopView{
    self.iconImageView = UIImageView.new;
    self.iconImageView.image = [UIImage imageNamed:@"ic_star_big"];
    [self.topView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.topView).offset(24);
        make.height.width.equalTo(@48);
    }];
    
    [self.topView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(24);
        make.right.equalTo(self.topView);
        make.top.equalTo(self.topView).offset(20);
        make.height.equalTo(@24);
    }];
    
    [self.topView addSubview:self.starView];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.width.equalTo(@60);
        make.height.equalTo(@12);
    }];
    
    [self.topView addSubview:self.downloadImageView];
    [self.downloadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starView.mas_right).offset(16);
        make.centerY.equalTo(self.starView);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    
    [self.topView addSubview:self.downloadTimesLabel];
    [self.downloadTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downloadImageView.mas_right).offset(2);
        make.centerY.equalTo(self.starView);
        make.width.equalTo(@40);
        make.height.equalTo(@18);
    }];
    
    [self.topView addSubview:self.typeImageView];
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.downloadTimesLabel.mas_right).offset(7.5);
        make.centerY.equalTo(self.starView);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    
    [self.topView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImageView.mas_right).offset(2);
        make.centerY.equalTo(self.starView);
        make.right.equalTo(self.topView);
        make.height.equalTo(@18);
    }];
    
}

- (void)setupMiddleView{
    [self.middleView addSubview:self.introductionButton];
    [self.introductionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView).offset(25);
        make.top.equalTo(self.middleView).offset(8);
        make.height.equalTo(@24);
        make.right.equalTo(self.middleView.mas_centerX);
    }];
    
    [self.middleView addSubview:self.commentsButton];
    [self.commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleView.mas_centerX);
        make.right.equalTo(self.middleView).offset(-25);
        make.top.equalTo(self.middleView).offset(8);
        make.height.equalTo(@24);
    }];
    
    [self.middleView addSubview:self.introductionButtonLine];
    [self.introductionButtonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.introductionButton.mas_centerX);
        make.bottom.equalTo(self.middleView);
#warning 宽度要等于按钮文字宽度
        make.width.equalTo(@87);
        make.height.equalTo(@2);
    }];
    
    [self.middleView addSubview:self.commentsButtonLine];
    [self.commentsButtonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.commentsButton.mas_centerX);
        make.bottom.equalTo(self.middleView);
#warning 宽度要等于按钮文字宽度
        make.width.equalTo(@87);
        make.height.equalTo(@2);
    }];
}

- (void)setupBottomView{
    // 1.介绍Introduction
    [self.bottomView addSubview:self.introductionLabel];
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(16);
        make.right.equalTo(self.bottomView).offset(0);
        make.top.equalTo(self.bottomView).offset(16);
        make.height.equalTo(@21);
    }];
    
    [self.bottomView addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(16);
        make.width.equalTo(@90);
        make.top.equalTo(self.introductionLabel.mas_bottom).offset(8);
        make.height.equalTo(@18);
    }];
    
    [self.bottomView addSubview:self.versionContentLabel];
    [self.versionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.versionLabel.mas_right).offset(22);
        make.right.equalTo(self.bottomView);
        make.top.equalTo(self.versionLabel);
        make.height.equalTo(self.versionLabel);
    }];
    
    [self.bottomView addSubview:self.releasedOnLabel];
    [self.releasedOnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.versionLabel);
        make.width.equalTo(@90);
        make.top.equalTo(self.versionLabel.mas_bottom).offset(8);
        make.height.equalTo(@21);
    }];
    
    [self.bottomView addSubview:self.releasedOnContentLabel];
    [self.releasedOnContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.releasedOnLabel.mas_right).offset(22);
        make.right.equalTo(self.bottomView);
        make.top.equalTo(self.releasedOnLabel);
        make.height.equalTo(self.releasedOnLabel);
    }];
    
    [self.bottomView addSubview:self.developerLabel];
    [self.developerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.versionLabel);
        make.width.equalTo(@90);
        make.top.equalTo(self.releasedOnLabel.mas_bottom).offset(8);
        make.height.equalTo(@21);
    }];
    
    [self.bottomView addSubview:self.developerContentLabel];
    [self.developerContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.developerLabel.mas_right).offset(22);
        make.right.equalTo(self.bottomView);
        make.top.equalTo(self.developerLabel);
        make.height.equalTo(self.developerLabel);
    }];
    
    [self.bottomView addSubview:self.introductionLine];
    [self.introductionLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(16);
        make.right.equalTo(self.bottomView).offset(-16);
        make.top.equalTo(self.developerLabel.mas_bottom).offset(11.5);
        make.height.equalTo(@0.5);
    }];
    
    // 2.描述Description
    [self.bottomView addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(16);
        make.right.equalTo(self.bottomView).offset(0);
        make.top.equalTo(self.introductionLine).offset(16);
        make.height.equalTo(@21);
    }];
    
    CGFloat descriptionContentLabelHeight = [self.descriptionContentLabel.text heightForFont:self.descriptionContentLabel.font width:(self.view.width - (8 * 2) - (16 * 2))];
    CGFloat lineHeight = self.descriptionContentLabel.font.lineHeight;
    [self.bottomView addSubview:self.descriptionContentLabel];
    CGFloat numberOfLines = descriptionContentLabelHeight / lineHeight;
    [self.descriptionContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(16);
        make.right.equalTo(self.bottomView).offset(-16);
        make.top.equalTo(self.descriptionLabel.mas_bottom).offset(8);
        if (numberOfLines > 3) {
            make.height.equalTo(@(3 * lineHeight));
        }else{
            make.height.equalTo(@(numberOfLines * lineHeight));
        }
    }];
    
    NSLog(@"(self.bottomView.width - (16 * 2)) = %f, numberOfLines = %f, descriptionContentLabelHeight = %f, lineHeight = %f", (self.bottomView.width - (16 * 2)), numberOfLines, descriptionContentLabelHeight, lineHeight);
    if (numberOfLines > 3) {
        self.descriptionContentLabel.numberOfLines = 3;
        CGSize moreButtonSize = [@"MORE" sizeForFont:self.moreButton.titleLabel.font size:CGSizeMake(self.bottomView.bounds.size.width - 16 * 2, MAXFLOAT) mode:NSLineBreakByCharWrapping];
        [self.bottomView addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(moreButtonSize.width));
            make.right.equalTo(self.bottomView).offset(-16);
            make.bottom.equalTo(self.descriptionContentLabel.mas_bottom);
            make.height.equalTo(@18);
        }];
    }else{
        self.descriptionContentLabel.numberOfLines = numberOfLines;
    }
    
    [self.bottomView addSubview:self.descriptionLine];
    [self.descriptionLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(16);
        make.right.equalTo(self.bottomView).offset(-16);
        make.top.equalTo(self.descriptionContentLabel.mas_bottom).offset(12);
        make.height.equalTo(@0.5);
    }];

    // 3.Preview
    [self.bottomView addSubview:self.previewLabel];
    [self.previewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(16);
        make.right.equalTo(self.bottomView).offset(0);
        make.top.equalTo(self.descriptionLine).offset(16);
        make.height.equalTo(@21);
    }];
}

#pragma mark - Selectors
- (void)introductionButtonClidked:(UIButton *)button{
    NSLog(@"%s", __func__);
    if (button.isSelected) {
        return;
    }
    
    button.selected = YES;
    self.introductionButtonLine.hidden = NO;
    
    self.commentsButton.selected = NO;
    self.commentsButtonLine.hidden = YES;
}

- (void)commentsButtonClidked:(UIButton *)button{
    NSLog(@"%s", __func__);
    
    if (button.isSelected) {
        return;
    }
    
    button.selected = YES;
    self.commentsButtonLine.hidden = NO;
    
    self.introductionButton.selected = NO;
    self.introductionButtonLine.hidden = YES;
}

- (void)moreButtonClicked:(UIButton *)button{
    NSLog(@"%s", __func__);
}
#pragma mark - Custom Accessors
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = UIView.new;
        _topView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
    return _topView;
}

- (UIView *)middleView{
    if (!_middleView) {
        _middleView = UIView.new;
        _middleView.backgroundColor = [UIColor colorWithHexString:@"eaeef4"];
    }
    return _middleView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = UIView.new;
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
    return _bottomView;
}
#pragma mark -- TopView
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = UILabel.new;
        _nameLabel.textColor = [UIColor colorWithHexString:@"485465"];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"Speed Test";
    }
    return _nameLabel;
}

- (UIView *)starView{
    if (!_starView) {
        _starView = UIView.new;
    }
    return _starView;
}

- (UIImageView *)downloadImageView{
    if (!_downloadImageView) {
        _downloadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_download"]];
    }
    return _downloadImageView;
}

- (UILabel *)downloadTimesLabel{
    if (!_downloadTimesLabel) {
        _downloadTimesLabel = UILabel.new;
        _downloadTimesLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _downloadTimesLabel.font = [UIFont systemFontOfSize:12];
        _downloadTimesLabel.textAlignment = NSTextAlignmentLeft;
        _downloadTimesLabel.text = @"1625";
    }
    return _downloadTimesLabel;
}

- (UIImageView *)typeImageView{
    if (!_typeImageView) {
        _typeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_plugin"]];
    }
    return _typeImageView;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = UILabel.new;
        _typeLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.text = @"PLUGIN";
    }
    return _typeLabel;
}
#pragma mark -- MiddleView
- (UIButton *)introductionButton{
    if (!_introductionButton) {
        _introductionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_introductionButton setTitleColor:[UIColor colorWithHexString:@"53627c"] forState:UIControlStateSelected];
        [_introductionButton setTitleColor:[UIColor colorWithHexString:@"805362"] forState:UIControlStateNormal];
        _introductionButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_introductionButton setTitle:@"Introduction" forState:UIControlStateNormal];
        _introductionButton.selected = YES;
        [_introductionButton addTarget:self action:@selector(introductionButtonClidked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _introductionButton;
}

- (UIView *)introductionButtonLine{
    if (!_introductionButtonLine) {
        _introductionButtonLine = UIView.new;
        _introductionButtonLine.backgroundColor = [UIColor colorWithHexString:@"2daaf3"];
    }
    return _introductionButtonLine;
}

- (UIButton *)commentsButton{
    if (!_commentsButton) {
        _commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentsButton setTitleColor:[UIColor colorWithHexString:@"53627c"] forState:UIControlStateSelected];
        [_commentsButton setTitleColor:[UIColor colorWithHexString:@"805362"] forState:UIControlStateNormal];
        _commentsButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_commentsButton setTitle:@"Comments(34)" forState:UIControlStateNormal];
        _commentsButton.selected = NO;
        [_commentsButton addTarget:self action:@selector(commentsButtonClidked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentsButton;
}

- (UIView *)commentsButtonLine{
    if (!_commentsButtonLine) {
        _commentsButtonLine = UIView.new;
        _commentsButtonLine.backgroundColor = [UIColor colorWithHexString:@"2daaf3"];
        _commentsButtonLine.hidden = YES;
    }
    return _commentsButtonLine;
}

#pragma mark -- BottomView
#pragma mark --- 介绍Introduction
- (UILabel *)introductionLabel{
    if (!_introductionLabel) {
        _introductionLabel = UILabel.new;
        _introductionLabel.textColor = [UIColor colorWithHexString:@"242a34"];
        _introductionLabel.font = [UIFont boldSystemFontOfSize:14];
        _introductionLabel.textAlignment = NSTextAlignmentLeft;
        _introductionLabel.text = @"Introduction";
    }
    return _introductionLabel;
}

- (UILabel *)versionLabel{
    if (!_versionLabel) {
        _versionLabel = UILabel.new;
        _versionLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _versionLabel.font = [UIFont systemFontOfSize:12];
        _versionLabel.textAlignment = NSTextAlignmentLeft;
        _versionLabel.text = @"Version:";
    }
    return _versionLabel;
}

- (UILabel *)versionContentLabel{
    if (!_versionContentLabel) {
        _versionContentLabel = UILabel.new;
        _versionContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _versionContentLabel.font = [UIFont systemFontOfSize:12];
        _versionContentLabel.textAlignment = NSTextAlignmentLeft;
        _versionContentLabel.text = @"7.2.0";
    }
    return _versionContentLabel;
}

- (UILabel *)releasedOnLabel{
    if (!_releasedOnLabel) {
        _releasedOnLabel = UILabel.new;
        _releasedOnLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _releasedOnLabel.font = [UIFont systemFontOfSize:12];
        _releasedOnLabel.textAlignment = NSTextAlignmentLeft;
        _releasedOnLabel.text = @"Released on:";
    }
    return _releasedOnLabel;
}

- (UILabel *)releasedOnContentLabel{
    if (!_releasedOnContentLabel) {
        _releasedOnContentLabel = UILabel.new;
        _releasedOnContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _releasedOnContentLabel.font = [UIFont systemFontOfSize:12];
        _releasedOnContentLabel.textAlignment = NSTextAlignmentLeft;
        _releasedOnContentLabel.text = @"RulePrioritySiteB";
    }
    return _releasedOnContentLabel;
}

- (UILabel *)developerLabel{
    if (!_developerLabel) {
        _developerLabel = UILabel.new;
        _developerLabel.textColor = [UIColor colorWithHexString:@"78849c"];
        _developerLabel.font = [UIFont systemFontOfSize:12];
        _developerLabel.textAlignment = NSTextAlignmentLeft;
        _developerLabel.text = @"Developer:";
    }
    return _developerLabel;
}

- (UILabel *)developerContentLabel{
    if (!_developerContentLabel) {
        _developerContentLabel = UILabel.new;
        _developerContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _developerContentLabel.font = [UIFont systemFontOfSize:12];
        _developerContentLabel.textAlignment = NSTextAlignmentLeft;
        _developerContentLabel.text = @"Gwx601027";
    }
    return _developerContentLabel;
}

- (UIView *)introductionLine{
    if (!_introductionLine) {
        _introductionLine = UIView.new;
        _introductionLine.backgroundColor = [UIColor colorWithHexString:@"e6eaf2"];
    }
    return _introductionLine;
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
        _descriptionContentLabel.textColor = [UIColor colorWithHexString:@"53627c"];
        _descriptionContentLabel.font = [UIFont systemFontOfSize:12];
        _descriptionContentLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionContentLabel.text = @"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet speed through thoug. Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet speed through thoug";
        _descriptionContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionContentLabel.numberOfLines = 3;
    }
    return _descriptionContentLabel;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitleColor:[UIColor colorWithHexString:@"2979ff"] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_moreButton setTitle:@"More" forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIView *)descriptionLine{
    if (!_descriptionLine) {
        _descriptionLine = UIView.new;
        _descriptionLine.backgroundColor = [UIColor colorWithHexString:@"e6eaf2"];
    }
    return _descriptionLine;
}

#pragma mark --- Preview
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
@end
