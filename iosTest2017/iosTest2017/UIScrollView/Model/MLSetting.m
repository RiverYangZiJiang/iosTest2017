//
//  MLSetting.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLSetting.h"

@implementation MLSetting
+ (MLSetting *)settingWithType:(MLSettingCellType)type title:(NSString *)title desc:(NSString *)desc accessoryText:(NSString *)accessoryText isOn:(BOOL)isOn block:(MLSettingBlock)block{
    MLSetting *setting = [[MLSetting alloc] init];
    if (setting) {
        setting.type = type;
        setting.title = title;
        setting.desc = desc;
        setting.accessoryText = accessoryText;
        setting.isOn = isOn;
        setting.block = block;
    }
    return setting;
}
@end
