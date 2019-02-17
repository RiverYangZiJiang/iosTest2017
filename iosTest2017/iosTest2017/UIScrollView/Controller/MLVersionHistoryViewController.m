//
//  MLVersionHistoryViewController.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLVersionHistoryViewController.h"
#import "MLVersionHistoryCell.h"
#import "MLVersionHistory.h"

@interface MLVersionHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *versionHistoryArray;
@end

@implementation MLVersionHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.versionHistoryArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLVersionHistory *versionHistory = self.versionHistoryArray[indexPath.section];
    if (versionHistory.cellHeight <= 0) {
        versionHistory.cellHeight = [MLVersionHistoryCell heightForCellOfModel:versionHistory];
    }
    
    return versionHistory.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLVersionHistoryCell *cell = [MLVersionHistoryCell cellWithTableView:tableView];
    cell.versionHistory = self.versionHistoryArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = UIView.new;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - Getters & Setters
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

- (NSArray *)versionHistoryArray{
    if (!_versionHistoryArray) {
        MLVersionHistory *h1 = [MLVersionHistory versionHistoryWith:@"V2.3.0" time:@"2019.1.1" desc:@"-Experience optimization and bug fixes"];
        MLVersionHistory *h2 = [MLVersionHistory versionHistoryWith:@"V2.2.12" time:@"2019.1.1" desc:@"- Find out who started following you\n- Discover which of your Tweets were liked or Retweeted\n- Respond to replies or be alerted to Tweets you were mentioned in"];
        MLVersionHistory *h3 = [MLVersionHistory versionHistoryWith:@"V2.1.0" time:@"2019.1.1" desc:@"- See what topics and hashtags are trending now\n- Discover Moments, curated stories showcasing the very best of today’s biggest events\n- Get caught up on news headlines and videos\n- Relive the latest sports highlights\n- Be in the know about pop culture and entertainment\n- See what fun stories are going viral"];
        _versionHistoryArray = @[h1, h2, h3];
    }
    return _versionHistoryArray;
}
@end
