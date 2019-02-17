//
//  MLVersionHistoryCell.h
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLVersionHistory.h"

NS_ASSUME_NONNULL_BEGIN

/**
 历史版本单元格
 */
@interface MLVersionHistoryCell : UITableViewCell

/**
 版本历史单元格
 */
@property (strong, nonatomic) MLVersionHistory *versionHistory;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 计算单元格高度
 
 @param model 模型对象
 @return 单元格高度
 */
+ (CGFloat)heightForCellOfModel:(MLVersionHistory *)model;
@end

NS_ASSUME_NONNULL_END
