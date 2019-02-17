//
//  MLAboutViewController.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAboutViewController.h"
#import "UILabel+MLCategory.h"
#import "MLAboutCell.h"
#import "MLVersionHistoryViewController.h"

@interface MLAboutViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *aboutArray;
@end

@implementation MLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aboutArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLAboutCell *cell = [MLAboutCell cellWithTableView:tableView];
    cell.about = self.aboutArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MLAbout *about = self.aboutArray[indexPath.row];
    about.block();
}

#pragma mark - Getters & Setters
- (NSArray *)aboutArray{
    if (!_aboutArray) {
        MLAbout *about1 = [MLAbout aboutWithType:MLAboutCellTypeLatestVersion title:@"Latest version" version:@"2.4.0" block:^{
            NSLog(@"Latest version");
        }];
        MLAbout *about2 = [MLAbout aboutWithType:MLAboutCellTypeArrow title:@"Version history" version:@"" block:^{
            [self.navigationController pushViewController:[[MLVersionHistoryViewController alloc] init] animated:YES];
        }];
        MLAbout *about3 = [MLAbout aboutWithType:MLAboutCellTypeArrow title:@"Legal provisions" version:@"2.4.0" block:^{
            NSLog(@"Legal provisions");
        }];
        _aboutArray = @[about1, about2, about3];
    }
    return _aboutArray;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = color_neutral_grey_lighter;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 129.5)];
        headerView.backgroundColor = color_neutral_grey_lighter;
        _tableView.tableHeaderView = headerView;
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 113)];
        whiteView.backgroundColor = color_neutral_white;
        [headerView addSubview:whiteView];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 26.5, 60, 60)];
        iconImageView.image = IMAGE_BY_NAME(@"logo");
        [whiteView addSubview:iconImageView];
        
        UILabel *appNameLabel = [UILabel labelWithText:@"MATELINE" font:font_size_h1_title textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [whiteView addSubview:appNameLabel];
        [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_right).offset(12);
            make.top.equalTo(whiteView).offset(22.5);
            make.width.equalTo(@150);
            make.height.equalTo(@23.5);
        }];
 
        UILabel *appVersionLabel = [UILabel labelWithText:@"V2.3.0" font:font_size_15 textColor:color_neutral_charcoal_dark textAlignment:NSTextAlignmentLeft numberOfLines:1];
        [whiteView addSubview:appVersionLabel];
        [appVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(appNameLabel);
            make.top.equalTo(appNameLabel.mas_bottom).offset(4);
            make.width.equalTo(@120);
            make.height.equalTo(@17.5);
        }];
        
        UIImageView *qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 26.5, 60, 60)];
        qrImageView.image = IMAGE_BY_NAME(@"logo");
        [whiteView addSubview:qrImageView];
        [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(whiteView).offset(-16);
            make.top.equalTo(whiteView).offset(16);
            make.width.equalTo(@80.5);
        }];
        
    }
    return _tableView;
}

@end
