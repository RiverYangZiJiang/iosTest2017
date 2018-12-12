//
//  ProductDB.m
//  SQLiteTest-201603
//
//  Created by yangzijiang on 2018/11/26.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ProductDB.h"
#import "DBManager.h"

@implementation ProductDB

//使用数据库时要注意 操作前打开[DBm.db open] 操作结束后一定要关闭[DBm.db close]
//创建表格 表名collect
- (void)createtable{
    DBManager *dbM = [DBManager shareInsyance];
    if ([dbM.db open]) {
        [dbM.db executeUpdate:@"create table if not exists collect(title text not null primary key, responseObject blob,  image blob)"];
    }
    [dbM.db close];
}

//添加数据
// 字典 和数组 用[NSKeyedArchiver archivedDataWithRootObject：进行归档]   图片用UIImageJPEGRepresentation(image, 1.0)
- (void)insertIntoTable:(NSString *)title responseObject:(NSDictionary *)responseObject image:(UIImage *)image{
    DBManager *dbM = [DBManager shareInsyance];
    [dbM.db open];
    [dbM.db executeUpdate:@"insert into collect values(?,?,?)",title,[NSKeyedArchiver archivedDataWithRootObject:responseObject],UIImageJPEGRepresentation(image, 1.0)];
    [dbM.db close];
}

//查找数据
- (NSMutableArray *)selectFromTable:(NSString *)title{
    NSMutableArray *array = [NSMutableArray array];
    DBManager *dbM = [DBManager shareInsyance];
    [dbM.db open];
    //查找是没有条件则把表中所有东西查找
    FMResultSet *set = [dbM.db executeQueryWithFormat:@"select *from collect where title = %@;",title];
    while ([set next]) {
        NSString *s = [set stringForColumn:@"title"];
        //反归档字典
        NSData *dataR = [set dataForColumn:@"responseObject"];
        NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:dataR];
        //反归档图片
        NSData *dataC = [set dataForColumn:@"image"];
        UIImage *image = [UIImage imageWithData:dataC];
        
        
        //保证image 不在空状态 空图片不能放入数组 避免无数据时崩溃   placeholder.png 为占位图
        if (image == nil) {
            image = [UIImage imageNamed:@"placeholder"];
        }
        
        [array addObject:s];
        [array addObject:dic];
        [array addObject:image];
//        [array addObject:arr];
    }
    [dbM.db close];
    
    return array;
}

//更新数据
- (void)updateTable:(NSString *)title responseObject:(NSDictionary *)responseObject image:(UIImage *)image{
    DBManager *dbM = [DBManager shareInsyance];
    if ([dbM.db open]) {
        //update collect set 更改数据 = ？ where 对应条件 = ？
        [dbM.db executeUpdate:@"update collect set responseObject = ?, image = ? where title = ?",[NSKeyedArchiver archivedDataWithRootObject:responseObject],UIImageJPEGRepresentation(image, 1.0),title];
    }
    [dbM.db close];
}

//删除
- (void)deleteTable:(NSString *)title{
    //1.全部删除 需要全部删除的吧下边拖出去弄成一个方法
    DBManager *dbM = [DBManager shareInsyance];
    if ([dbM.db open]) {
        [dbM.db executeUpdate:@"delete from collect"];
    }
    [dbM.db close];
    
    //2.对应删除
//    DBManager *dbM = [DBManager shareInsyance];
    if ([dbM.db open]) {
        [dbM.db executeUpdate:@"delete from collec where title = ?",title];
    }
    [dbM.db close];
}
@end
