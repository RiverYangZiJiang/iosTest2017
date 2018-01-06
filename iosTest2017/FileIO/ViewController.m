//
//  ViewController.m
//  FileIO
//
//  Created by yangzijiang on 28/12/2017.
//  Copyright © 2017 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "FileUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self NSBundleTest];
//    [self NSDataTest];
//    [self NSFileManagerTest];
//    [self NSPathUtilitiesTest];
//    [self getTmpDirectory];
    [self writeNSDictionaryDataToFile];
//    [self getNSDictionaryDataFromFile];
}


/**
 为了提高应用的可移植性和访问速度，我们可以预先把一些无变化的项目资源文件放在应用中，可以使用NSBundle来访问这种应用自包含的资源文件。这些资源文件可以是text文本、plist文件、照片等。
 而放在沙盒中的文件都是应用运行过程中产生的。
 */
- (void)NSBundleTest {
    // 获得本应用对应的应用程序包
    NSBundle *mainBundle = [NSBundle mainBundle];
    // 任意拖入到工程里的文件，都可以通过本方法访问到
    NSString *filePath= [mainBundle pathForResource:@"ehs_router" ofType:@"mspl"];
    
    // 一步到位版本
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"ehs_router" ofType:@"mspl"];
    
    // 不能访问到应用配置文件Info.plist
//    NSString *filePath= [mainBundle pathForResource:@"Info" ofType:@"plist"];
    // 使用文件内容来初始化NSString
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"content = %@", content);
}

/**
 NSData是OC的数据缓冲区，作用有两个：1.将数据读入NSData；2.输出NSData的数据。
 1.将数据读入NSData：包括将C数组、本地文件、网络文件、NSData数据
 2.输出NSData的数据：包括输出到C数组、本地文件、网络文件、NSData数据
 */
- (void)NSDataTest {
    // 使用NSData读取指定URL对应的数据
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://cn.bing.com"]];
    NSLog(@"data length = %ld", data.length);
    
    // 将NSData的数据用UTF-8的格式转换字符串
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"content = %@", content);
    
    // 将NSData指定范围的数据读入字符数组
    char buffer[100];
    [data getBytes:buffer range:NSMakeRange(10, 10)];
    NSLog(@"buffer = %s", buffer);
}

/**
 NSFileManager代表文件和目录管理器，可以用来移动、赋值、链接、删除文件或目录。如果需要读写文件内容，需要使用NSFileHandle类
 */
- (void)NSFileManagerTest {
    // 使用defaultManager获取系统默认的NSFileManager对象
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *filePath= [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSLog(@"fileExistsAtPath = %d", [fm fileExistsAtPath:filePath]);  // fileExistsAtPath = 1
}

/**
 NSPathUtilities包含了NSString的扩展，从而为NSSting类新增了一些专门用于操作路径的方法，如得到绝对路径的文件名、文件后缀等
 */
- (void)NSPathUtilitiesTest {
    NSString *filePath= [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSLog(@"lastPathComponent = %@", [filePath lastPathComponent]);  // Info.plist
    NSLog(@"pathExtension = %@", [filePath pathExtension]);  // plist
    NSLog(@"pathComponents = %@", [filePath pathComponents]);  //
}

/**
 获取沙盒目录下的tmp目录，该目录供应用存储临时文件，当iOS执行同步时，iTunes不会备份tmp目录下的文件。
 */
- (void)getTmpDirectory {
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmpPath = %@", tmpPath);
}

/**
 将字典数据保存到沙盒中Documents目录的dic.plist文件中
 */
- (void)writeNSDictionaryDataToFile{
    NSDictionary *dic = @{@"name":@"yzj", @"age":@28, @"members":@[@"a", @"b"]};
    NSString *path = [NSString stringWithFormat:@"%@/dic.plist", [FileUtil getDocumentDirectory]];
    [dic writeToFile:path atomically:YES];
}

/**
 从沙盒中Documents目录的dic.plist文件中获取可变字典数据，并且修改@"name"对应的值
 */
- (void)getNSDictionaryDataFromFile{
    NSString *path = [NSString stringWithFormat:@"%@/dic.plist", [FileUtil getDocumentDirectory]];
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    [md setObject:@"yzj1" forKey:@"name"];
    [md writeToFile:path atomically:YES];
}



@end
