//
//  MLSettingCell.h
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLSetting.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLSettingCell : UITableViewCell
@property (strong, nonatomic) MLSetting *setting;

+ (MLSettingCell *)cellWithTableView:(UITableView *)tableView;

/**
 计算单元格高度

 @param model 模型对象
 @return 单元格高度
 */
+ (CGFloat)heightForCellOfModel:(MLSetting *)model;
@end

NS_ASSUME_NONNULL_END
