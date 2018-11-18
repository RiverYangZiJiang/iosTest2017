//
//  ViewController.m
//  Phase-1604
//
//  Created by 杨子江 on 4/2/16.
//  Copyright © 2016 杨子江. All rights reserved.
//

#import "PhaseViewController.h"
#import "AFNetworking.h"
#import "TFHpple.h"
/* Hpple INSTALLATION  https://github.com/topfunky/hpple
 Open your XCode project and the Hpple project.
 Drag the "Hpple" directory to your project.
 Add the libxml2.2.dylib framework to your project and search paths as described at Cocoa with Love（TARGETS-Build Settings-Header Search Paths-Debug-双击加入以下路径：$(SDKROOT)/usr/include/libxml2）
 */

/*1.要么用算法；2.要么自己背完这些单词，然后一个词组一个词组自己来写；3.对单词分类，然后上一个单词的最后一个字母和下一个单词的第一个字母要相等，以此来接龙，这个算法上相对比较好实现;4.搜集大量儿歌，提取出里面的词汇和对应的句子，如apple tree 里用到了Apple round、apple sweet在有道词典里的Apple单词里面是没有的，在round单词里也只能搜索到round table、round bed，无apple round这样的句式；5.一单词两三词组无句子，先用自己熟悉的方式熟悉的意思先认识这些单词，先知道先认识先有个脸熟，先把这个能力培养出来，后面的学习才会事半功倍*/
@interface PhaseViewController ()
@property (nonatomic, strong) TFHpple *doc;
@property (nonatomic, strong) NSMutableArray *words;
@property (nonatomic, strong) NSMutableArray *phases;

// 所有词组，包括短语和词组短语
@property (nonatomic, strong) NSMutableArray *phasesArray;
// 所有带空格的单词
@property (nonatomic, strong) NSMutableArray *wordsWithBlankArray;
// 所有词组的字典，包括短语和词组短语
@property (nonatomic, strong) NSMutableDictionary *phasesDict;

@end

@implementation PhaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *words = @[@"age", @"belly", @"raise", @"away", @"remove", @"act", @"ABC", @"balloon"];
//    NSArray *words = @[@"accessible"];
//    [self TFHapple:words];
 
    // 五星到一星的顺序排列
//    [self wordOfKeLinSiWithExplanation];
//    [self wordOfKeLinSi];

    
//    [self wordOfKeLinSiAllStarAllWords];
    
    [self phaseOfAllWords];
//    [self filterKeys];
    
//    [self checkPhaseOfAllWords];
    
//    [self wordChain];
    
//    NSArray *array = [NSArray arrayWithContentsOfFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/coca20000-1Arrary.plist"];
//    [array writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/coca20000-1Arrary" atomically:YES];
}


/**
 五星到三星的带有解释的单词，EmptyFileKeLinSiWithExplanation
 */
