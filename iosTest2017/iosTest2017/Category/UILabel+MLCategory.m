//
//  UILabel+MLCategory.m
//  iosTest2017
//
//  Created by 杨子江 on 1/20/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "UILabel+MLCategory.h"
#import "NSString+YYAdd.h"

@implementation UILabel (MLCategory)
- (instancetype)initWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    self = [super init];
    if (self) {
        self.text = text;
        self.font = font;
        self.textColor = textColor;
        self.textAlignment = textAlignment;
    }
    return self;
}

- (CGFloat)widthForSingleLine{
    CGSize size = [self.text sizeForFont:self.font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByCharWrapping];
    return size.width;
}

- (CGFloat)heightForWidth:(CGFloat)width{
    return [self.text heightForFont:self.font width:width];
}
@end
