//
//  MLAbout.h
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 单元格类型

 - MLAboutCellTypeLatestVersion: 最新版本类型单元格
 - MLAboutCellTypeArrow: 右边为箭头类型单元格
 */
typedef NS_ENUM(NSUInteger, MLAboutCellType) {
    MLAboutCellTypeLatestVersion,
    MLAboutCellTypeArrow
};

/// 点击单元格调用的block
typedef void(^MLAboutBlock)();

/**
 About Mateline界面单元格所使用的模型
 */
@interface MLAbout : NSObject

@property(assign, nonatomic) MLAboutCellType type;
/// 标题
@property (copy, nonatomic) NSString *title;
/// 版本号
@property (copy, nonatomic) NSString *version;
/// 点击单元格调用的block
@property (copy, nonatomic) MLAboutBlock block;

/**
 创建MLAbout对象

 @param type <#type description#>
 @param title <#title description#>
 @param version 如果type为MLAboutCellTypeArrow，本字段可设置为nil或空字符串
 @param block 点击单元格调用的block
 @return MLAbout对象
 */
+ (MLAbout *)aboutWithType:(MLAboutCellType)type title:(nullable NSString *)title version:(NSString *)version block:(MLAboutBlock)block;
@end

NS_ASSUME_NONNULL_END
