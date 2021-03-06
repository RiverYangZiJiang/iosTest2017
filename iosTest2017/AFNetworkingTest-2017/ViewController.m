//
//  ViewController.m
//  AFNetworkingTest-2017
//
//  Created by yangzijiang on 2017/2/16.
//  Copyright © 2017年 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "NSURLSessionTest.h"
#import "MLRequestManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// 下载操作
@property (strong, nonatomic)NSURLSessionDownloadTask *downloadTask;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [NSURLSessionTest sessionTest];
//    [ViewController downloadFile2];
//    [self downloadFile1];
//    [ViewController uploadFile];
//    [ViewController dataTask];
//    [ViewController AFNetworkReachabilityManagerTest];
//    [ViewController postTest];
    
    [ViewController testRequestManager];
}

+ (void)testRequestManager{
    [MLRequestManager sendRequest:^(MLRequest *request) {
        request.retryCount = 5;
    } onSuccess:nil onFailure:nil onFinished:nil];
    
}
#pragma mark - Data Task & post-AFHTTPSessionManager
// post, get都是请求，是请求就都会响应；只不过post可以在body携带数据，get只能在URL字符串携带不超过1k的数据；只使用POST就可以达到增删改查的目标，POST也更安全，现在不再使用get请求
/**
 使用AFHTTPSessionManager发送一个POST请求，一行代码就能搞定，真是方便。如果需要对请求进行配置，如设置超时时间、最大请求数等、SSL安全策略、接受的文件类型。POST, GET都是dataTask
 */
+ (void)postTest{
    // 直接请求一个html页面回来，会报"Request failed: unacceptable content-type: text/html"，除非设置manager.responseSerializer.acceptableContentTypes
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置SSL安全策略为不校验服务器
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    manager.securityPolicy = policy;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/x-msdownload",@"application/x-www-form-urlencoded", nil];
    // 会话级别的超时时间
    manager.requestSerializer.timeoutInterval = 60;
    manager.session.configuration.HTTPMaximumConnectionsPerHost = 15;
    
    NSString *url = @"https://httpbin.org/post";
//    NSString *url = @"http://127.0.0.1";
    NSDictionary *param = @{@"key":@"value"};
//    [[AFHTTPSessionManager manager] POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void)dataTask{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.session.configuration.HTTPMaximumConnectionsPerHost = 15;
    // AFURLSessionManager无requestSerializer对象

    
    NSURL *URL = [NSURL URLWithString:@"http://www.marlerblog.com/files/2013/03/orange.jpg"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    // 超时
    //    manager.requestSerializer.timeoutInterval
    // 会话级别请求的超时，只要有数据返回就行。When the request timer reaches the specified interval without receiving any new data, it triggers a timeout.
    // Any upload or download tasks created by a background session are automatically retried if the original request fails due to a timeout. To configure how long an upload or download task should be allowed to be retried or transferred, use the timeoutIntervalForResource property.
    manager.session.configuration.timeoutIntervalForRequest = 10;
    // 整个资源请求完成的时间，默认7天
    // The resource timeout interval controls how long (in seconds) to wait for an entire resource to transfer before giving up. The resource timer starts when the request is initiated and counts until either the request completes or this timeout interval is reached, whichever comes first.
    manager.session.configuration.timeoutIntervalForResource = 600;
    // 请求空闲时间，可以用来设置单个请求超时时间。If during a connection attempt the request remains idle for longer than the timeout interval, the request is considered to have timed out.
    request.timeoutInterval = 10;
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [dataTask resume];
}


#pragma mark - 上传文件-AFURLSessionManager
#pragma mark 只上传文件
+ (void)uploadFile{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 使用AFURLSessionManager上传文件
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
//    NSString *urlStr = @"http://120.25.226.186:32812/upload";
    NSString *urlStr = @"http://example.com/upload";
    NSURL *url = [NSURL URLWithString:urlStr];  // 待上传服务器路径
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSURL *fileUrl = [NSURL fileURLWithPath:@"/Users/sprite/Work/版本信息.rtf"];/Users/sprite/Downloads/jdk-7u71-macosx-x64.dmg
    NSURL *fileUrl = [NSURL fileURLWithPath:@"/Users/sprite/Downloads/Testable/UITests.m"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request
        fromFile:fileUrl
        progress:^(NSProgress * _Nonnull uploadProgress) {
            long long totalUnitCount = uploadProgress.totalUnitCount;
            long long completedUnitCount = uploadProgress.completedUnitCount;
            NSLog(@"totalUnitCount = %lld, completedUnitCount = %lld", totalUnitCount, completedUnitCount);
        }
        completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSLog(@"Success: %@ %@", response, responseObject);
            }
        }];
    [uploadTask resume];
}

