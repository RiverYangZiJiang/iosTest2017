//
//  MLMyToolTableViewCell.h
//  Mateline
//
//  Created by yangzijiang on 2019/1/10.
//

#import <UIKit/UIKit.h>
#import "DiscoverAppItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLMyToolTableViewCell : UITableViewCell
@property (strong, nonatomic) DiscoverAppItem *appItem;
+ (MLMyToolTableViewCell *)cellWithTableView:(UITableView *)tableView;

/**
 单元格高度
 
 @return 单元格高度
 */
- (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
