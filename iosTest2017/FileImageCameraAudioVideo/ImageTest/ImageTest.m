//
//  ImageTest.m
//  FileIO
//
//  Created by yangzijiang on 2018/4/18.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ImageTest.h"
#import "UIImage+WLCompress.h"
#import "UIImage+Wechat.h"
#import "YQImageCompressTool.h"

@implementation ImageTest

+ (void)imageTest{
    CGFloat size = 300 *1000;
    NSArray *imageNames = @[@"1_4M.jpg", @"1_4M1.JPG", @"1_6M.jpg", @"1_9M.jpg", @"1_9M1.jpg", @"2_1M.jpg", @"2_2M.jpg", @"2.1M.jpg", @"3_9M.jpg", @"4-9M.png", @"5_8M.jpg", @"840K.png"];
    for (NSString *imageName in imageNames) {
//        [ImageTest compressMidQualityWithLengthLimit:imageName scaleToSize:size];
//        [ImageTest compressWithLengthLimit:imageName scaleToSize:size];
//        [ImageTest compressQualityWithLengthLimit:imageName scaleToSize:size];
//        [ImageTest wcSessionCompress:imageName];
//        [ImageTest CompressToImageWithImage:imageName scaleToSize:200 dir:@"CompressToImageWithImage"];
//        [ImageTest CompressToDataWithImage:imageName scaleToSize:200 dir:@"CompressToDataWithImage"];
    }
    
    [ImageTest jpegToPng];
}

#pragma mark - YQImageCompressTool速度慢，图片不清晰
/**
 YQImageCompressTool速度慢，图片不清晰

 @param imageName <#imageName description#>
 @param size <#size description#>
 @param dir <#dir description#>
 */
+ (void)CompressToImageWithImage:(NSString *)imageName scaleToSize:(CGFloat)size dir:(NSString *)dir{
    NSLog(@"%s begin", __func__);
    UIImage *i1_4M = [UIImage imageNamed:imageName];
    UIImage *d1_4MWC = [YQImageCompressTool CompressToImageWithImage:i1_4M ShowSize:i1_4M.size FileSize:size];
    NSData *d1_4MS = UIImageJPEGRepresentation(d1_4MWC, 1);
    NSLog(@"imageName%@, length = %ld", imageName, d1_4MS.length);
    NSString *saveImagePath = [[@"/Users/sprite/Desktop/image" stringByAppendingPathComponent:dir] stringByAppendingPathComponent:imageName];
    [d1_4MS writeToFile:saveImagePath atomically:YES];
    NSLog(@"%s end", __func__);
}

+ (void)CompressToDataWithImage:(NSString *)imageName scaleToSize:(CGFloat)size dir:(NSString *)dir{
    NSLog(@"%s begin", __func__);
    UIImage *i1_4M = [UIImage imageNamed:imageName];
    NSData *d1_4MS = [YQImageCompressTool CompressToDataWithImage:i1_4M ShowSize:i1_4M.size FileSize:size];
    NSLog(@"imageName%@, length = %ld", imageName, d1_4MS.length);
    NSString *saveImagePath = [[@"/Users/sprite/Desktop/image" stringByAppendingPathComponent:dir] stringByAppendingPathComponent:imageName];
    [d1_4MS writeToFile:saveImagePath atomically:YES];
    NSLog(@"%s end", __func__);
}

#pragma mark - WCImageCompress图片大小及清晰度都不如UIImage+WLCompress
/**
 使用缩放的方式做的，图片大小及清晰度都不如UIImage+WLCompress
 https://github.com/WearFlatShoesToWalkTheWorld/WCImageCompress

 @param imageName <#imageName description#>
 */
+ (void)wcSessionCompress:(NSString *)imageName{
    NSLog(@"%s begin", __func__);
    UIImage *i1_4M = [UIImage imageNamed:imageName];
    UIImage *d1_4MWC = [i1_4M wcSessionCompress];
    NSData *d1_4MS = UIImageJPEGRepresentation(d1_4MWC, 1);
    NSLog(@"imageName%@, length = %ld", imageName, d1_4MS.length);
    NSString *saveImagePath = [@"/Users/sprite/Desktop/image" stringByAppendingPathComponent:imageName];
    
    [d1_4MS writeToFile:saveImagePath atomically:YES];
    NSLog(@"%s end", __func__);
}

#pragma mark - WLCompress.h
+ (void)compressQualityWithLengthLimit:(NSString *)imageName scaleToSize:(CGFloat)size{
    NSLog(@"%s begin", __func__);
    UIImage *i1_4M = [UIImage imageNamed:imageName];
    NSData *d1_4MS = [i1_4M compressQualityWithLengthLimit:size];
    NSLog(@"imageName%@, length = %ld", imageName, d1_4MS.length);
    NSString *saveImagePath = [@"/Users/sprite/Desktop/image" stringByAppendingPathComponent:imageName];
    [d1_4MS writeToFile:saveImagePath atomically:YES];
    NSLog(@"%s end", __func__);
}

+ (void)compressMidQualityWithLengthLimit:(NSString *)imageName scaleToSize:(CGFloat)size{
    NSLog(@"%s begin", __func__);
    UIImage *i1_4M = [UIImage imageNamed:imageName];
    NSData *d1_4MS = [i1_4M compressMidQualityWithLengthLimit:size];
    NSLog(@"imageName%@, length = %ld", imageName, d1_4MS.length);
    NSString *saveImagePath = [@"/Users/sprite/Desktop/image" stringByAppendingPathComponent:imageName];
    [d1_4MS writeToFile:saveImagePath atomically:YES];
}


