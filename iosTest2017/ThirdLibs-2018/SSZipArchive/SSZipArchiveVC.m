//
//  SSZipArchiveVC.m
//  ThirdLibs-2018
//
//  Created by yangzijiang on 2019/2/28.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "SSZipArchiveVC.h"
#import "SSZipArchive.h"

@interface SSZipArchiveVC ()

@end

@implementation SSZipArchiveVC
#pragma mark --- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SSZipArchiveVC zipFile];
    [SSZipArchiveVC unzipFile];
}

+ (void)zipFile{
    NSString *documentDirectory =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *zipFilePath = [documentDirectory stringByAppendingPathComponent:@"zip.zip"];
    SSZipArchive *zip = [[SSZipArchive alloc] initWithPath:zipFilePath];
    [zip open];  // 如果不open，就会报'Attempting to write to an archive which was never opened'
    
    NSMutableArray<NSString *> *pathArray = [NSMutableArray array];
//    NSString *sampleDataPath = [[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"SampleData" isDirectory:YES].path;
    NSString *path1 = [[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"1.md" isDirectory:NO].path;
    NSString *path2 = [[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"2.md" isDirectory:NO].path;
    NSString *path3 = [[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"mountain.png" isDirectory:NO].path;
    [pathArray addObject:path1];
    [pathArray addObject:path2];
    [pathArray addObject:path3];
//    [pathArray addObject:[sampleDataPath stringByAppendingPathComponent:@"1.md"]];
//    [pathArray addObject:[sampleDataPath stringByAppendingPathComponent:@"2.md"]];
//    [pathArray addObject:[sampleDataPath stringByAppendingPathComponent:@"mountain.png"]];
    [pathArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = [zip writeFile:obj withPassword:nil];
        NSLog(@"result = %d", result);
    }];
    [zip close];
}

+ (void)unzipFile{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *zipFilePath = [documentDirectory stringByAppendingPathComponent:@"zip.zip"];
    [SSZipArchive unzipFileAtPath:zipFilePath toDestination:documentDirectory];
}
@end
