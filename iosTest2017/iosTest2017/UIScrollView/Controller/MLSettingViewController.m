//
//  MLSettingViewController.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLSettingViewController.h"
#import "MLSettingCell.h"

@interface MLSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *settingArray;
@end

@implementation MLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.settingArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLSetting *setting = self.settingArray[indexPath.row];
    if (setting.cellHeight <= 0) {
        setting.cellHeight = [MLSettingCell heightForCellOfModel:setting];
    }
    return setting.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MLSettingCell *cell = [MLSettingCell cellWithTableView:tableView];
    cell.setting = self.settingArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLSetting *setting = self.settingArray[indexPath.row];
    setting.block(setting);
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

- (NSArray *)settingArray{
    if (!_settingArray) {
        MLSetting *setting1 = [MLSetting settingWithType:MLSettingCellTypeSwitch title:@"Scheduled upload over Wi-Fi" desc:@"If turned on,photos will be uploaded only when Wi-Fi is available" accessoryText:@"" isOn:false block:^(MLSetting * _Nonnull setting) {
            setting.isOn = !setting.isOn;
            [self.tableView reloadData];
        }];
        MLSetting *setting2 = [MLSetting settingWithType:MLSettingCellTypeArrow title:@"Notification sound" desc:@"" accessoryText:@"Auto" isOn:false block:^(MLSetting * _Nonnull setting) {
            NSLog(@"Auto");
        }];
        _settingArray = @[setting1, setting2];
    }
    return _settingArray;
}

@end
