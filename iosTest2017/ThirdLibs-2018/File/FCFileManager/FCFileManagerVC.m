//
//  FCFileManagerVC.m
//  ThirdLibs-2018
//
//  Created by yangzijiang on 2019/3/4.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "FCFileManagerVC.h"

@interface FCFileManagerVC ()

@end

@implementation FCFileManagerVC
#pragma mark --- Life Cycle

/**
 使用Class *clazz = [[Class alloc]init]的方式
 */

- (id)init {
    self = [super init];
    if (self) {
        //self method
    }
    return self;
}

/**
 使用Class *clazz = [Class new]的方式直接进入
 */
- (void)loadView {
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
/**
 回收通知、强引用
 */
- (void)dealloc {
    
}


#pragma mark - Public

#pragma mark - IBActions & Selectors & Notifications
#pragma mark -- IBActions

#pragma mark -- Selectors

#pragma mark -- Notifications

#pragma mark - Private

#pragma mark - Protocol conformance

#pragma mark - Getters & Setters

@end
