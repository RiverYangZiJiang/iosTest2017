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

@interface ViewController ()

@property (nonatomic, strong) UIButton *createVirtualTableButton;
@property (nonatomic, strong) UIButton *insertDataButton;
@property (nonatomic, strong) UIButton *selectDataButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
