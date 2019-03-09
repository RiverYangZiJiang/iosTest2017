//
//  MLSingleSelectTitleCell.m
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLSingleSelectTitleCell.h"
#import "UILabel+MLCategory.h"
#import "MLSelectCell.h"
#import "MLTitleView.h"

@interface MLSingleSelectTitleCell ()<UITableViewDelegate, UITableViewDataSource>
/// 标题视图
@property (strong, nonatomic) MLTitleView *titleView;
/// 存放MLSelectCell单元格的表格
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation MLSingleSelectTitleCell

#pragma mark - LifeCycle
+ (MLSingleSelectTitleCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MLSingleSelectTitleCell";
    MLSingleSelectTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MLSingleSelectTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(8);
            make.height.equalTo(@18);
        }];
        
        [self.contentView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.titleView.mas_bottom).offset(4);
            make.bottom.equalTo(self.contentView).offset(-8);
        }];
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)heightForModel:(NSArray<NSString *> *)model;{
    return 30 + 37 * model.count + 8;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.options.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 37;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLSelectCell *cell = [MLSelectCell cellWithTableView:tableView];
    cell.title = self.options[indexPath.row];
    cell.isSelected = [self.options[indexPath.row] isEqualToString:self.selectedOption];
    cell.isMultiSelect = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *selectedOption = self.options[indexPath.row];
    if ([selectedOption isEqualToString:self.selectedOption]) {
        return;
    }
    
    self.selectedOption = selectedOption;

    [tableView reloadData];
}

#pragma mark - Getters & Setters
- (MLTitleView *)titleView{
    if (!_titleView) {
        _titleView = [MLTitleView titleViewWithTitle:@"title" imageType:MLTitleViewImageTypeNone];
    }
    return _titleView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = color_neutral_white;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
