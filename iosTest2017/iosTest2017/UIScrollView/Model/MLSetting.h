//
//  MLSetting.h
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 单元格类型

 - MLSettingCellTypeArrow: 右边为箭头类型单元格
 - MLSettingCellTypeSwitch: 右边为开关类型单元格
 */
typedef NS_ENUM(NSUInteger, MLSettingCellType) {
    MLSettingCellTypeArrow,
    MLSettingCellTypeSwitch
};

@class MLSetting;
/// 点击单元格调用的block
typedef void(^MLSettingBlock)(MLSetting *setting);

/**
 设置界面单元格所使用的模型
 */
@interface MLSetting : NSObject
@property(assign, nonatomic) MLSettingCellType type;
/// 标题
@property (copy, nonatomic) NSString *title;
/// 标题下方的描述信息
@property (copy, nonatomic) NSString *desc;
/// 标题右边的字符串
@property (copy, nonatomic) NSString *accessoryText;
/// 是否打开，在type为MLSettingCellTypeSwitch用到
@property(assign, nonatomic) BOOL isOn;
/// 点击单元格调用的block
@property (copy, nonatomic) MLSettingBlock block;
/// 单元格高度
@property(assign, nonatomic) CGFloat cellHeight;

/**
 创建模型对象

 @param type <#type description#>
 @param title 标题
 @param desc 标题下方的描述信息
 @param accessoryText 标题右边的字符串
 @param isOn 是否打开，在type为MLSettingCellTypeSwitch用到；如果type为MLSettingCellTypeArrow，可以设置为true或false
 @param block 点击单元格调用的block
 @return 模型对象
 */
+ (MLSetting *)settingWithType:(MLSettingCellType)type title:(NSString *)title desc:(NSString *)desc accessoryText:(NSString *)accessoryText isOn:(BOOL)isOn block:(MLSettingBlock)block;
@end

NS_ASSUME_NONNULL_END
