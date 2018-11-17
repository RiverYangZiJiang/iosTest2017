//
//  ViewController.m
//  InstrumentsTest
//
//  Created by yangzijiang on 2018/11/17.
//  Copyright © 2018 yangzijiang. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "TestNSTimer.h"

typedef void(^TestBlock)(void);

@interface ViewController ()

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) TestBlock block;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
//    [self AnalyzeTest];
//    [self CycleReferenceTest];
//    [self blockTest];
    [self largeNumberCycle];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ViewController1 *vc = [[ViewController1 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}

#pragma mark - Analyze
/**
 Analyze—静态分析，顾名思义，静态分析不需要运行程序，就能检查到存在内存泄露的地方。
 */
- (void)AnalyzeTest{
    NSLog(@"%s", __func__);
    [self leakOne];
    [self leakTwo];
    [self leakThree];
}

/**
 * 情 形 一：创建了一个对象，但是并没有使用。
 * 提示信息：Value Stored to 'number' is never read
 * 翻译一下：存储在'number'里的值从未被读取过，
 */
- (void)leakOne {
    NSString *str1 = [NSString string];
    NSNumber *number;
    number = @(str1.length);
    /*
     说我们没有读取过它，那就读取一下，比如打开下面这句代码，对它发送class消息，就不再会有这个提示了。
     当然最好的方法还是将有关number的代码都删掉，因为，你只对number赋值，又不使用，那干嘛创建出来呢。
     这是一个比较常见和典型的错误，也很容易检查出来
     */
    // [number class];
}

/**
 * 情 形 二：创建了一个（指针可变的）对象，且初始化了，但是初始化的值一直没读取过。
 * 提示信息：Value Stored to 'str' during its initialization is never read
 */
- (void)leakTwo {
    NSString *str = [NSString string]; // 创建并初始化str，此时已经有一个内存单元保存str初始化的值
    // NSString *str; // 这样就内存不泄露，因为str是可变的，只需要先声明就行。
    // printf("str前 = %p\n",str);
    str = @"ceshi";             // str被改变了，指向了"ceshi"所在的地址，指针改变了，但之前保存初始化值的内存空间还未释放，保存str初始化值的内存单元泄露了。
    // printf("str后 = %p\n",str); // 指针改变了
    [str class];
    
    // 再举两个例子，同理
    
    NSArray *arr = [NSArray array];
    // printf("arr前 = %p\n",arr);
    // NSArray *arr;            // 这样就内存不泄露
    arr = @[@"1",@"2"];
    // printf("arr后 = %p\n",arr); // 指针改变了
    [arr class];
    
    CGRect rect = self.view.frame;
    // CGRect rect = CGRectZero; // 这样就内存不泄露
    rect = CGRectMake(0, 0, 0, 0);
    NSLog(@"rect = %@",NSStringFromCGRect(rect));
}

/**
 * 情 形 三：调用了让某个对象引用计数加1的函数，但没有调用相应让其引用计数减1的函数。
 * 提示信息：Potential leak of an object stored into 'subImageRef'
 * 翻译一下：subImageRef对象的内存单元有潜在的泄露风险
 */
- (void)leakThree {
    CGRect rect = CGRectMake(0, 0, 50, 50);
    UIImage *image;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect); // subImageRef 引用计数 + 1;
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    // 应该调用对应的函数，让subImageRef的引用计数减1,就不会泄露了
    // CGImageRelease(subImageRef);
    
    [smallImage class];
    UIGraphicsEndImageContext();
}

#pragma mark - Leaks
//Leaks是动态的内存泄露检查工具，需要一边运行程序，一边检测。
/**
 循环引用导致内存泄漏[1]
 */
- (void)CycleReferenceTest{
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    
    [arr1 addObject:arr2];
    [arr2 addObject:arr1];
    
    // 方法虽然执行完，但是因为循环引用，导致内存得不到释放
    // 解决办法：打破环！
    // 将arr1或者arr2任意一个 弱引用就OK
//    __weak typeof(arr1) weakArr1 = arr1;
//    [weakArr1 addObject:arr2];
//    [arr2 addObject:weakArr1];
    
}

/**
 vc引用block，block retain当前对象self，所以这里也形成了一个环[1]
 */
- (void)blockTest{
    NSLog(@"%s", __func__);
    // 编译器会报“Capturing 'self' strongly in this block is likely to lead to a retain cycle”
    self.block = ^{
        self.view.backgroundColor = [UIColor grayColor];
    };
}

- (void)largeNumberCycle{
    // 该循环内产生大量的临时对象，直至循环结束才释放，可能导致内存泄漏，解决方法为在循环中创建自己的autoReleasePool，及时释放占用内存大的临时变量，减少内存占用峰值。[2]
    // 45.8M
    for(int i = 0; i < 100000; i++) {
        NSString *string = @"Abc";
        string = [string lowercaseString];
        string = [string stringByAppendingString:@"xyz"];
        NSLog(@"%@", string);
    }
    
    // 45.9M
//    for(int i = 0; i < 100000; i++) {
//        @autoreleasepool {
//            NSString *string = @"Abc";
//            string = [string lowercaseString];
//            string = [string stringByAppendingString:@"xyz"];
//            NSLog(@"%@", string);
//        }
//    }
}

/**
 1.https://www.jianshu.com/p/bab76fd5bc08 iOS开发中本人或同事碰到的内存泄漏及解决办法
 2.https://www.jianshu.com/p/f5bc47607613 ios的几种内存泄漏
 */
@end
