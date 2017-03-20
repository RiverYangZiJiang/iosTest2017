//
//  ViewController.m
//  UISearchControllerTest-201703
//
//  Created by yangzijiang on 2017/3/7.
//  Copyright © 2017年 yangzijiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

//- (instancetype)init {
//    // 调用父类的指定初始化方法
//    self = [super initWithStyle:UITableViewStylePlain];
//    return self;
//}
//- (instancetype)initWithStyle:(UITableViewStyle)style {
//    self = [super initWithStyle:style];
//    return self;
//}
//
- (void)viewDidLoad {
    [super viewDidLoad];

    self.datas = @[@"1", @"2", @"3"];
}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.datas.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
//    }
//    cell.textLabel.text = self.datas[indexPath.row];
//    return cell;
//}

@end
