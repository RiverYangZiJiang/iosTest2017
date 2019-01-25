//
//  AppDelegate.m
//  ThirdLibs-2018
//
//  Created by yangzijiang on 2018/5/26.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AMapServices sharedServices].apiKey = @"e969bec6d5737f443e6dda94449dc2a4";
    
    [self navigationControllerTest];
    //    [self tabBarControllerTest];
    
    return YES;
}

/**
 单View，不带导航条
 */
- (void)singleView{
    self.window= [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor grayColor];
    
    ViewController *vc=[[ViewController alloc]init];
    
    self.window.rootViewController=vc;
    
    [self.window makeKeyAndVisible];
    
}


/**
 单view，带导航条
 */
- (void)navigationControllerTest{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *c = [[ViewController alloc] init];
    c.title = @"title";
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
}

- (void)tabBarControllerTest{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 导航控制器
    ViewController *c = [[ViewController alloc] init];
    c.title = @"title";
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    
    // 导航控制器1
    ViewController *c1 = [[ViewController alloc] init];
    c1.title = @"title1";
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:c1];
    
    UITabBarController *tbc = [[UITabBarController alloc]init];
    tbc.viewControllers = @[nc, nc1];  // 设置UITabBarController需要展示的控制器数组
    
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
}

@end
