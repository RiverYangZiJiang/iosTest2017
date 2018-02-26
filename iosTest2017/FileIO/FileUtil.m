//
//  FileUtil.m
//  FileIO
//
//  Created by yangzijiang on 02/01/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

/**
 获取沙盒目录下的Document目录
 */
+ (NSString *) getDocumentDirectory {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"getDocumentDirectory path = %@", path);
    return path;
    
}

/**
 获取沙盒目录下的tmp目录，该目录供应用存储临时文件，当iOS执行同步时，iTunes不会备份tmp目录下的文件。
 */
+ (NSString *) getTmpDirectory {
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmpPath = %@", tmpPath);
    return tmpPath;
}

@end
