//
//  MLAppDetailUpgradeCell.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLAppDetailUpgradeInfo.h"

NS_ASSUME_NONNULL_BEGIN
/**
 App详情界面Upgrade单元格
 */
@interface MLAppDetailUpgradeCell : UITableViewCell
@property (strong, nonatomic) NSArray<MLAppDetailUpgradeInfo *> *upgradeInfoArray;

+ (MLAppDetailUpgradeCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeightByUpgradeInfoArray:(NSArray<MLAppDetailUpgradeInfo *> *)upgradeInfoArray;
@end

NS_ASSUME_NONNULL_END
