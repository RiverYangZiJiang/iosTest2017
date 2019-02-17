//
//  MLVersionHistory.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLVersionHistory.h"

@implementation MLVersionHistory
+ (MLVersionHistory *)versionHistoryWith:(NSString *)version time:(NSString *)time desc:(NSString *)desc{
    MLVersionHistory *versionHistory = [[MLVersionHistory alloc] init];
    if (versionHistory) {
        versionHistory.version = version;
        versionHistory.time = time;
        versionHistory.desc = desc;
    }
    return versionHistory;
}

@end
