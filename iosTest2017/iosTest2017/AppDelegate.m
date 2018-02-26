//
//  AppDelegate.m
//  iosTest2017
//
//  Created by yangzijiang on 2017/2/16.
//  Copyright © 2017年 yangzijiang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self compare:@"1.0" num2:@"1.0.1"];
    [self compare:@"1.0" num2:@"1."];
    [self compare:@"1.0" num2:@"1"];
    [self compare:@"1.0" num2:@"0.11"];
    return YES;
}


- (void)compare:(NSString *)num1 num2:(NSString*)num2{
    BOOL result = ([num1 compare:num2 options:NSNumericSearch] == NSOrderedDescending) && ![num1 isEqualToString:num2];
    NSLog(@"num1 = %@, num2 = %@, result = %d", num1, num2, result);
}

@end
