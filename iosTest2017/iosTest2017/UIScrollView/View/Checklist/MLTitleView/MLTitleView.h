//
//  MLTitleView.h
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片类型

 - MLTitleViewImageTypeNone: 无图片
 - MLTitleViewImageTypeMust: 必填图片，即红星图
 - MLTitleViewImageTypeInfo: 信息图片，即里面是一个惊叹号
 */
typedef NS_ENUM(NSUInteger, MLTitleViewImageType) {
    MLTitleViewImageTypeNone,
    MLTitleViewImageTypeMust,
    MLTitleViewImageTypeInfo,
};

/**
 标题视图，如在任务、Checklist中用到
 */
@interface MLTitleView : UIView
+ titleViewWithTitle:(NSString *)title imageType:(MLTitleViewImageType)imageType;
@end

NS_ASSUME_NONNULL_END
