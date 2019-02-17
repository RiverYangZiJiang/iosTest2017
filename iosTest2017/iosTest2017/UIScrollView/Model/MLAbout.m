//
//  MLAbout.m
//  iosTest2017
//
//  Created by 杨子江 on 2/17/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLAbout.h"

@implementation MLAbout
+ (MLAbout *)aboutWithType:(MLAboutCellType)type title:(NSString *)title version:(NSString *)version block:(MLAboutBlock)block{
    MLAbout *about = [[MLAbout alloc] init];
    if (about) {
        about.type = type;
        about.title = title;
        about.version = version;
        about.block = block;
    }
    return about;
}
@end
