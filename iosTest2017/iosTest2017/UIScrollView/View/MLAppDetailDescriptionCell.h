//
//  MLAppDetailDescriptionCell.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLAppDetailDescriptionCell : UITableViewCell
@property (strong, nonatomic) CommentModel *commentModel;

+ (MLAppDetailDescriptionCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeightByCommentModel:(CommentModel *)commentModel;
@end

NS_ASSUME_NONNULL_END
