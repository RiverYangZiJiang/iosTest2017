//
//  MLSelectCell.h
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 选择单元格，包括多选、单选，通过isMultiSelect来区分是单选还是多选
 */
@interface MLSelectCell : UITableViewCell
/// 左边的标题
@property (copy, nonatomic) NSString *title;

/// 单元格是否已选择
@property(assign, nonatomic) BOOL isSelected;

/// 是否为多选，设置为YES多选，设置为NO或默认为单选
@property(assign, nonatomic) BOOL isMultiSelect;

+ (MLSelectCell *)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
