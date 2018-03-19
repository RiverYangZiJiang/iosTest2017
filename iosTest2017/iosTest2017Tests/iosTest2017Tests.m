//
//  iosTest2017Tests.m
//  iosTest2017Tests
//
//  Created by yangzijiang on 12/03/2018.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface iosTest2017Tests : XCTestCase

@end

@implementation iosTest2017Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    // 性能测试方法，该block会被连续调用10次，以统计评价时间
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


/**
 自定义测试方法必须以test开头，点击左边的菱形即可开始测试，测试时会启动应用
 */
- (void)testLogin{
    // XCTAssert是框架提供的断言，用来判断测试的结果是否符合某一个预期。若符合预期，则测试通过，否则测试失败并执行下一条用例
    XCTAssert(1 == 2);
}

@end
