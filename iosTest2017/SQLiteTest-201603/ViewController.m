//
//  ViewController.m
//  SQLiteTest-201603
//
//  Created by 杨子江 on 3/23/16.
//  Copyright © 2016 杨子江. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "FMTokenizers.h"
#import "ProductDB.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *createVirtualTableButton;
@property (nonatomic, strong) UIButton *insertDataButton;
@property (nonatomic, strong) UIButton *selectDataButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ProductDBTest];
}

#pragma mark - NSDictionary
/**
 存储字典、图片到数据库，再查找、复原字典、图片 https://www.jianshu.com/p/661f7443538f
 */
- (void)ProductDBTest{
    //第一步建表
    [[[ProductDB alloc] init] createtable];
    
    //第二步添加数据 因为设定title一定不能为空  (要在数据加载完全后再添加  如果提前添加 会有两种情况 title 为空 崩溃  除title以外为空 在数据库里会显示nill （可以在加载完后使用更新 进行更改 --> 直接在加载完的地方添加不就好了 MDZZ =- = 所以说收藏里更新没啥用）)
    NSString *title = @"title";
    NSDictionary *responseObject = @{@"key1" : @"key1", @"key2" : @"key2"};
    UIImage *image = [UIImage imageNamed:@"1"];
    [[[ProductDB alloc] init] insertIntoTable:title responseObject:responseObject image:image];
    
    //一般收藏用不到更新··
//    [[[ProductDB alloc] init] updateTable:title responseObject:responseObject image:image];
    //取出数据 （查找）
    NSArray *array = [[[ProductDB alloc] init] selectFromTable:title];
    NSLog(@"array = %@", array);
    
}

- (void)testNSDictionary{
    NSString *appDocumentsFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *storePath = [NSString stringWithFormat:@"%@/yzj.db", appDocumentsFolder];
    FMDatabase *db = [FMDatabase databaseWithPath:storePath];
    
    [db open];
    
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS RequestTable (url TEXT, time TEXT, param BLOB)"];
    
    [db executeUpdate:@"insert into RequestTable values(\"http\", \"2018\", %@)"];
    [db executeStatements:@""];
}

#pragma mark - VirtualTable
- (void)testVirtualTable{
    [self.view addSubview:self.createVirtualTableButton];
    [self.view addSubview:self.insertDataButton];
    [self.view addSubview:self.selectDataButton];
}

- (UIButton *)createVirtualTableButton{
    if (!_createVirtualTableButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 50, 200, 50);
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:@"createVirtualTable" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(createVirtualTableClicked:) forControlEvents:UIControlEventTouchUpInside];
        _createVirtualTableButton = button;
    }
    return _createVirtualTableButton;
}

- (UIButton *)insertDataButton{
    if (!_insertDataButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 150, 200, 50);
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:@"insertData" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(insertDataButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _insertDataButton = button;
    }
    return _insertDataButton;
}

- (UIButton *)selectDataButton{
    if (!_selectDataButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 250, 200, 50);
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:@"selectData" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectDataButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _selectDataButton = button;
    }
    return _selectDataButton;
}

- (void)createVirtualTableClicked:(UIButton *)sender{
    NSString *storePath = @"/Users/yangzijiang/Desktop/code/workspace/IOSTest-1603/SQLiteTest-201603/xcz.db";
    FMDatabase *db = [FMDatabase databaseWithPath:storePath];
    
    [db open];
    
    FMSimpleTokenizer *simpleTok = [[FMSimpleTokenizer alloc] initWithLocale:NULL];
    
    [db installTokenizerModule];
    [FMDatabase registerTokenizer:simpleTok withKey:@"simple"];
    
//    [db executeUpdate:@"CREATE VIRTUAL TABLE works_ft USING fts4(id, title, title_tr, content, content_tr, dynasty, dynasty_tr, author, author_tr, tokenize=fmdb simple)"];
    [db executeUpdate:@"CREATE VIRTUAL TABLE works_ft USING fts4(id, title, title_tr, content, content_tr, dynasty, dynasty_tr, author, author_tr, tokenize=fmdb simple)"];
    
    [db close];
}


- (void)insertDataButtonClicked:(UIButton *)sender{
    NSString *storePath = @"/Users/yangzijiang/Desktop/code/workspace/IOSTest-1603/SQLiteTest-201603/xcz.db";
    FMDatabase *db = [FMDatabase databaseWithPath:storePath];
    
    [db open];
    
    FMSimpleTokenizer *simpleTok = [[FMSimpleTokenizer alloc] initWithLocale:NULL];
    
    [db installTokenizerModule];
    [FMDatabase registerTokenizer:simpleTok withKey:@"simple"];
    
//    [db executeUpdate:@"INSERT INTO works_ft(content) values ('123abc');"];
//    [db executeUpdate:@"INSERT INTO works_ft(content) values ('澳大利亚新西兰');"];
    [db executeUpdate:@"INSERT INTO works_ft(content) values ('游，恰同学少年');"];
    
    [db close];
}

- (void)selectDataButtonClicked:(UIButton *)sender{
    NSString *storePath = @"/Users/yangzijiang/Desktop/code/workspace/IOSTest-1603/SQLiteTest-201603/xcz.db";
    FMDatabase *db = [FMDatabase databaseWithPath:storePath];
    
    [db open];
    
    FMSimpleTokenizer *simpleTok = [[FMSimpleTokenizer alloc] initWithLocale:NULL];
    
    [db installTokenizerModule];
    [FMDatabase registerTokenizer:simpleTok withKey:@"simple"];
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM works_ft WHERE content MATCH '澳大利亚新西兰'"];
    while ([result next]) {
        NSLog(@"澳大利亚新西兰 result = %@", [result stringForColumn:@"content"]);
    }
    
    result = [db executeQuery:@"SELECT * FROM works_ft WHERE works_ft MATCH '澳大利亚'"];
    while ([result next]) {
        NSLog(@"澳大利亚 result = %@", [result stringForColumn:@"content"]);  // 无结果
    }
    
    result = [db executeQuery:@"SELECT * FROM works_ft WHERE works_ft MATCH '少年游'"];
    while ([result next]) {
        NSLog(@"少年游 result = %@", [result stringForColumn:@"content"]);  // 少年游 result = 游，恰同学少年
    }
    
    result = [db executeQuery:@"SELECT * FROM works_ft WHERE works_ft MATCH '游'"];
    while ([result next]) {
        NSLog(@"游 result = %@", [result stringForColumn:@"content"]);  // 游 result = 游，恰同学少年
    }
    
    result = [db executeQuery:@"SELECT * FROM works_ft WHERE works_ft MATCH '兰澳大利亚新西'"];
    while ([result next]) {
        NSLog(@"兰澳大利亚新西 result = %@", [result stringForColumn:@"content"]);  // 无结果
    }
    
    result = [db executeQuery:@"SELECT * FROM works_ft WHERE content MATCH '123abc'"];
    while ([result next]) {
        NSLog(@"123abc result = %@", [result stringForColumn:@"content"]);  // 123abc result = 123abc
    }
    
    result = [db executeQuery:@"SELECT * FROM works_ft WHERE content MATCH 'abc123'"];
    while ([result next]) {
        NSLog(@"abc123 result = %@", [result stringForColumn:@"content"]);  // 无结果
    }
    
    result = [db executeQuery:@"SELECT * FROM works_ft WHERE content MATCH '123'"];
    while ([result next]) {
        NSLog(@"123 result = %@", [result stringForColumn:@"content"]);  // 无结果
    }
    
    [db close];
}

@end
