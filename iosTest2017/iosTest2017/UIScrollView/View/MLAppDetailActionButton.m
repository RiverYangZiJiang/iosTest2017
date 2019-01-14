//
//  MLAppDetailActionButton.m
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailActionButton.h"

@implementation MLAppDetailActionButton
+ (instancetype)buttonWithType:(UIButtonType)buttonType actionType:(MLAppDetailActionButtonType)actionType{
    MLAppDetailActionButton *button = [super buttonWithType:buttonType];
    if (button) {
        button.layer.cornerRadius = 12;
        button.layer.masksToBounds = YES;
        [button setTitle:@"DOWNLOAD" forState:UIControlStateNormal];
        [button setTitleColor:color_brand_primary forState:UIControlStateNormal];
        button.titleLabel.font = font_size_bold_14;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = color_brand_primary.CGColor;
        button.actionType = actionType;
    }
    return button;
}

- (void)setActionType:(MLAppDetailActionButtonType)actionType{
    _actionType = actionType;
    NSString *title;
    UIColor *titleColor;
    switch (actionType) {
        case MLAppDetailActionButtonTypeOpen:
            title = @"OPEN";
            titleColor = color_functional_green_dark;
            break;
        case MLAppDetailActionButtonTypeDownload:
            title = @"DOWNLOAD";
            titleColor = color_brand_primary;
            break;
        case MLAppDetailActionButtonTypeUninstall:
            title = @"UNINSTALL";
            titleColor = color_functional_red_dark;
            break;
        case MLAppDetailActionButtonTypeFailed:
            title = @"FAILED";
            titleColor = color_functional_red_dark;
            break;
        default:
            break;
    }
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}


@end
