//
//  UIViewControllerTestVC.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/2/11.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UIViewControllerTestVC.h"

@interface UIViewControllerTestVC ()

@end

@implementation UIViewControllerTestVC
//- (void)loadView{
//    NSLog(@"%s", __func__);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
}

- (void)viewWillLayoutSubviews{
    NSLog(@"%s", __func__);
}

- (void)viewDidLayoutSubviews{
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%s", __func__);
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}
@end
