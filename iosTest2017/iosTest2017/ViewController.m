//
//  ViewController.m
//  iosTest2017
//
//  Created by yangzijiang on 2017/2/16.
//  Copyright © 2017年 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewControllerTest.h"
#import "UILabelViewController.h"
#import "WKWebViewTest.h"
#import "UINavigationControllerTest.h"
#import <objc/runtime.h>
#import "UICollectionViewTestViewController.h"
#import "MKMapViewTestVC.h"
#import "UIAppearanceTest.h"
#import "UISegmentedControlVC.h"
#import "UISearchControllerTestVC.h"
#import "UIScrollViewTestVC.h"
#import "UIImageViewTestVC.h"
#import "UIViewControllerTestVC.h"
#import "MLVersionHistoryViewController.h"
#import "MLAboutViewController.h"
#import "MLSettingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
//    [self.navigationItem backBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    [self presentViewController:[[UILabelViewController alloc] init] animated:YES completion:nil];
    //    [self presentViewController:[[WKWebViewTest alloc] init] animated:YES completion:nil];
    //    [self.navigationController pushViewController:[[WKWebViewTest alloc] init] animated:YES];
    
//        [self.navigationController pushViewController:[[UINavigationControllerTest alloc] init] animated:YES];
    
//    [self.navigationController pushViewController:[[UICollectionViewTestViewController alloc] init] animated:YES];
    
    
    //    [self.navigationController pushViewController:[[UITableViewControllerTest alloc] init] animated:YES];
    
//    [self.navigationController pushViewController:[[MKMapViewTestVC alloc] init] animated:YES];
//    [self.navigationController pushViewController:[[UISegmentedControlVC alloc] init] animated:YES];
    
//    [self.navigationController pushViewController:[[UISearchControllerTestVC alloc] init] animated:YES];
//    [self.navigationController pushViewController:[[UIScrollViewTestVC alloc] init] animated:YES];
    
//    [self.navigationController pushViewController:[[UIImageViewTestVC alloc] init] animated:YES];
    
    [self.navigationController pushViewController:[[UIViewControllerTestVC alloc] init] animated:YES];
//    [self.navigationController pushViewController:[[MLVersionHistoryViewController alloc] init] animated:YES];
//    [self.navigationController pushViewController:[[MLAboutViewController alloc] init] animated:YES];
//    [self.navigationController pushViewController:[[MLSettingViewController alloc] init] animated:YES];
    
    
}

/**
 push到下一个界面，会调用viewWillDisappear、viewDidDisappear，但不会调用dealloc

 @param animated <#animated description#>
 */
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