/**
 先使用二分法压缩，加快压缩速度；再使用比例缩放。能压缩到指定大小
 速度快、能压缩到指定大小：
 @param imageName <#imageName description#>
 @param size <#size description#>
 */
+ (void)compressWithLengthLimit:(NSString *)imageName scaleToSize:(CGFloat)size{
    NSLog(@"%s begin", __func__);
    UIImage *i1_4M = [UIImage imageNamed:imageName];
    NSData *d1_4MS = [i1_4M compressWithLengthLimit:size];
    NSLog(@"imageName%@, length = %ld", imageName, d1_4MS.length);
    NSString *saveImagePath = [@"/Users/sprite/Desktop/image" stringByAppendingPathComponent:imageName];
    [d1_4MS writeToFile:saveImagePath atomically:YES];
    NSLog(@"%s end", __func__);
}


#pragma mark - 缩放图片
+ (void)scaleImage:(NSString *)imageName scaleToSize:(CGSize)size{
    NSLog(@"%s begin", __func__);
    UIImage *i1_4M = [UIImage imageNamed:imageName];
    NSData *d1_4M = UIImageJPEGRepresentation(i1_4M, 1);
    NSLog(@"d1_4M length = %ld", d1_4M.length);
    
    CGSize scaleSize = CWSizeReduce(i1_4M.size, size.width);
    UIImage *i1_4MS = [i1_4M scaleToSize:scaleSize];
    NSData *d1_4MS = UIImageJPEGRepresentation(i1_4MS, 1);
    NSLog(@"imageName%@, length = %ld", imageName, d1_4MS.length);
    NSString *saveImagePath = [@"/Users/sprite/Desktop/image" stringByAppendingPathComponent:imageName];
    [d1_4MS writeToFile:saveImagePath atomically:YES];
    NSLog(@"%s end", __func__);
}

CGSize CWSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
{
    NSLog(@"%s begin", __func__);
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    NSLog(@"%s end", __func__);
    return imgSize;
}
#pragma makr 无损压缩成png图片
/**
 UIImagePNGRepresentation压缩png格式图片，多次压缩效果一样，并且图片反而变大了，如从292k变成了373k；处理jpg或jpeg格式图片，即转变成png图片，图片会变大很多，如1.5M变成7.7M，234k变成954k
 png图片可以压缩成jpg格式图片，但是再转换成png格式，就没压缩效果了，因为这时是无损压缩
 PNG 图片是无损压缩，并且支持 alpha 通道，而 JPEG 图片则是有损压缩，可以指定 0-100% 的压缩比。
 http://www.cocoachina.com/ios/20170227/18784.html
 http://ask.dcloud.net.cn/question/19433
 */
+ (void)jpegToPng{
    UIImage *image = [UIImage imageWithContentsOfFile:@"/Users/sprite/Documents/yzj/ios/图片压缩/png292k.png"];
//    UIImage *image = [UIImage imageWithContentsOfFile:@"/Users/sprite/Pictures/The Coast.jpg"];
    // 转换出来的是jpeg格式图片，234k
//    NSData *imageData = [image compressQualityWithLengthLimit:200];
//    [imageData writeToFile:@"/Users/sprite/Documents/yzj/ios/图片压缩/png292k_1.jpg" atomically:YES];
//
//    UIImage *tmpPNGImage = [[UIImage alloc] initWithData:imageData];
//    NSData *pngData = UIImagePNGRepresentation(tmpPNGImage);
    NSData *pngData = UIImagePNGRepresentation(image);
//    UIImage *tmpPNGImage = [[UIImage alloc] initWithData:pngData];
//    pngData = UIImagePNGRepresentation(tmpPNGImage);
    
    // 又转换png格式图片，不过文件比较大，954k
    [pngData writeToFile:@"/Users/sprite/Documents/yzj/ios/图片压缩/png292k_1.png" atomically:YES];
}
#pragma mark - 图片压缩
/*
 1.使用PHImageManager获取系统相册图片：
   1.1.如果要选取多张图片，则要使用[PHImageManager defaultManager] requestImageDataForAsset方法。不能使用requestImageForAsset方法，该方法会导致内存暴涨
   1.2.如果要把多张图片压缩和生成缩略图，那么先把图片循环保存到沙盒，然后再循环从沙盒取出图片进行压缩，然后再循环从沙盒取出图片生成缩略图
   1.3.生成缩略图比压缩图片相对更占内存
 2.压缩图片和缩放图片对比:https://www.jianshu.com/p/99c3e6a6c033
   2.1.压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；
       缺点在于，不能保证图片压缩后小于指定大小。
   2.2.缩放图片尺寸可以使图片小于指定大小，但会使图片明显模糊(比压缩图片质量模糊)。
   2.3.缩放图片比压缩图片更占内存
 
 
*/
// 压缩图片至100k以下
+(NSData *)imageData:(UIImage *)myimage{
    NSData *data = UIImageJPEGRepresentation(myimage, 1.0);
    
    if (data.length > 1024*1024) {  // 1M以及以上
        data=UIImageJPEGRepresentation(myimage, 0.1);
    }else if (data.length > 512*1024) {  // 0.5M-1M
        data=UIImageJPEGRepresentation(myimage, 0.5);
    }else if (data.length > 200*1024) {  // 0.25M-0.5M
        data=UIImageJPEGRepresentation(myimage, 0.9);
    }
    
    NSLog(@"%@ %s data.length = %ld", NSStringFromClass([self class]), __func__, data.length);
    
    return data;
}

@end
