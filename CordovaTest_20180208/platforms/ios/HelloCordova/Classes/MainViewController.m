/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  HelloCordova
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.

    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    NSLog(@"MainViewController viewDidLoad");
    
    [MainViewController copyBundleJSDirToDocuments];
    NSString *ApplicationSupportPath = [MainViewController getApplicationSupportPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:ApplicationSupportPath]) {
        [fileManager createDirectoryAtPath:ApplicationSupportPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // 要注意是关于路径要运用file://方式进行读取
    self.wwwFolderName = [NSString stringWithFormat:@"file://%@", ApplicationSupportPath];
//    NSString *page = [ApplicationSupportPath stringByAppendingPathComponent:@"serviceCreator/main.html"];
//    NSString *page = @"www/serviceCreator/main.html";
    NSString *page = @"serviceCreator/main.html";
    self.startPage = page;
    NSLog(@"ApplicationSupportPath = %@\nstartPage = %@", ApplicationSupportPath, self.startPage);
    
    // self.startPage的赋值，必须在[super viewDidLoad]之前，否则self.startPage 会被默认赋值为index.html。
    // 加载本地界面
//    self.startPage = @"main.html";
    
    // 加载远程界面
    //    self.startPage = @"http://www.baidu.com";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 将bundle里serviceCreator文件夹复制到沙盒Documents目录下——成功
 */
+ (void)copyBundleJSDirToDocuments{
    NSLog(@"copyBundleJSDirToDocuments begin");
    
    NSString *jsDirName = @"serviceCreator";
    NSString *jsPath =[[NSBundle mainBundle] pathForResource:jsDirName ofType:nil];
//    NSString *jsPath =[[NSBundle mainBundle] pathForResource:@"main.html" ofType:nil];
    NSString *documentsPath =[MainViewController getApplicationSupportPath];
    NSString *toPath = [documentsPath stringByAppendingPathComponent:jsDirName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if([fileManager fileExistsAtPath:toPath]){
        [fileManager removeItemAtPath:toPath error:&error];
    }
    
    NSLog(@"copyBundleJSDirToDocuments copy begin jsPath = %@,\n toPath = %@,\n ", jsPath, toPath);
    // 如果文件夹已经复制成功，则返回，否则复制文件夹
//    if([fileManager fileExistsAtPath:toPath]){
//        return;
//    }
    BOOL result = [fileManager copyItemAtPath:jsPath toPath:toPath error:&error];
    NSLog(@"copyBundleJSDirToDocuments copy end result = %ul,\n error = %@", result, error);
    // 如果文件夹复制成功，则记录下来。不能仅凭是否存在serviceCreator目录来判断文件夹是否复制成功，因为可能只复制了一部分
    //    if(result){
    //
    //    }
}

+ (NSString *)getApplicationSupportPath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        return [paths objectAtIndex:0];
    }
    return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/* Comment out the block below to over-ride */

/*
- (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}

// CB-12098
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000  
- (NSUInteger)supportedInterfaceOrientations
#else  
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return [super supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (BOOL)shouldAutorotate 
{
    return [super shouldAutorotate];
}
*/

@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
   in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (NSString*)pathForResource:(NSString*)resourcepath
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
   in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
