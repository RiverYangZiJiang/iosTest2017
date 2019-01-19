//
//  MLAppDetailPostACommentsTopView.h
//  iosTest2017
//
//  Created by 杨子江 on 1/18/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Post a comments顶部视图，即包含一个Post a comments的Label和一个POST的按钮，点击本视图会显示MLAppDetailPostACommentsView
 */
@interface MLAppDetailPostACommentsTopView : UIView

/// POST按钮，默认隐藏；在MLAppDetailPostACommentsView视图默认disable状态显示，即默认为灰色，并且不可点击；输入评论描述之后变成able状态，标题颜色也随之变为蓝色
@property (strong, nonatomic) UIButton *postButton;

@end

NS_ASSUME_NONNULL_END
