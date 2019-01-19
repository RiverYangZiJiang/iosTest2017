//
//  MLAppDetailUpgradeInfo.m
//  iosTest2017
//
//  Created by 杨子江 on 1/19/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAppDetailUpgradeInfo.h"

@implementation MLAppDetailUpgradeInfo

- (MLAppDetailUpgradeInfo *)initWithTitle:(NSString *)title time:(NSString *)time descriptionInfo:(NSString *)descriptionInfo{
    self = [super init];
    if (self) {
        self.title = title;
        self.time = time;
        self.descriptionInfo = descriptionInfo;
    }
    return self;
}
@end