#pragma mark 除了上传文件、还可以同时附带其他参数，如文件名、多媒体类型、Header、Body
/**
 Creating an Upload Task for a Multi-Part Request, with Progress。
 */
+ (void)uploadFileMulitPartRequestWithProgress{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //  配置formData
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {  //请求失败
                          NSLog(@"Error: %@", error);
                      } else {  // 请求成功
                          NSLog(@"%@ %@", response, responseObject);
                          // 反序列化为json字符串，AFURLSessionManager返回的是NSData数据https://www.cnblogs.com/Mr-zyh/p/5853797.html
                          // https://www.jianshu.com/p/804f51c1fc55
                          // 通读AFN②--AFN的上传和下载功能分析、SessionTask及相应的session代理方法的使用细节https://www.cnblogs.com/Mike-zh/p/5172389.html
                          responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                      }
                  }];
    
    [uploadTask resume];
}
// Mateline如果使用-[AFURLSessionManager uploadTaskWithRequest:fromFile:progress:completionHandler:]，报错description = "Common error, error message is org.apache.commons.fileupload.FileUploadBase$InvalidContentTypeException:the request doesn't contain a multipart/form-data or multipart/mixed stream, content type header is application/x-www-form-urlencoded, at org.apache.commons.fileupload.FileUploadBase$FileItemIteratorImpl.<init>(FileUploadBase.java:948).";

#pragma mark - 下载文件download-AFURLSessionManager
// 任何互联网上的资源都是文件，都可以上传和下载，如网页、图片、音视频等
/**
 AFURLSessionManager
 
 AFURLSessionManager creates and manages an NSURLSession object based on a specified NSURLSessionConfiguration object, which conforms to <NSURLSessionTaskDelegate>, <NSURLSessionDataDelegate>, <NSURLSessionDownloadDelegate>, and <NSURLSessionDelegate>.
 
 使用AFURLSessionManager的downloadTaskWithRequest方法下载文件
 */
- (void)downloadFile1{
    NSLog(@"downloadFile1 begin");
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *remoteUrl = [NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:remoteUrl];
    
    self.downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *filePath = [paths[0] stringByAppendingPathComponent:@"orange.jpg"];
//        NSLog(@"filePath = %@", filePath);
//
//        NSURL *localUrl = [NSURL fileURLWithPath:filePath];  // 必须是fileURL格式，一般URL是"/Users..."，fileURL是"file:///Users..."
////        NSURL *localUrl = [NSURL URLWithString:filePath];  // 这种URL格式无法下载

//        return localUrl;
        
        // 返回文件保存路径，官方样例
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSLog(@"documentsDirectoryURL = %@", documentsDirectoryURL);
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
        self.imageView.image = img;
        
        NSLog(@"File downloaded to : %@", filePath);
    }];
#warning 必须要调用resume才能开始下载
//    [self.downloadTask resume];
}


/**
 使用AFHTTPSessionManager这个继承自AFURLSessionManager的单例对象的方法下载
 */
+ (void)downloadFile2{
    NSURL *remoteUrl = [NSURL URLWithString:@"http://www.marlerblog.com/files/2013/03/orange.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:remoteUrl];
    NSURLSessionDownloadTask *downloadTask = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载百分比
        NSLog(@"currentProgress = %f", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 返回文件保存路径，官方样例
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"File downloaded to : %@", filePath);
    }];
    
    [downloadTask resume];  // 必须要调用才能开始下载
}

#pragma mark 开始下载
// http://www.cnblogs.com/qingche/p/5362592.html
- (IBAction)startDownload:(id)sender{
//   [self.downloadTask resume];
    [ViewController uploadFile];
}
#pragma mark 暂停下载
- (IBAction)stopDownload:(id)sender{
    [self.downloadTask suspend];
    
}



#pragma mark - 网络监听-AFNetworkReachabilityManager
+ (void)AFNetworkReachabilityManagerTest{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 应用启动就会进到这里一次，若有网，则判断有网；无网，则判断无网，可以提示用户无网
        // 后面网络每变化一次就会调用一次，网络一变化就能监听到
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));  // Reachability: Reachable via WiFi或者Reachability: Not Reachable
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"当前无网络");  // 可在此提示用户当前无网络
//            [MBProgressHUD showToast:[NSString stringWithFormat:@"%@",GET_LANGUAGE_KEY(@"unknown_host")]];
        }else{  // 网络正常
            
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - 解析XML-AFHTTPSessionManager
-(void)xml{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // responseSerializer 用来解析服务器返回的数据
    
    // 告诉AFN，以XML形式解析服务器返回的数据
    mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSDictionary *params = @{
                             @"username" : @"520it",
                             @"pwd" : @"520it",
                             @"type" : @"XML"
                             };
    
    [mgr GET:@"http://120.25.226.186:32812/login" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败---%@", error);
    }];
}

