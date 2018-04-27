//
//  UIImage+WLCompress.h
//  JYParent
//
//  Created by 倪望龙 on 2017/12/16.
//  Copyright © 2017年 互动家园. All rights reserved.
//  https://www.jianshu.com/p/99c3e6a6c033

#import <UIKit/UIKit.h>

@interface UIImage (WLCompress)

/**
 压缩图片方法(先压缩质量再压缩尺寸)

 @param maxLength <#maxLength description#>
 @return <#return value description#>
 */
-(NSData *)compressWithLengthLimit:(NSUInteger)maxLength;

/**
 压缩图片方法(压缩质量)

 @param maxLength <#maxLength description#>
 @return <#return value description#>
 */
-(NSData *)compressQualityWithLengthLimit:(NSInteger)maxLength;

/**
 压缩图片方法(压缩质量二分法)

 @param maxLength <#maxLength description#>
 @return <#return value description#>
 */
-(NSData *)compressMidQualityWithLengthLimit:(NSInteger)maxLength;

/**
 压缩图片方法(压缩尺寸)

 @param maxLength <#maxLength description#>
 @return <#return value description#>
 */
-(NSData *)compressBySizeWithLengthLimit:(NSUInteger)maxLength;

/**
 缩放图片

 @param size 缩放图片到该尺寸
 @return 缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)size;
@end
