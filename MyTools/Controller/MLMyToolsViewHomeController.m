//
//  MLMyToolsViewHomeController.m
//  Mateline
//
//  Created by yangzijiang on 2019/1/10.
//

#import "MLMyToolsViewHomeController.h"
#import "MLCustomSegmentedControl.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "DiscoverAppItem.h"
#import "MLMyToolTableViewCell.h"
#import "MLMyToolsViewController.h"
#import "MLMyToolsMarketViewController.h"

@interface MLMyToolsViewHomeController ()<UITableViewDelegate, UITableViewDataSource, MLCustomSegmentedControlDelegate, UIScrollViewDelegate>
/// 自定义
@property (strong, nonatomic) MLCustomSegmentedControl *MLCustomSegmentedControl;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<DiscoverAppItem *> *appItems;

/**
 容纳列表和地图的容器
 */
@property (nonatomic,strong) UIScrollView   *scrollView;
@end

@implementation MLMyToolsViewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView {
    [self setCustomTitle:@""];
    
    self.navigationItem.titleView = self.MLCustomSegmentedControl;
    
    self.view.backgroundColor = color_neutral_grey_lighter;
    
    MLMyToolsMarketViewController *vc1 = [[MLMyToolsMarketViewController alloc] init];
    MLMyToolsViewController *vc2 = [[MLMyToolsViewController alloc] init];
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = self.view.bounds;
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.view);
//    }];
    
    MLDDLogDebug(@"self.childViewControllers.count = %ld", self.childViewControllers.count);
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.scrollView.width, self.scrollView.height);
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.scrollView addSubview:obj.view];
        obj.view.frame = CGRectMake(idx * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
//        [obj.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(self.scrollView);
//            make.left.equalTo(self.scrollView).offset(idx * self.scrollView.width);
//            make.width.equalTo(self.scrollView);
//        }];
    }];
    
    
    //
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.top.bottom.equalTo(self.view);
    }];
    
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"folder"
                                                            titleStr:@"No Data"
                                                           detailStr:@""];
    // 默认隐藏，搜索时才显示
    self.tableView.hidden = YES;
}

- (void)initData {
    DiscoverAppItem *item = [[DiscoverAppItem alloc] initWithDisplayName:@"Speed Test" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item1 = [[DiscoverAppItem alloc] initWithDisplayName:@"Message" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item2 = [[DiscoverAppItem alloc] initWithDisplayName:@"Capacity Check" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item3 = [[DiscoverAppItem alloc] initWithDisplayName:@"Upload Monitor" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
    DiscoverAppItem *item4 = [[DiscoverAppItem alloc] initWithDisplayName:@"Check In" version:@"5.2.0" size:@"25M" type:@"PLUGIN" description:@"Internet Bandwidth Speed Test is an internet speed meter. It can test speed for WIFI, 2G, 3G, 4G, DSL, and ADSL. With just one tap, it will test your Internet. "];
//    [self.appItems addObjectsFromArray:@[item]];
    [self.appItems addObjectsFromArray:@[item, item1, item2, item3, item4]];
    [self.tableView reloadData];
}

#pragma mark - Delegates
#pragma mark -- UIScrollViewDelegate
/**
 解决手势可以切换模式页面问题
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.panGestureRecognizer.enabled = NO;
}

#pragma mark -- MLCustomSegmentedControlDelegate
- (void)MLCustomSegmentedControlItemViewClicked:(NSInteger)index{
    MLDDLogInfo(@"%s index = %ld", __func__, (long)index);
    self.scrollView.contentOffset = CGPointMake(index * self.scrollView.width, 0);
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.appItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
- (MLCustomSegmentedControl *)MLCustomSegmentedControl{
    if (!_MLCustomSegmentedControl) {
        _MLCustomSegmentedControl = [[MLCustomSegmentedControl alloc] init];
        _MLCustomSegmentedControl.frame = CGRectMake(0, 0, 200, 44);
        _MLCustomSegmentedControl.selectedIndex = 0;
        _MLCustomSegmentedControl.titles = @[@"Market", @"My Tools"];
        _MLCustomSegmentedControl.delegate = self;
    }
    return _MLCustomSegmentedControl;
}

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

- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
@end
