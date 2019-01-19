//
//  MLAppDetailUpgradeCell.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailUpgradeCell.h"
#import "MLRatingStarView.h"
#import "MLAppDetailUpgradeInfoCell.h"

@interface MLAppDetailUpgradeCell ()<UITableViewDelegate, UITableViewDataSource>
/// Upgrade
@property (strong, nonatomic) UILabel *upgradeLabel;
@property (strong, nonatomic) UITableView *tableView;
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
        
        [self.contentView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.upgradeLabel.mas_bottom).offset(8);
        }];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)cellHeightByUpgradeInfoArray:(NSArray<MLAppDetailUpgradeInfo *> *)upgradeInfoArray{
    __block CGFloat height = 0.0f;
    [upgradeInfoArray enumerateObjectsUsingBlock:^(MLAppDetailUpgradeInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        height += [MLAppDetailUpgradeInfoCell cellHeightByUpgradeInfo:obj];
    }];
    height = height + 16 + 21 + 8;
    NSLog(@"%s height = %f", __func__, height);
    return height;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.upgradeInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLAppDetailUpgradeInfo *info = self.upgradeInfoArray[indexPath.row];
    return [MLAppDetailUpgradeInfoCell cellHeightByUpgradeInfo:info];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLAppDetailUpgradeInfo *info = self.upgradeInfoArray[indexPath.row];
    MLAppDetailUpgradeInfoCell *cell = [MLAppDetailUpgradeInfoCell cellForTableView:tableView];
    cell.upgradeInfo = info;
    return cell;
}
#pragma mark - Custom Accessors
- (void)setUpgradeInfoArray:(NSArray<MLAppDetailUpgradeInfo *> *)upgradeInfoArray{
    _upgradeInfoArray = upgradeInfoArray;
    
    [self.tableView reloadData];
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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = color_neutral_grey_lighter;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
@end
