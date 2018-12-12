//
//  ProductDB.h
//  SQLiteTest-201603
//
//  Created by yangzijiang on 2018/11/26.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 https://www.jianshu.com/p/661f7443538f
 */
@interface ProductDB : NSObject

//创建表格
- (void)createtable;

//添加数据
- (void)insertIntoTable:(NSString *)title responseObject:(NSDictionary *)responseObject image:(UIImage *)image;

//查找数据
- (NSMutableArray *)selectFromTable:(NSString *)title;

//更新数据
- (void)updateTable:(NSString *)title responseObject:(NSDictionary *)responseObject image:(UIImage *)image;

//删除
- (void)deleteTable:(NSString *)title;

@end
