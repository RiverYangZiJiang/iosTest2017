//
//  ViewController.m
//  AFNetworkingTest-2017
//
//  Created by yangzijiang on 2017/2/16.
//  Copyright © 2017年 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// 下载操作
@property (strong, nonatomic)NSURLSessionDownloadTask *downloadTask;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [ViewController downloadFile2];
    [self downloadFile1];
//    [ViewController uploadFile];
//    [ViewController dataTask];
//    [ViewController AFNetworkReachabilityManagerTest];
//    [ViewController postTest];
}

#pragma mark - Data Task & post
// post, get都是请求，是请求就都会响应；只不过post可以在body携带数据，get只能在URL字符串携带不超过1k的数据；只使用POST就可以达到增删改查的目标
+ (void)dataTask{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://www.marlerblog.com/files/2013/03/orange.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

/**
 使用AFHTTPSessionManager发送一个POST请求，一行代码就能搞定，真是方便。POST, GET都是dataTask
 */
+ (void)postTest{
    // 直接请求一个html页面回来，会报"Request failed: unacceptable content-type: text/html"
    [[AFHTTPSessionManager manager] POST:@"http://127.0.0.1" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - 上传download
+ (void)uploadFile{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1"];  // 待上传服务器路径
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:[NSURL fileURLWithPath:@"/Users/sprite/Work/版本信息.rtf"] progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}


/**
 Creating an Upload Task for a Multi-Part Request, with Progress
 */
+ (void)uploadFileMulitPartRequestWithProgress{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
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
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}

#pragma mark - 下载文件download
// 任何互联网上的资源都是文件，都可以上传和下载，如网页、图片、音视频等
/**
 AFURLSessionManager
 
 AFURLSessionManager creates and manages an NSURLSession object based on a specified NSURLSessionConfiguration object, which conforms to <NSURLSessionTaskDelegate>, <NSURLSessionDataDelegate>, <NSURLSessionDownloadDelegate>, and <NSURLSessionDelegate>.
 
 使用AFURLSessionManager的downloadTaskWithRequest方法下载文件
 */
- (void)downloadFile1{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *remoteUrl = [NSURL URLWithString:@"http://img05.3dmgame.com/uploads/allimg/140509/153_140509150151_1.jpg"];
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
//    [self.downloadTask resume];  // 必须要调用才能开始下载
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
   [self.downloadTask resume];
}
#pragma mark 暂停下载
- (IBAction)stopDownload:(id)sender{
    [self.downloadTask suspend];
}



#pragma mark - 网络监听AFNetworkReachabilityManager
+ (void)AFNetworkReachabilityManagerTest{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 应用启动就会进到这里一次，后面网络每变化一次就会调用一次
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));  // Reachability: Reachable via WiFi或者Reachability: Not Reachable
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"当前无网络");  // 可在此提示用户当前无网络
//            [MBProgressHUD showToast:[NSString stringWithFormat:@"%@",GET_LANGUAGE_KEY(@"unknown_host")]];
        }else{  // 网络正常
            
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - 解析XML
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
@end
