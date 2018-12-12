//
//  NSURLTest.m
//  OCTest
//
//  Created by yangzijiang on 2018/12/6.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSURLTest.h"

@implementation NSURLTest
+ (void)NSURLTest{
    [NSURLTest readFromFile];
}
+ (void) readFromFile{
    NSString *path = @"/Library/WebServer/Documents/test.jsp";
    
    NSString *pathUrl1 = @"file:///Library/WebServer/Documents/test.jsp";
    NSString *pathUrl2 = [NSString stringWithFormat:@"%@%@", @"file://", path];
    NSString *pathUrl3 = [NSString stringWithFormat:@"file://%@", path];
    NSLog(@"%d",[pathUrl1 isEqualToString:pathUrl2]);
    NSLog(@"%d",[pathUrl3 isEqualToString:pathUrl2]);
    NSLog(@"%@",pathUrl1);
    NSLog(@"%@",pathUrl2);
    NSLog(@"%@",pathUrl3);
    
    //([NSString stringWithFormat:@"%@%@", @"file://", path])
//    NSURL *url = [NSURL URLWithString:pathUrl1];
    NSURL *url = [NSURL URLWithString:pathUrl2];
//    NSURL *url = [NSURL URLWithString:pathUrl3];
    //定义error变量
    NSError *error;
    //    NSString *str3 = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
//    pathUrl3 = [pathUrl3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str3 = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if(error){
        NSLog(@"%@", error);
    }
    NSLog(@"%@",str3);
}

@end
