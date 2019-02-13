//
//  NSErrorTest.m
//  OCTest
//
//  Created by yangzijiang on 2019/2/13.
//  Copyright © 2019 yangzijiang. All rights reserved.
//

#import "NSErrorTest.h"

@implementation NSErrorTest
+ (void)test{
    NSString *domain = @"com.MyCompany.MyApplication.ErrorDomain";
    NSString *desc = @"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:-101
                                     userInfo:userInfo];
    
    NSLog(@"error.description = %@", error.description);  // Error Domain=com.MyCompany.MyApplication.ErrorDomain Code=-101 "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456
    NSLog(@"[error description] = %@", [error description]);
}
@end
