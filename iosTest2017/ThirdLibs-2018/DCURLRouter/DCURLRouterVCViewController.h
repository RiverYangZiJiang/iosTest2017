//
//  DCURLRouterVCViewController.h
//  ThirdLibs-2018
//
//  Created by yangzijiang on 2019/1/9.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCURLRouterVCViewController : UIViewController

/**
 1.在DCURLRouter.plist的Root下可以增加自己的协议，如plugin、activity，然后在自己的协议下增加新的key、value对
 2.UIViewController+DCURLRouter.h定义了valueBlock，作为回调block。参考-[OneViewController touchesBegan:withEvent:]里的实现，引入UIViewController+DCURLRouter.h，就可以设置回调block，然后在TowViewController里需要的地方调用valueBlock即可
 UIViewController *twoVc = [DCURLRouter sharedDCURLRouter].currentViewController;
 twoVc.valueBlock = ^(id value) {
 NSLog(@"%@", value);
 };
 3.通过self.params可以拿到传递过来的参数，self.params[@"age"]获得字典参数里的age的值
 
 
 */
@end

NS_ASSUME_NONNULL_END
