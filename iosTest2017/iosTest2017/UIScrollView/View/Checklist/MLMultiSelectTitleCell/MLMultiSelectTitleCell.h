//
//  MLMultiSelectTitleCell.h
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 带标题MLTitleView的多选单元格，该单元格中还有一个tableView，用来存放多选单元格MLSelectCell
 */
@interface MLMultiSelectTitleCell : UITableViewCell
/// MLTitleView视图中的标题
@property (copy, nonatomic) NSString *title;
/// 所有选项
@property (strong, nonatomic) NSArray<NSString *> *options;
/// 已选择的选项
@property (strong, nonatomic) NSMutableArray<NSString *> *selectedOptions;

+ (MLMultiSelectTitleCell *)cellWithTableView:(UITableView *)tableView;

/**
 求单元格高度
 
 @param model 即options所有选项
 @return 单元格高度
 */
+ (CGFloat)heightForModel:(NSArray<NSString *> *)model;
@end

NS_ASSUME_NONNULL_END
