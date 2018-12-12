//
//  DBManager.h
//  SQLiteTest-201603
//
//  Created by yangzijiang on 2018/11/26.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

NS_ASSUME_NONNULL_BEGIN

/**
 https://www.jianshu.com/p/661f7443538f
 */
@interface DBManager : NSObject
@property (nonatomic, strong) FMDatabase *db;

//类方法使用即调用
+ (DBManager *)shareInsyance;
@end

NS_ASSUME_NONNULL_END
