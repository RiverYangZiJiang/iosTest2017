//
//  ViewController.m
//  ThirdLibs-2018
//
//  Created by yangzijiang on 2018/5/26.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "AMapVC.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIViewController *vc = [[AMapVC alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
