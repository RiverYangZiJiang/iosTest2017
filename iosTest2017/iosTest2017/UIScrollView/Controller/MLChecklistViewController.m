//
//  MLChecklistViewController.m
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLChecklistViewController.h"
#import "MLMultiSelectTitleCell.h"
#import "MLSingleSelectTitleCell.h"
#import "MLChecklistContainerCell.h"

@interface MLChecklistViewController ()
@property (strong, nonatomic) NSArray *datas;
@end

@implementation MLChecklistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    MLChecklistContainer *container = [MLChecklistContainer containerWithIcon:@"ic_asterisk" name:@"container" items:33 isMultiSelect:YES isSelected:YES];
    self.datas = @[@[@"1", @"2", @"3", @"4"], @[@"5", @"2", @"3", @"4"], container];
//    self.datas = @[@[@"1", @"2", @"3", @"4"]];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 2) {
        return [MLMultiSelectTitleCell heightForModel:self.datas[indexPath.row]];
    }
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MLMultiSelectTitleCell *cell = [MLMultiSelectTitleCell cellWithTableView:tableView];
        cell.title = @"MLMultiSelectTitleCell";
        cell.options = self.datas[indexPath.row];
        cell.selectedOptions = [NSMutableArray arrayWithObject:@"2"];
        return cell;
    } else if (indexPath.row == 1){
        MLSingleSelectTitleCell *cell = [MLSingleSelectTitleCell cellWithTableView:tableView];
        cell.title = @"MLSingleSelectTitleCell";
        cell.options = self.datas[indexPath.row];
        cell.selectedOption = @"2";
        return cell;
    }
    
    MLChecklistContainerCell *cell = [MLChecklistContainerCell cellWithTableView:tableView];
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
