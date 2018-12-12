//
//  DBManager.m
//  SQLiteTest-201603
//
//  Created by yangzijiang on 2018/11/26.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager
//数据库需要在 程序的每个地方都不会被改变  所以我们需要写成单例
+ (DBManager *)shareInsyance{
    static DBManager *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[DBManager alloc] init];
    });
    return db;
}

- (instancetype)init{
    if ([super init]) {
        //数据库路径
        NSString *s = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        //第一次调用则在此路径下创建program.sql文件 如果已存在直接使用
        NSString *path = [s stringByAppendingString:@"/program.sql"];
        self.db = [FMDatabase databaseWithPath:path];
        NSLog(@"===================%@================",path);
    }
    return self;
}

@end
