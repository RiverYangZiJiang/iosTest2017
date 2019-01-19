//
//  MLAppDetailUpgradeInfo.h
//  iosTest2017
//
//  Created by 杨子江 on 1/19/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 App详情界面Upgrade单元格里展示的升级信息模型
 */
@interface MLAppDetailUpgradeInfo : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *descriptionInfo;

@property(assign, nonatomic) CGFloat cellHeight;

- (MLAppDetailUpgradeInfo *)initWithTitle:(NSString *)title time:(NSString *)time descriptionInfo:(NSString *)descriptionInfo;
@end

NS_ASSUME_NONNULL_END
