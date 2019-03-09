//
//  MLChecklistContainer.h
//  iosTest2017
//
//  Created by 杨子江 on 3/9/19.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLChecklistContainer : NSObject
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *name;
@property(assign, nonatomic) NSInteger items;
/// 是否为多选，默认或NO为单选，YES为多选
@property(assign, nonatomic) BOOL isMultiSelect;
/// 是否已选择
@property(assign, nonatomic) BOOL isSelected;

+ (MLChecklistContainer *)containerWithIcon:(NSString *)icon name:(NSString *)name items:(NSInteger)items isMultiSelect:(BOOL)isMultiSelect isSelected:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
