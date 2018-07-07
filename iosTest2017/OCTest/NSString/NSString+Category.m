//
//  NSString+Category.m
//  OCTest
//
//  Created by yangzijiang on 2018/7/7.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
/**
 根据指定文本和字体计算尺寸，适用于不换行的情况,宽度不受限制的情况

 @param text <#text description#>
 @param font <#font description#>
 @return <#return value description#>
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxWidth:MAXFLOAT];
}

/**
 根据指定文本,字体和最大宽度计算尺寸

 @param text <#text description#>
 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}
@end
