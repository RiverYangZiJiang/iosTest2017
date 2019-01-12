//
//  MLMyToolsMarketViewController.m
//  Mateline
//
//  Created by yangzijiang on 2019/1/10.
//

#import "MLMyToolsMarketViewController.h"
#import "MLCustomSegmentedControl.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "DiscoverAppItem.h"
#import "MLMyToolTableViewCell.h"

@interface MLMyToolsMarketViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<DiscoverAppItem *> *appItems;
@end

@implementation MLMyToolsMarketViewController

- (void)viewDidLoad {
    MLDDLogInfo(@"");
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView {
    self.view.backgroundColor = color_neutral_grey_lighter;;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.top.bottom.equalTo(self.view);
    }];
    
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"folder"
                                                            titleStr:@"No Data"
                                                           detailStr:@""];
}

- (void)initData {
    DiscoverAppItem *item = [[DiscoverAppItem alloc] initWithDisplayName:@"Market" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item1 = [[DiscoverAppItem alloc] initWithDisplayName:@"Message" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item2 = [[DiscoverAppItem alloc] initWithDisplayName:@"Capacity Check" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item3 = [[DiscoverAppItem alloc] initWithDisplayName:@"Upload Monitor" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item4 = [[DiscoverAppItem alloc] initWithDisplayName:@"Check In" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
//    [self.appItems addObjectsFromArray:@[item]];
    [self.appItems addObjectsFromArray:@[item, item1, item2, item3, item4]];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    MLDDLogDebug(@"");
    return self.appItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MLDDLogDebug(@"");
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 146;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLMyToolTableViewCell *cell = [MLMyToolTableViewCell cellWithTableView:tableView];
    cell.appItem = self.appItems[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

#pragma mark - Custom Accessors
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = color_neutral_grey_lighter;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 128;
    }
    return _tableView;
}

- (NSMutableArray<DiscoverAppItem *> *)appItems{
    if (!_appItems) {
        _appItems = [NSMutableArray array];
    }
    return _appItems;
}
@end
