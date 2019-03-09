//
//  MLSingleSelectTitleCell.h
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 带标题MLTitleView的单选单元格，该单元格中还有一个tableView，用来存放单选单元格MLSelectCell
 */
@interface MLSingleSelectTitleCell : UITableViewCell

/// MLTitleView视图中的标题
@property (copy, nonatomic) NSString *title;
/// 所有选项
@property (strong, nonatomic) NSArray<NSString *> *options;
/// 已选择的选项
@property (copy, nonatomic) NSString *selectedOption;

+ (MLSingleSelectTitleCell *)cellWithTableView:(UITableView *)tableView;

/**
 求单元格高度

 @param model 即options所有选项
 @return 单元格高度
 */
+ (CGFloat)heightForModel:(NSArray<NSString *> *)model;
@end

NS_ASSUME_NONNULL_END
