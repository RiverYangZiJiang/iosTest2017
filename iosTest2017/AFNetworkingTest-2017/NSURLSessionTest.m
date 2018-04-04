//
//  NSURLSessionTest.m
//  AFNetworkingTest-2017
//
//  Created by yangzijiang on 31/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSURLSessionTest.h"

@implementation NSURLSessionTest

+ (void)sessionTest{
    [NSURLSessionTest dataTask:nil];
}

#pragma mark - dataTask
// dataTask任务可以用来发送GET、POST、DELETE等请求，根据NSURLRequest的HTTPMethod设置
+ (void)dataTask:(NSURLRequest *)request{
    NSString *urlString = @"https://example.com";
    // 如果存在特殊字符，需要编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建可变请求，如果需要定制请求，则必须手动创建，否则会使用默认的请求
    if(!request){
        request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        // 请求类型
//        request.HTTPMethod = @"GET";
    }
    
    // 采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // NSURLSession自动实现多线程，回调在非主线程执行
        NSLog(@"%@",[NSThread currentThread]);
        
        // 网络访问失败
        if (error) {
            NSLog(@"error=%@",error);
            return;
        }
        
        NSLog(@"response = %@", response);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"statusCode = %ld", (long)httpResponse.statusCode);
        
        NSString *dataStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"dataStr = %@", dataStr);
    }];
    
    // 每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}

#pragma mark - NSURLRequest & NSMutableURLRequest
+ (void)NSURLRequestTest{
    // 可以设置请求和请求头的一些参数，如url、缓存策略、超时时间、HTTPMethod、HTTPBody、HTTPShouldHandleCookies、请求头各参数
    NSURL *url = [NSURL URLWithString:@"https://example.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    request.HTTPMethod = @"POST";
//    request.HTTPBody = [[NSData alloc] ini];
    
    // 设置请求头各参数，根据需要设置
    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    
    // 2.设置请求头 Content-Type  返回格式
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

@end