#pragma mark - NSURLSession
- (void)simpleNSURLSessionTest{
    /* 创建配置对象Create configuration object. */
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    /* 创建sessionCreate a session for configuration. */
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    /* 请求资源Requesting a resource using system-provided delegates. */
    [[delegateFreeSession dataTaskWithURL: [NSURL URLWithString: @"http://news.sohu.com/20160521/n450744752.shtml"]
                        completionHandler:^(NSData *data, NSURLResponse *response,
                                            NSError *error) {
                            
                            NSLog(@"Got response %@ with error %@.\n", response, error);
                            NSLog(@"DATA:\n%@\nEND DATA\n",[[NSString alloc] initWithData: data
                                                                                 encoding: NSUTF8StringEncoding]);
                        }] resume];
}

#pragma mark - AFNetworking
#pragma mark get请求
- (void)getHTMLPage{
    
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报"Request failed: unacceptable content-type: text/html" 错误，因为我们要获取text/html类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = @"http://dict.youdao.com/w/HTML/#keyfrom=dict.top";
    // 如果是Get请求，相比Post请求，少了请求参数，然后只需将post方法改为get方法（也可以直接将请求参数拼接在URL后面）
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 请求成功，解析数据
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
    }];
}

#pragma mark post请求
- (void)postData{
    // 请求的参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"20131129", @"date", @"1", @"startRecord", @"5", @"len", @"1234567890", @"udid", @"Iphone", @"terminalType", @"213", @"cid", nil];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // post请求
    NSString *url = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?";
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        // 请求成功，解析数据
        NSLog(@"%@", responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"%@", dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
    }];
}


/**
 *  AFN3.0 下载
 */
- (void)downLoad{
    // 官网代码
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    
    // http://www.jianshu.com/p/11bb0d4dc649 代码
    //    //1.创建管理者对象
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    //2.确定请求的URL地址
    //    NSURL *url = [NSURL URLWithString:@""];
    //
    //    //3.创建请求对象
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //
    //    //下载任务
    //    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
    //        //打印下下载进度
    //        WKNSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    //
    //    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
    //        //下载地址
    //        WKNSLog(@"默认下载地址:%@",targetPath);
    //
    //        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
    //        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //        return [NSURL URLWithString:filePath];
    //
    //
    //    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
    //
    //        //下载完成调用的方法
    //        WKNSLog(@"下载完成：");
    //        WKNSLog(@"%@--%@",response,filePath);
    //
    //    }];
    //
    //    //开始启动任务
    //    [task resume];
    
}

/**
 *  AFN 3.0 上传
 *      有两种方式
 *          upLoad1 和 upLoad2
 */

//第一种方法是通过工程中的文件进行上传
- (void)upLoad1{
    
    // 官网代码
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
    
    // http://www.jianshu.com/p/11bb0d4dc649 代码
    //    //1。创建管理者对象
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    //    //2.上传文件
    //    NSDictionary *dict = @{@"username":@"1234"};
    //
    //    NSString *urlString = @"22222";
    //    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //        //上传文件参数
    //        UIImage *iamge = [UIImage imageNamed:@"123.png"];
    //        NSData *data = UIImagePNGRepresentation(iamge);
    //        //这个就是参数
    //        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
    //
    //    } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //        //打印下上传进度
    //        WKNSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //        //请求成功
    //        WKNSLog(@"请求成功：%@",responseObject);
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //        //请求失败
    //        WKNSLog(@"请求失败：%@",error);
    //    }];
    
}

//第二种是通过URL来获取路径，进入沙盒或者系统相册等等
- (void)upLoda2{
    // http://www.jianshu.com/p/11bb0d4dc649 代码
    //    //1.创建管理者对象
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    //2.上传文件
    //    NSDictionary *dict = @{@"username":@"1234"};
    //
    //    NSString *urlString = @"22222";
    //    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //
    //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
    //    } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //        //打印下上传进度
    //        WKNSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //        //请求成功
    //        WKNSLog(@"请求成功：%@",responseObject);
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //        //请求失败
    //        WKNSLog(@"请求失败：%@",error);
    //    }];
}

#pragma mark 监测当前网络状态（网络监听）
// http://www.jianshu.com/p/11bb0d4dc649 代码
- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}
@end
