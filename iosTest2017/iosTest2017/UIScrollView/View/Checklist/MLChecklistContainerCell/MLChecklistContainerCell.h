//
//  MLChecklistContainerCell.h
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLChecklistContainer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 可以为单选，也可以为多选
 */
@interface MLChecklistContainerCell : UITableViewCell
@property (strong, nonatomic) MLChecklistContainer *model;

+ (MLChecklistContainerCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END
