//
//  MLAboutCell.h
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLAbout.h"

NS_ASSUME_NONNULL_BEGIN

@interface MLAboutCell : UITableViewCell

+ (MLAboutCell *)cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) MLAbout *about;
@end

NS_ASSUME_NONNULL_END
