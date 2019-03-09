//
//  MLChecklistContainer.m
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "MLChecklistContainer.h"

@implementation MLChecklistContainer

+ (MLChecklistContainer *)containerWithIcon:(NSString *)icon name:(NSString *)name items:(NSInteger)items isMultiSelect:(BOOL)isMultiSelect isSelected:(BOOL)isSelected{
    MLChecklistContainer *container = [[MLChecklistContainer alloc] init];
    container.icon = icon;
    container.name = name;
    container.items = items;
    container.isMultiSelect = isMultiSelect;
    container.isSelected = isSelected;
    return container;
}
@end
