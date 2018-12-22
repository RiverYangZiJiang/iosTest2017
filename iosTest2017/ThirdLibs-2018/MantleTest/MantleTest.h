//
//  MantleTest.h
//  ThirdLibs-2018
//
//  Created by yangzijiang on 2018/12/13.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 https://github.com/Mantle/Mantle，model层，Mantle makes it easy to write a simple model layer for your Cocoa or Cocoa Touch application.
 1.MTLModel：实现了MTLModel的模型子类都自动实现了<NSCoding>, <NSCopying>, -isEqual:, -hash, description方法
 2.MTLJSONSerializing：json字典和模型对象之间的相互转换
 */
@interface MantleTest : NSObject

@end

NS_ASSUME_NONNULL_END
