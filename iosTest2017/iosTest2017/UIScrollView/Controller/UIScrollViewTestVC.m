//
//  UIScrollViewTestVC.m
//  iosTest2017
//
//  Created by 杨子江 on 1/13/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UIScrollViewTestVC.h"
#import <Masonry/Masonry.h>
#import "MLRatingStarView.h"
#import "MLCommentCell.h"
#import "CommentModel.h"
#import "MLAppDetailUpgradeCell.h"
#import "MLAppDetailPreviewCell.h"
#import "MLAppDetailIntroductionCell.h"
#import "MLAppDetailDescriptionCell.h"
#import "MLAppDetailActionButton.h"

@interface UIScrollViewTestVC ()<UITableViewDelegate, UITableViewDataSource>
/// introduction栏用来容纳其他视图
@property (strong, nonatomic) UIView *blankView;
/// 顶部视图，用来容纳我的工具Icon、名称、星级等
@property (strong, nonatomic) UIView *topView;
/// 中间视图，用来显示Introduction和Comments按钮
@property (strong, nonatomic) UIView *middleView;

@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *nameLabel;
/// 显示星级的视图
@property (strong, nonatomic) MLRatingStarView *starView;
@property (strong, nonatomic) UIImageView *downloadImageView;
@property (strong, nonatomic) UILabel *downloadTimesLabel;
@property (strong, nonatomic) UIImageView *typeImageView;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) MLAppDetailActionButton *uninstallButton;
/// 行动按钮，是下载按钮、打开按钮、升级按钮、失败按钮中的一种，并且会随着App状态不同而变化
@property (strong, nonatomic) MLAppDetailActionButton *actionButton;

/// 介绍按钮
@property (strong, nonatomic) UIButton *introductionButton;
/// 介绍按钮下的横线
@property (strong, nonatomic) UIView *introductionButtonLine;
/// 评论按钮
@property (strong, nonatomic) UIButton *commentsButton;
/// 评论按钮下的横线
@property (strong, nonatomic) UIView *commentsButtonLine;

/// 介绍表格视图
@property (strong, nonatomic) UITableView *introductionTableView;

/// 评论表格视图
@property (strong, nonatomic) UITableView *commentsTableView;
/// 评论数据
@property (strong, nonatomic) NSMutableArray *commentsData;
@end

@implementation UIScrollViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}
- (void)setupView{
    [self.view addSubview:self.blankView];
    [self.blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.bottom.equalTo(self.view);
    }];
    
    [self.blankView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.blankView);
        make.height.equalTo(@130);
    }];
    [self setupTopView];
    
    [self.blankView addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.equalTo(self.blankView);
        make.height.equalTo(@40);
    }];
    [self setupMiddleView];
    
    // 介绍表格视图
    [self.blankView addSubview:self.introductionTableView];
    [self.introductionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.right.equalTo(self.blankView);
        make.bottom.equalTo(self.blankView);
    }];
    
    // 评论表格视图
    [self.blankView addSubview:self.commentsTableView];
    [self.commentsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.right.equalTo(self.blankView);
        make.bottom.equalTo(self.blankView);
    }];
    
    // 必须加上以下代码，否则commentsTableView没法滚动上去
    [self.blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.commentsTableView.mas_bottom);
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
    
    [self.topView addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).offset(-16);
        make.bottom.equalTo(self.topView).offset(-16);
        make.height.equalTo(@24);
        make.width.equalTo(@95.5);
    }];
    
    [self.topView addSubview:self.uninstallButton];
    [self.uninstallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.actionButton.mas_left).offset(-16);
        make.bottom.height.width.equalTo(self.actionButton);
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
    
    self.commentsTableView.hidden = YES;
    self.introductionTableView.hidden = NO;
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
    
    self.commentsTableView.hidden = NO;
    self.introductionTableView.hidden = YES;
    
    // 第一次点击评论按钮时，才刷新表格
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.commentsTableView reloadData];
    });
}

- (void)moreButtonClicked:(UIButton *)button{
    NSLog(@"%s", __func__);
}

- (void)uninstallButtonClicked:(MLAppDetailActionButton *)button{
    NSLog(@"%s", __func__);
}