- (void)wordOfKeLinSiWithExplanation{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EmptyFileKeLinSiWithExplanation" ofType:nil];
    NSMutableString *string = [[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    NSLog(@"string = %@", string);
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    NSLog(@"array.count = %lu", (unsigned long)array.count);
    NSMutableArray *words = [NSMutableArray array];
    // 去除空字符串
    for (NSString *word in array) {
        if (word.length > 0) {
            [words addObject:word];
        }
    }
    NSLog(@"words.count = %lu", (unsigned long)words.count);
    
    // 从“weaken['wi:kәn]vt削弱”格式中抽取出单词
    for (NSString *word in words){
        NSArray *arrayTemp = [word componentsSeparatedByString:@"["];
        [self.words addObject:arrayTemp[0]];
    }
    NSLog(@"%s, self.words.count = %lu", __func__, (unsigned long)self.words.count);
}


/**
 柯林斯一星到五星的词汇被分开处理了，二星到一星的无解释的单词，EmptyFileKeLinSi
 */
- (void)wordOfKeLinSi{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"kelinsi" ofType:@"rtf"];  // 带文件前缀
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"File" ofType:@"strings"];  // StringFile会报错
    NSString *path = [[NSBundle mainBundle] pathForResource:@"coca20000-1" ofType:nil];  //
    NSMutableString *string = [[NSMutableString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"string = %@", string);
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    NSLog(@"array.count = %lu", (unsigned long)array.count);
    
    // 去除空字符串
    for (NSString *word in array) {
        if (word.length > 0) {
            [self.words addObject:word];
        }
    }
    NSLog(@"%s, self.words.count = %lu", __func__, (unsigned long)self.words.count);
    [self.words writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/coca20000-1.plist" atomically:YES];
}


- (void)wordOfKeLinSiAllStarAllWords{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KeLinSiAllStarAllWords" ofType:@"plist"];
    self.words = [NSMutableArray arrayWithContentsOfFile:path];
    NSLog(@"self.words.count = %lu", (unsigned long)self.words.count);
}





- (void)phaseOfAllWords{
    NSLog(@"%s begin", __func__);
    
    [self TFHapple:self.words];
    
    NSLog(@"%s end", __func__);
}

- (void)checkPhaseOfAllWords{
    NSArray *array = [NSArray arrayWithContentsOfFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/KeLinSiAllStarAllWordsAllPhasesArrary.plist"];
    NSMutableDictionary *phasesDict = [NSMutableDictionary dictionary];
    for (NSString *word in array) {
        [phasesDict setObject:word forKey:word];
    }
    NSLog(@"phasesDict.count = %lu", phasesDict.count);
}

- (void)filterKeys{
    // 过滤所有非全英文的及只有一个单词的key的词组，共137809个
    NSLog(@"%s begin", __func__);
//    NSString * word = @"^[a-zA-Z]+\\s+[a-zA-Z]+$";  // 共137809个
    NSString * word = @"^[a-zA-Z]+\\s[a-zA-Z]+$";  // 共137809个
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", word];
    NSString *path = @"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/KeLinSiAllStarAllWordsAllPhasesDictionary.plist";
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *keys = [dict allKeys];
    NSMutableArray *filteredKeys = [NSMutableArray array];
    for (NSString *key in keys) {
        if ([pre evaluateWithObject:key] == YES) {
            [filteredKeys addObject:key];
        }
    }

    [filteredKeys writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/filteredKeys.plist" atomically:YES];
     NSLog(@"%s filteredKeys.count = %lu", __func__, filteredKeys.count);
}

// 神经算法
- (void)wordChain{
    // 过滤所有非全英文的及只有一个单词的key的词组，共137809个
    NSLog(@"%s begin", __func__);
////    NSString * word = @"^[a-zA-Z]+\\s+[a-zA-Z]+$";  // 共137809个
//    NSString * word = @"^[a-zA-Z]+\\s[a-zA-Z]+$";  // 共137809个
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", word];
//    NSString *path = @"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/KeLinSiAllStarAllWordsAllPhasesDictionary.plist";
//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//    NSArray *keys = [dict allKeys];
//    NSMutableArray *filteredKeys = [NSMutableArray array];
//    for (NSString *key in keys) {
//        if ([pre evaluateWithObject:key] == YES) {
//            [filteredKeys addObject:key];
//        }
//    }
//
//    [filteredKeys writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/filteredKeys.plist" atomically:YES];
//     NSLog(@"%s filteredKeys.count = %lu", __func__, filteredKeys.count);
    
    
    // 获得filteredKeys
    NSMutableArray *filteredKeys = [[NSMutableArray alloc] initWithContentsOfFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/filteredKeys.plist"];
    NSLog(@"%s filteredKeys.count = %lu", __func__, filteredKeys.count);
    NSMutableArray *preWords = [NSMutableArray arrayWithArray:@[@"waste time", @"time machine", @"machine gun", @"gun control"]];
    for (NSInteger index = (preWords.count - 1); index >= 0; index--) {
        [filteredKeys insertObject:preWords[index] atIndex:0];
    }

    // 取词组的第一个单词和最后一个单词，分别放在不同的数组中
    NSMutableArray *firstWordKeys = [NSMutableArray array];
    NSMutableArray *lastWordKeys = [NSMutableArray array];
    for (NSString *key in filteredKeys) {
        NSArray *array = [key componentsSeparatedByString:@" "];
        [firstWordKeys addObject:array[0]];
        [lastWordKeys addObject:[array lastObject]];
    }
    [firstWordKeys writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/firstWordKeys.plist" atomically:YES];
    [lastWordKeys writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/lastWordKeys.plist" atomically:YES];
    
    // 算法1
    // 循环从lastWordKeys[0]开始，到firstWordKeys[0+1]开始匹配是否相等，找到相等的，则lastWordKey的index等于firstWordKey的i，继续循环。直到i或者index第一次大于等于lastWordKeys.count - 1，则结束循环。结论：这种循环能够得到的结果却是很少很少，一轮下来才9个，并且得到的单词词组基本不认识，难度却是不小
//    NSMutableArray *wordChain1 = [NSMutableArray array];
//    [wordChain1 addObject:filteredKeys[0]];
//    for (NSInteger index = 0; index < (lastWordKeys.count - 1); index++) {
//        NSInteger i = (index + 1);
//        for (; i < lastWordKeys.count; i++) {
//            if ([lastWordKeys[index] isEqualToString:firstWordKeys[i]]) {
//                NSLog(@"%s index = %ld, filteredKeys[i] = %@, i = %ld, filteredKeys[i] = %@", __func__, index, filteredKeys[index], i, filteredKeys[i]);
//                [wordChain1 addObject:filteredKeys[i]];
//                index = i - 1;
//                break;
//            }
//        }
//        
//        if (i >= (lastWordKeys.count - 1)) break;  // 已经算到尾，整个一轮结束，只得到9个单词
//    }
//    
//    [wordChain1 writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/wordChain.plist" atomically:YES];
//    NSLog(@"%s wordChain1.count = %lu", __func__, wordChain1.count);
    
    
    // 算法2 循环filteredKeys.count次，每次循环匹配好之后，删掉已经加过的词组，接着循环
    NSMutableArray *wordChain2 = [NSMutableArray array];
    [wordChain2 addObject:filteredKeys[0]];
    NSUInteger count = firstWordKeys.count;
    NSString *lastWord = lastWordKeys[0];
    for (NSInteger index = 0; index < (count - 1); index++) {
        NSInteger i = (index + 1);
        for (; i < count; i++) {
            if ([lastWord isEqualToString:firstWordKeys[i]]) {
                NSLog(@"%s index = %ld, filteredKeys[i] = %@, i = %ld, filteredKeys[i] = %@", __func__, index, filteredKeys[index], i, filteredKeys[i]);
                [wordChain2 addObject:filteredKeys[i]];
//                [filteredKeys removeObjectAtIndex:i];
                lastWord = lastWordKeys[i];
                break;
            }
        }
    }

    [wordChain2 writeToFile:@"/Users/yangzijiang/Desktop/code/WordChain/16040407-data/wordChain2.plist" atomically:YES];
    NSLog(@"%s wordChain2.count = %lu", __func__, wordChain2.count);
    
    // 算法3 所有词组对应的尾首接应的词组
    
    // 算法4 一棵树，从一个词组开始，遍历所有词组，叶子不重复前面的非父类的单词，这样保证每个单词最多出现两次，数据怎么保存？
    
}


/**
 最高内存消耗2.3G，共得到phasesArray.count = 178578, phasesDict.count = 154886, wordsWithBlankArray.count = 797

 @param words <#words description#>
 */
- (void)TFHapple:(NSArray *)words{
    NSLog(@"%s begin words.count = %lu", __func__, words.count);
    NSMutableArray *xlsDataMuArr = [NSMutableArray array];
    // 循环从网易有道词典搜索单词对应词组、短语
    for (NSInteger index = 0; index < 3000; index++) {
        NSString *word = words[index];
        // 测试词汇包括age、belly、raise、away、remove
        NSString *urlString = [NSString stringWithFormat:@"http://dict.youdao.com/w/%@/#keyfrom=dict.index", word];
        //        urlString = [[NSString stringWithFormat:@"http://dict.youdao.com/w/%@/#keyfrom=dict.index", word] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  // 这样会导致#转换成%23，导致查询不到结果
        //        data      = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];  // 过于消耗内存
        //        data      = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];  // 过于消耗内存
        NSURL *url = [NSURL URLWithString:urlString];  // 只要urlString中存在空格，url就为nil，从而导致使用dataWithContentsOfURL:::会产生崩溃
        if (!url)  {
            [self.wordsWithBlankArray addObject:word];
            continue;
        }
        
        //        // options参数为0比NSDataReadingUncached在此耗费内存差不多，都很高，和直接使用dataWithContentsOfURL差不多，也没感觉到有差距，
        //        data      = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached  error:nil];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        NSData  * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
        
        self.doc       = [[TFHpple alloc] initWithHTMLData:data];
        //    NSArray * elements  = [self.doc searchWithXPathQuery:@"//span[@class='contentTitle']"];
        //    NSArray * elements  = [self.doc searchWithXPathQuery:@"//p[@class='wordGroup']"];  // 还有一个近义词也有和这个同样标签的情况
        NSArray * elements  = [self.doc searchWithXPathQuery:@"//div[@id='wordGroup']"];
        NSUInteger wordGroupCount = [self filterElement:elements type:0];
        
//        elements  = [self.doc searchWithXPathQuery:@"//div[@id='webPhrase']"];
//        [self filterElement:elements type:1];
        
        // 生成Excel文档
        [xlsDataMuArr addObject:[NSString stringWithFormat:@"%ld", index]];
        [xlsDataMuArr addObject:word];
        [xlsDataMuArr addObject:[NSString stringWithFormat:@"%ld", wordGroupCount]];
//        NSLog(@"index = %ld, word = %@ ,wordGroupCount = %ld", (long)index, word, wordGroupCount);
        
        // 测试用
//        if (index == 30) break;
    }
    
    [self createXLSFile:xlsDataMuArr columnNumber:3];
    
    [self.phasesArray writeToFile:@"/Users/yangzijiang/Desktop/iOS/WordChain/coca20000-1Arrary.plist" atomically:YES];
    [self.wordsWithBlankArray writeToFile:@"/Users/yangzijiang/Desktop/iOS/WordChain/coca20000-1WithBlankArray.plist" atomically:YES];
    [self.phasesDict writeToFile:@"/Users/yangzijiang/Desktop/iOS/WordChain/coca20000-1Dictionary.plist" atomically:YES];
    NSLog(@"phasesArray.count = %lu, phasesDict.count = %lu, wordsWithBlankArray.count = %lu", self.phasesArray.count, self.phasesDict.count, self.wordsWithBlankArray.count);
    //NSLog(@"-self.phasesArray = %@", self.phasesArray);
//    NSLog(@"-self.phasesDict = %@", self.phasesDict);
    NSLog(@"%s end", __func__);

}

- (void)createXLSFile:(NSMutableArray *)xlsDataMuArr columnNumber:(NSUInteger)columnNumber {
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    NSString *fileContent = [xlsDataMuArr componentsJoinedByString:@"\t"];
    // 字符串转换为可变字符串，方便改变某些字符
    NSMutableString *muStr = [fileContent mutableCopy];
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    // 替换末尾\t
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
#warning  下面的6是列数，根据需求修改
        if ( i > 0 && (i%columnNumber == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    // 文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    // 文件路径
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xls"];
    NSLog(@"文件路径：\n%@",filePath);
    // 生成xls文件
    [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
}

- (NSUInteger)filterElement:(NSArray *)elements type:(NSUInteger)type{
    for (TFHppleElement *e in elements) {
        //        NSLog(@"[e raw] = %@", [e raw]);
        
        NSMutableString *content = [NSMutableString stringWithString:[e content]];
        //NSLog(@"-1 %@", content);
        if (type == 0) {
            [self filterWordGroupWord:content];
        }else if (type == 1){
            [self filterwWebPhraseWord:content];
        }
        
        NSArray *array = [content componentsSeparatedByString:@"+++"];
        for (NSInteger index = 0; index < array.count; index++) {
            NSString *str = array[index];
            if (index % 2 == 0) {
                if (index + 1 < array.count) {
                    NSString *word = [NSString stringWithFormat:@"%@: %@", str, array[index + 1]];
                    [self.phasesArray addObject:word];
                }
            }else{
                [self.phasesDict setObject:str forKey:array[index - 1]];
            }
        }
        return array.count / 2;
    }
    return 0;
}

/**
 过滤词组

 @param content <#content description#>
 */
- (void)filterWordGroupWord:(NSMutableString *)content{
    
    NSRange range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"\n" withString:@"+++" options:NSCaseInsensitiveSearch range:range];
    range = NSMakeRange(0, content.length);
    //NSLog(@"-2 %@", content);
    [content replaceOccurrencesOfString:@"  " withString:@"" options:NSCaseInsensitiveSearch range:range];
    range = NSMakeRange(0, content.length);
    //NSLog(@"-3 %@", content);
    [content replaceOccurrencesOfString:@"++++++" withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-4 %@", content);
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"+++ +++" withString:@"+++" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-5 %@", content);
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"+++,+++" withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-6 %@", content);  // ++++++back and belly+++[口语]+++,+++◎背与腹+++,+++◎腹背,前前后后;周身,全身,浑身上下 2.[比喻]衣食(通常用于keep someone back and belly)+++,+++◎全然地+++,+++◎背与腹；浑身上下+++,+++◎[比喻]衣食+++,+++◎腹背，前前后后+++ +++++++++belly dance+++n. 肚皮舞

    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"...+++" withString:@"===" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-71 %@", content);
    
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@".+++" withString:@"." options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-8 %@", content);  // 不能解决 act like+++举止像...+++act for+++v. 代理
    
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"===" withString:@"...+++" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-72 %@", content);
    
    
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"+++更多收起词组短语" withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-9 %@", content);
}

/**
 过滤短语

 @param content <#content description#>
 */
- (void)filterwWebPhraseWord:(NSMutableString *)content{
    
    NSRange range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"\n" withString:@"+++" options:NSCaseInsensitiveSearch range:range];
    range = NSMakeRange(0, content.length);
    //NSLog(@"-2 %@", content);
    [content replaceOccurrencesOfString:@"  " withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-3 %@", content);
    
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"++++++ ++++++" withString:@"+++" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-31 %@", content);
    
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"++++++" withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-4 %@", content);
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"+++ +++" withString:@"+++" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-5 %@", content);
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"+++,+++" withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-6 %@", content);
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@".+++" withString:@"." options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-7 %@", content);
    
    
    
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"+++短语+++ " withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-8 %@", content);
    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@"+++;+++" withString:@"；" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-9 %@", content);

    range = NSMakeRange(0, content.length);
    [content replaceOccurrencesOfString:@" +++  更多收起网络短语+++" withString:@"" options:NSCaseInsensitiveSearch range:range];
    //NSLog(@"-10 %@", content);
}


- (NSMutableArray *)words{
    if (!_words) {
//        _words = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"coca20000-1" ofType:@"plist"];
        _words = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _words;
}

- (NSMutableArray *)phasesArray{
    if (!_phasesArray) {
        _phasesArray = [NSMutableArray array];
    }
    return _phasesArray;
}

- (NSMutableArray *)wordsWithBlankArray{
    if (!_wordsWithBlankArray) {
        _wordsWithBlankArray = [NSMutableArray array];
    }
    return _wordsWithBlankArray;
}

- (NSMutableDictionary *)phasesDict{
    if (!_phasesDict) {
        _phasesDict = [NSMutableDictionary dictionary];
    }
    return _phasesDict;
}

- (void)CreatingADataTask{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURL *URL = [NSURL URLWithString:@"http://dict.youdao.com/w/abstract/#keyfrom=dict.index"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
