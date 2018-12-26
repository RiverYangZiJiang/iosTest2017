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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
//    [self.navigationItem backBarButtonItem];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    [self presentViewController:[[UILabelViewController alloc] init] animated:YES completion:nil];
    //    [self presentViewController:[[WKWebViewTest alloc] init] animated:YES completion:nil];
    //    [self.navigationController pushViewController:[[WKWebViewTest alloc] init] animated:YES];
    
//        [self.navigationController pushViewController:[[UINavigationControllerTest alloc] init] animated:YES];
    
//    [self.navigationController pushViewController:[[UICollectionViewTestViewController alloc] init] animated:YES];
    
    
    //    [self.navigationController pushViewController:[[UITableViewControllerTest alloc] init] animated:YES];
    
    [self.navigationController pushViewController:[[MKMapViewTestVC alloc] init] animated:YES];
}


@end