- (void)actinButtonClicked:(MLAppDetailActionButton *)button{
    NSLog(@"%s", __func__);
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    MLDDLogDebug(@"");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    MLDDLogDebug(@"");
    if (self.introductionTableView.hidden) {  // 评论表格
        return self.commentsData.count;
    }else{  // 介绍表格
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *model = self.commentsData[indexPath.row];
    if (self.introductionTableView.hidden) {  // 评论表格
        if (model.cellHeight == 0) {
            model.cellHeight = [MLCommentCell cellHeightByCommentModel:model];
        }
        
        return model.cellHeight;
    }else{  // 介绍表格
        if (indexPath.row == 0) {  // 介绍
            return 119.5;
        }else if(indexPath.row == 1) {  // 描述
            return 112;
        }else if(indexPath.row == 2) {  // Preview
            return 342;
        }else if(indexPath.row == 3) {  // Upgrade
            return 309;
        }
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.introductionTableView.hidden) {  // 评论表格
        MLCommentCell *cell = [MLCommentCell cellWithTableView:tableView];
        cell.commentModel = self.commentsData[indexPath.row];
        return cell;
    }else{  // 介绍表格
        if (indexPath.row == 0) {  // 介绍
            MLAppDetailIntroductionCell *cell = [MLAppDetailIntroductionCell cellWithTableView:tableView];
            cell.commentModel = self.commentsData[indexPath.row];
            return cell;
        }else if(indexPath.row == 1) {  // 描述
            MLAppDetailDescriptionCell *cell = [MLAppDetailDescriptionCell cellWithTableView:tableView];
            cell.commentModel = self.commentsData[indexPath.row];
            return cell;
        }else if(indexPath.row == 2) {  // Preview
            MLAppDetailPreviewCell *cell = [MLAppDetailPreviewCell cellWithTableView:tableView];
            cell.commentModel = self.commentsData[indexPath.row];
            return cell;
        }else if(indexPath.row == 3) {  // Upgrade
            MLAppDetailUpgradeCell *cell = [MLAppDetailUpgradeCell cellWithTableView:tableView];
            cell.commentModel = self.commentsData[indexPath.row];
            return cell;
        }
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Custom Accessors
- (UIView *)blankView{
    if (!_blankView) {
        _blankView = UIView.new;
        _blankView.backgroundColor = [UIColor redColor];
    }
    return _blankView;
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

- (MLRatingStarView *)starView{
    if (!_starView) {
        _starView = [[MLRatingStarView alloc] initWithRating:@"3"];
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

- (MLAppDetailActionButton *)uninstallButton{
    if (!_uninstallButton) {
        _uninstallButton = [MLAppDetailActionButton buttonWithType:UIButtonTypeCustom actionType:MLAppDetailActionButtonTypeUninstall];
        [_uninstallButton addTarget:self action:@selector(uninstallButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uninstallButton;
}

- (MLAppDetailActionButton *)actionButton{
    if (!_actionButton) {
        _actionButton = [MLAppDetailActionButton buttonWithType:UIButtonTypeCustom actionType:MLAppDetailActionButtonTypeOpen];
        
        [_actionButton addTarget:self action:@selector(actinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
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
#pragma mark --- Introduction
- (UITableView *)introductionTableView{
    if (!_introductionTableView) {
        _introductionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _introductionTableView.backgroundColor = color_neutral_grey_lighter;
        _introductionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _introductionTableView.delegate = self;
        _introductionTableView.dataSource = self;
        _introductionTableView.showsVerticalScrollIndicator = NO;
    }
    return _introductionTableView;
}



#pragma mark --- Comments
- (UITableView *)commentsTableView{
    if (!_commentsTableView) {
        _commentsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _commentsTableView.backgroundColor = color_neutral_grey_lighter;
        _commentsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentsTableView.delegate = self;
        _commentsTableView.dataSource = self;
        _commentsTableView.showsVerticalScrollIndicator = NO;
        _commentsTableView.hidden = YES;
    }
    return _commentsTableView;
}

- (NSMutableArray *)commentsData{
    if (!_commentsData) {
        _commentsData = [CommentModel testData];
    }
    return _commentsData;
}
@end
