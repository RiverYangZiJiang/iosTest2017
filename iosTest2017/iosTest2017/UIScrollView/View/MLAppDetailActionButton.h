//
//  MLAppDetailActionButton.h
//  iosTest2017
//
//  Created by yangzijiang on 2019/1/14.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MLAppDetailActionButtonType) {
    MLAppDetailActionButtonTypeDownload,
    MLAppDetailActionButtonTypeOpen,
    MLAppDetailActionButtonTypeUninstall,
    MLAppDetailActionButtonTypeFailed
};
@interface MLAppDetailActionButton : UIButton

@property (assign, nonatomic) MLAppDetailActionButtonType actionType;

+ (instancetype)buttonWithType:(UIButtonType)buttonType actionType:(MLAppDetailActionButtonType)actionType;
@end

NS_ASSUME_NONNULL_END
