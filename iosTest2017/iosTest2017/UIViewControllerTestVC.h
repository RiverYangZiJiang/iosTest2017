//
//  UIViewControllerTestVC.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/2/11.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewControllerTestVC : UIViewController
/*
 生命周期顺序 注：从后台到前台不会调用viewWillAppear；pop回本界面会调用viewWillAppear
 [UIViewControllerTestVC viewDidLoad]
 [UIViewControllerTestVC viewWillAppear:]  // view被加载时才会调用
 [UIViewControllerTestVC viewWillLayoutSubviews]
 [UIViewControllerTestVC viewDidLayoutSubviews]
 [UIViewControllerTestVC viewDidAppear:]
 
 注：点击Home键并不会调用viewWillDisappear
 -[UIViewControllerTestVC viewWillDisappear:]  // push到下一个界面，本界面会调用viewWillDisappear
 -[UIViewControllerTestVC viewDidDisappear:]
 -[UIViewControllerTestVC dealloc]
 */
@end

NS_ASSUME_NONNULL_END
