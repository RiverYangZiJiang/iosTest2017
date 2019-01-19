//
//  MLAppDetailUpgradeInfoCell.h
//  iosTest2017
//
//  Created by 杨子江 on 1/19/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLAppDetailUpgradeInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 App详情界面Upgrade单元格里展示的升级信息单元格
 */
@interface MLAppDetailUpgradeInfoCell : UITableViewCell
@property (strong, nonatomic) MLAppDetailUpgradeInfo *upgradeInfo;
+ (MLAppDetailUpgradeInfoCell *)cellForTableView:(UITableView *)tableView;

+ (CGFloat)cellHeightByUpgradeInfo:(MLAppDetailUpgradeInfo *)upgradeInfo;
@end

NS_ASSUME_NONNULL_END
