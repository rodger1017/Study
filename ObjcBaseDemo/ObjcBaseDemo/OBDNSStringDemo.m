//
//  OBDNSStringDemo.m
//  ObjcBaseDemo
//
//  Created by rodgerjluo on 2019/12/20.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import "OBDNSStringDemo.h"

@implementation OBDNSStringDemo

#pragma mark - NSString & NSMutableString
// https://developer.apple.com/documentation/foundation/nsstring?language=objc
+ (void)obdNSStringDemoOld {
    // 创建字符串
    NSString *str = @"test";
    NSString *str1 = [NSString new];
    NSString *str2 = [[NSString alloc] initWithString:@"test"];
    NSString *str3 = [NSString stringWithFormat:@"this is %@", @"test"];
    NSString *str4 = [[NSString alloc] initWithUTF8String:"测试"];

    // 获取字符串长度
    NSUInteger length = str.length;
    NSLog(@"%@ length:%lu", str, (unsigned long)length);
    
    // 获取字符串某个位置字符
    unichar c = [str characterAtIndex:1];
    NSLog(@"%c", c);
    
    // 截取字符串
    NSRange range = {1, 2};  //location（索引开始的位置）、length（截取的长度）
    NSString *subStr1 = [str substringWithRange:range];
    NSString *subStr2 = [str substringFromIndex:1];
    NSString *subStr3 = [str substringToIndex:2];
    NSLog(@"substr1:%@ substr2:%@ substr3:%@", subStr1, subStr2, subStr3);
    
    // 获取子字符串在字符串中的索引位置和长度
    NSRange range1 = [str rangeOfString:@"es"];
    NSRange range2 = [str rangeOfString:@"ha"]; // 如果未找到 返回{-1, 0}
    NSLog(@"range1:{%d, %d} range2:{%d, %d}", (int)range1.location, (int)range1.length, (int)range2.location, (int)range2.length);
    
    // 判断字符串内容是否相同（内容，不是地址）
    BOOL isEqual1 = [str isEqualToString:str2];
    NSLog(@"%@ is%@ equal to %@", str, isEqual1?@"":@" not", str2);
    BOOL isEqual2 = [str2 isEqualToString:str4];
    NSLog(@"%@ is%@ equal to %@", str2, isEqual2?@"":@" not", str4);
    
    // 替换字符串中的子字符串为给定的字符串
    NSString * newStr = [str stringByReplacingOccurrencesOfString: @"e" withString: @"a"];
    NSLog(@"newstr: %@", newStr);
    
    // 字符串拼接
    NSString *joinStr = [str stringByAppendingString: @" objc"];
    NSLog(@"joinstr: %@", joinStr);
    
    // 计算子字符串出现次数
    NSUInteger count = 0;
    NSString *str5 = @"testistestestask";
    NSString *str6 = @"test";

    // i=0 的时候比较123和123，i=1的时候比较23a和123，i=2的时候比较3as和123...以此类推，直到string1遍历完成
    for(int i=0; i < str5 .length - str6 .length + 1; i++) {
        // 截取字符串与之比较是否相同
        if([[str5 substringWithRange:NSMakeRange(i, str6.length)] isEqualToString:str6 ]) {
            count++;
        }
    }

    NSLog(@"%@ contains %d %@",str5, count, str6);
    
    // 根据分隔符进行拆分
    NSString *str7 = @"test1 test2";
    NSArray *array = [str7 componentsSeparatedByString:@" "];
    NSLog(@"array: %@", array);
    
    // 数字转换
    NSString *str8 = @"10";
    BOOL b = [str8 boolValue];
    int i = [str8 intValue];
    NSLog(@"b: %d i: %d", b, i);
    
    // 大小写切换
    NSString* str9 =@"hello WORLD";
    NSString *ucstr = [str9 uppercaseString];   //转成大写
    NSString *lcstr = [str9 lowercaseString];   //转成小写
    NSString *cstr = [str9 capitalizedString];  //首字母大写，其余小写
    NSLog(@"ucstr: %@ lcstr: %@ cstr: %@", ucstr, lcstr, cstr);
    
    // 编码
    NSString *str10 =@"你好啊";
    NSString *encStr = [str10 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"encstr: %@", encStr);
    
    // 解码
    NSString *str11 =@"\u5982\u4f55\u8054\u7cfb\u5ba2\u670d\u4eba\u5458\uff1f";
    NSString *decStr = [str11 stringByRemovingPercentEncoding];
    NSLog(@"decstr: %@", decStr);
    
    // 验证
    NSString *str12 = @"http:www.baidu.com";
    BOOL prefix = [str12 hasPrefix:@"http"]; //是否是以http开头
    BOOL suffix = [str12 hasSuffix:@"com"];  //文件路径是否以com结尾
    NSLog(@"prefix: %d  suffix: %d", prefix, suffix);
    
    /// NSMutableString
    NSMutableString *mstr1 = [[NSMutableString alloc] init];
    NSLog(@"before append mstr1: %@", mstr1);
    [mstr1 appendString: @"hello"];
    NSLog(@"after append mstr1: %@", mstr1);
    
    // 在指定的索引位置插入字符串
    [mstr1 insertString:@" world" atIndex:5];
    NSLog(@"after insert mstr1: %@", mstr1);
    
    // 删除指定范围的字符串
    NSRange range3 = {0, 6};
    [mstr1 deleteCharactersInRange:range3];
    NSLog(@"after delete mstr1: %@", mstr1);
}


+ (void)obdNSStringDemo {
    // 初始化字符串
    [self creatAndInitStrings];
    
    // 通过NSString路径读取文件内容
    [self createAndInitFromFile];
    
    // 通过NSURL路径读取文件内容
    [self createAndInitFromURL];
    
    // 通过NSString或NSURL路径写入NSString
    [self writeFileOrURL];
    
    // 获取字符串长度
    [self getLength];
    
    // 获取Characters和Bytes
    [self getCharactersAndBytes];
    
    // 识别和比较字符串
    [self identifyAndCompareStrings];
    
    // 获取C字符串
    [self getCString];
    
    // 增加字符串
    [self combineString];
    
    // 大小写变化
    [self changeCase];
    
    // 字符串分割
    [self divideString];
    
    // 替换字符串
    [self replaceSubstrings];
    
    // 获得共享的前缀
    [self getSharedPrefix];
    
    // 获取属猪
    [self getNumberValues];
    
    // 使用路径
    [self workWithPaths];
    
    // 使用URL
    [self workWithURLs];
    
    // 初始化动态字符串
    [self createAndInitMutableString];
    
    // 修改动态字符串
    [self modifyMutableString];
}


#pragma mark - 初始化字符串
+ (void)creatAndInitStrings
{
    NSLog(@"***Creating and Initializing Strings***");
    //空字符串
    NSString *string = [NSString string];
    NSLog(@"[NSString string]: %@", string);
    string = [[NSString alloc]init];
    NSLog(@"[[NSString alloc]init]: %@", string);
    string = @"";
    NSLog(@"string: %@", string);
    
    //通过字符串生成字符串
    string = @"Test";
    string = [NSString stringWithString:string];
    NSLog(@"[NSString stringWithString:]: %@", string);
    string = [[NSString alloc]initWithString:string];
    NSLog(@"[[NSString alloc]initWithString:]: %@", string);
    string = string;
    NSLog(@"string: %@", string);
    
    // 组合生成NSString
    string = [NSString stringWithFormat:@"This is %@", @"Test"];
    NSLog(@"[NSString stringWithFormat:]: %@", string);
    string = [[NSString alloc]initWithFormat:@"This is %@ too", @"Test"];
    NSLog(@"[[NSString alloc]initWithFormat:]: %@", string);
    
    // 通过utf-8字符串
    string = [NSString stringWithUTF8String:"测试1"];
    NSLog(@"[NSString stringWithUTF8String:]: %@", string);
    string = [[NSString alloc]initWithUTF8String:"测试2"];
    NSLog(@"[[NSString alloc]initWithUTF8String:]: %@", string);
    
    //通过C字符串
    const char *cStr = "This is 测试";
    //const char *cStr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    string = [NSString stringWithCString:cStr encoding:NSUTF8StringEncoding];
    NSLog(@"[NSString stringWithCString:encoding:]: %@", string);
    string = [[NSString alloc]initWithCString:cStr encoding:NSUTF8StringEncoding];
    NSLog(@"[[NSString alloc]initWithCString:encoding:]: %@", string);
}


#pragma mark - 测试数据
+ (NSString *)testData {
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 测试数据
    NSString *string = @"This is test";
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    NSError *error;
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
    return filePath;
}


#pragma mark - 通过NSString路径读取文件内容
+ (void)createAndInitFromFile
{
    NSLog(@"***Creating and Initializing a String from a File***");
    NSString *filePath = [self testData];
    NSError *error;
    
    // 指定编码格式读取
    NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"[NSString stringWithContentsOfFile:encoding:error]: %@", string);
    string = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"[[NSString alloc] initWithContentsOfFile:encoding:error]: %@", string);
    
    // 自动打开，并返回解析的编码模式
    NSStringEncoding enc;
    string = [NSString stringWithContentsOfFile:filePath usedEncoding:&enc error:&error];
    NSLog(@"[NSString stringWithContentsOfFile:usedEncoding:error]: %@", string);
    string = [[NSString alloc] initWithContentsOfFile:filePath usedEncoding:&enc error:&error];
    NSLog(@"[[NSString alloc] initWithContentsOfFile:usedEncoding:error]: %@", string);
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
}


#pragma mark - 通过NSURL路径读取文件内容
+ (void)createAndInitFromURL
{
    NSLog(@"***Creating and Initializing a String from an URL***");
    NSString *filePath = [self testData];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error;
    
    // 指定编码格式读取
    NSString *string = [NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"[NSString stringWithContentsOfURL:encoding:error]: %@", string);
    string = [[NSString alloc] initWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"[[NSString alloc] initWithContentsOfURL:encoding:error]: %@", string);
    
    // 自动打开，并返回解析的编码模式
    NSStringEncoding enc;
    string = [NSString stringWithContentsOfURL:fileUrl usedEncoding:&enc error:&error];
    NSLog(@"[NSString stringWithContentsOfURL:usedEncoding:error]: %@", string);
    string = [[NSString alloc] initWithContentsOfURL:fileUrl usedEncoding:&enc error:&error];
    NSLog(@"[[NSString alloc] initWithContentsOfFile:usedEncoding:error]: %@", string);
    
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
}


#pragma mark - 通过NSString或NSURL路径写入NSString
+ (void)writeFileOrURL
{
    NSLog(@"***Writing to a File or URL***");
    NSString *filePath = [self testData];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *error;
    NSString *string = @"One_Two_Three";
    
    BOOL write = [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    write = [string writeToURL:fileURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    } else {
        string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"[NSString stringWithContentsOfFile:encoding:error]:%@", string);
    }
}


#pragma mark - 获取字符串长度
+ (void)getLength
{
    NSLog(@"***Getting a String’s Length***");
    NSString *string = @"Hello World";
    
    //长度
    NSInteger length = string.length;
    NSLog(@"[string.length]: %ld", length);
    
    // 指定编码格式后的长度
    length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"[string lengthOfBytesUsingEncoding:]: %ld", length);
    
    // 返回存储时需要指定的长度
    length  = [string maximumLengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"[string maximumLengthOfBytesUsingEncoding:]: %ld",length);
}


#pragma mark - 获取Characters和Bytes
+ (void)getCharactersAndBytes
{
    NSLog(@"***Getting Characters and Bytes***");
    NSString *string = @"This is a test string";
    
    // 提取指定位置的character
    unichar uch = [string characterAtIndex:3];
    NSLog(@"[string characterAtIndex:]: %c", uch);
    
    // 提取Bytes，并返回使用的长度
    NSUInteger length = [string maximumLengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"[string maximumLengthOfBytesUsingEncoding:]: %lu", (unsigned long)length);
    const void *bytes;
    NSRange range = {0,5};
    BOOL gByte = [string getBytes:&bytes maxLength:length usedLength:&length encoding:NSUTF8StringEncoding options:NSStringEncodingConversionAllowLossy range:range remainingRange:nil];
    if(gByte) {
        NSLog(@"string getBytes:maxLength:usedLength:encoding:options:range:remainingRange:]: %lu", (unsigned long)length);
    }
}


#pragma mark - 识别和比较字符串
+ (void)identifyAndCompareStrings
{
    NSLog(@"***Identifying and Comparing Strings***");
    NSString *string = @"Hello,world";
    NSString *compareStr = @"Hello,Apple";
    
    NSRange searchRange = {0, string.length};
    
    //比较大小
    NSComparisonResult result = [string compare:compareStr];
    NSLog(@"[string compare:]: %ld", result);
    
    //前缀比较
    NSLog(@"[string hasPrefix:]: %d", [string hasPrefix:@"Hello"]);
    
    // 后缀比较
    NSLog(@"[string hasSuffix:]: %d", [string hasSuffix:@"Hello"]);
    
    //比较两个字符串是否相同:
    NSLog(@"[string isEqualToString:]: %d", [string isEqualToString:compareStr]);
    
    // 通过指定的比较模式，比较字符串
    result = [string compare:compareStr options:NSCaseInsensitiveSearch];
    NSLog(@"[string compare:options:]: %ld", (long)result);
    result = [string caseInsensitiveCompare:compareStr];
    NSLog(@"[string caseInsensitiveCompare:]: %ld", (long)result);
    
    // 添加比较范围
    result = [string compare:compareStr options:NSCaseInsensitiveSearch range:searchRange];
    NSLog(@"[string compare:options:range:]: %ld", (long)result);
    
    // 增加比较地域
    result = [string compare:compareStr options:NSCaseInsensitiveSearch range:searchRange locale:nil];
    NSLog(@"[string compare:options:range:locale:]: %ld", (long)result);
    
    // 本地化字符串，再比较
    result = [string localizedCompare:compareStr];
    NSLog(@"[string localizedCompare:]: %ld", (long)result);
    result = [string localizedStandardCompare:compareStr];
    NSLog(@"[string localizedStandardCompare:]: %ld", (long)result);
    
    // NSCaseInsensitiveSearch模式
    result = [string localizedCaseInsensitiveCompare:compareStr];
    NSLog(@"[string localizedCaseInsensitiveCompare:]: %ld", (long)result);
    
    // hash值
    NSUInteger hash = string.hash;
    NSLog(@"string.hash: %lu", (unsigned long)hash);
}


#pragma mark - 获取C字符串
+ (void)getCString
{
    NSLog(@"***Getting C Strings***");
    NSString *string = @"This is a test string";
    
    // 指定编码格式,获取C字符串
    const char *c = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"[string cStringUsingEncoding:]: %s", c);
    
    // 获取通过UTF-8转码的字符串
    const char *UTF8String = [string UTF8String];
    NSLog(@"[string UTF8String]: %s", UTF8String);
}


#pragma mark - 字符串拼接
+ (void)combineString
{
    NSLog(@"***Combining Strings***");
    NSString *string = @"This is a test ";
    
    // string后增加字符串并生成一个新的字符串
    string = [string stringByAppendingString:@"string"];
    NSLog(@"[string stringByAppendingString:]: %@", string);
    
    // string后增加组合字符串并生成一个新的字符串
    string = [string stringByAppendingFormat:@"%@",@";lalala"];
    NSLog(@"[string stringByAppendingFormat:]: %@", string);
    
    // string后增加循环字符串，stringByPaddingToLength：完毕后截取的长度；startingAtIndex：从增加的字符串第几位开始循环增加。
    string = [string stringByPaddingToLength:30 withString:@";heihei" startingAtIndex:4];
    NSLog(@"[string stringByPaddingToLength:withString:startingAtIndex]: %@", string);
}


#pragma mark - 大小写变化
+ (void)changeCase
{
    NSLog(@"***Changing Case***");
    NSString *string = @"Hello,中国;hello,world;";
    NSLocale *locale = [NSLocale currentLocale];
    
    // 单词首字母变大写
    NSString *result = string.capitalizedString;
    NSLog(@"string.capitalizedString: %@",result);
    // 指定系统环境变化
    result =  [string capitalizedStringWithLocale:locale];
    NSLog(@"[string capitalizedStringWithLocale:]: %@",result);
    
    //全变大写
    result = string.uppercaseString;
    NSLog(@"string.uppercaseString: %@",result);
    result = [string uppercaseStringWithLocale:locale];
    NSLog(@"[string uppercaseStringWithLocale:]: %@",result);
    
    // 全变小写
    result = string.lowercaseString;
    NSLog(@"string.lowercaseString: %@",result);
    result = [string lowercaseStringWithLocale:locale];
    NSLog(@"[string lowercaseStringWithLocale:]: %@",result);
}


#pragma mark - 字符串分割
+ (void)divideString
{
    NSLog(@"***Dividing Strings***");
    NSString *string = @"Hello,World;Hello,iOS;Hello,Objective-C";
    
    // 根据指定的字符串分割成数组
    NSArray<NSString *> *array = [string componentsSeparatedByString:@";"];
    NSLog(@"[string componentsSeparatedByString:]: %@", array);
    
    // 通过系统自带的分割方式分割字符串
    NSCharacterSet *set = [NSCharacterSet uppercaseLetterCharacterSet];
    array = [string componentsSeparatedByCharactersInSet:set];
    NSLog(@"[string componentsSeparatedByCharactersInSet:]: %@",array);
    
    // 返回指定位置后的字符串
    NSLog(@"[string substringFromIndex:]: %@", [string substringFromIndex:3]);
    
    // 返回指定范围的字符串
    NSRange range = {1,3};
    NSLog(@"[string substringWithRange:]: %@", [string substringWithRange:range]);
    
    // 返回指定位置前的字符串
    NSLog(@"[string substringToIndex:]: %@", [string substringToIndex:3]);
}


#pragma mark - 替换字符串
+ (void)replaceSubstrings
{
    NSLog(@"***Replacing Substrings***");
    NSString *string = @"One Two Thre Four";
    NSRange searchRange = {0, string.length};
    
    //全局替换
    string = [string stringByReplacingOccurrencesOfString:@"One" withString:@"111"];
    NSLog(@"string stringByReplacingOccurrencesOfString:withString]: %@", string);
    
    // 设置替换的模式，并设置范围
    string = [string stringByReplacingOccurrencesOfString:@"Two" withString:@"222" options:NSCaseInsensitiveSearch range:searchRange];
    NSLog(@"[string stringByReplacingOccurrencesOfString:withString:options:]: %@", string);
    
    // 将指定范围的字符串替换为指定的字符串
    string = [string stringByReplacingCharactersInRange:searchRange withString:@"0"];
    NSLog(@"[string stringByReplacingCharactersInRange:withString:]: %@", string);
}


#pragma mark - 获得共享的前缀
+ (void)getSharedPrefix
{
    NSLog(@"***Getting a Shared Prefix***");
    NSString *string = @"Hello,World";
    NSString *compareStr = @"Hello,iOS";
    
    // 返回两个字符串相同的前缀
    NSString *prefix = [string commonPrefixWithString:compareStr options:NSCaseInsensitiveSearch];
    NSLog(@"[string commonPrefixWithString:options:]: %@", prefix);
}


#pragma mark - 获取数值
+ (void)getNumberValues
{
    NSLog(@"***Getting Numeric Values***");
    NSString *string = @"123";
    
    NSLog(@"doubleValue:%.3f", string.doubleValue);
    NSLog(@"floatValue:%.2f", string.floatValue);
    NSLog(@"intValue:%d", string.intValue);
    NSLog(@"integerValue:%ld", (long)string.integerValue);
    NSLog(@"longLongValue:%lld", string.longLongValue);
    NSLog(@"boolValue:%d", string.boolValue);
}


#pragma mark - 使用路径
+ (void)workWithPaths {
    NSLog(@"***Working with Paths***");
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"paths: %@", paths);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory: %@", documentsDirectory);
    
    // 路径拆分为数组中的元素
    NSArray<NSString *> *pathComponents = documentsDirectory.pathComponents;
    // 将数组中的元素拼接为路径
    documentsDirectory = [NSString pathWithComponents:pathComponents];
    NSLog(@"[NSString pathWithComponents:]: %@", documentsDirectory);
    // 加载测试数据
    NSString *string = @"This is a test string";
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    NSLog(@"[documentsDirectory stringByAppendingPathComponent:]: %@", filePath);
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    filePath = [documentsDirectory stringByAppendingPathComponent:@"test1.plist"];
    NSLog(@"[documentsDirectory stringByAppendingPathComponent:]: %@", filePath);
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    // 寻找文件夹下包含指定扩展名的文件路径
    NSString *outputName;// 相同的前缀
    NSArray *filterTypes = [NSArray arrayWithObjects:@"txt", @"plist", nil];
    NSUInteger matches = [documentsDirectory completePathIntoString:&outputName caseSensitive:YES matchesIntoArray:&pathComponents filterTypes:filterTypes];
    NSLog(@"找到：%lu", (unsigned long)matches);
    
    // 添加路径
    filePath = [documentsDirectory stringByAppendingPathComponent:@"test"];
    NSLog(@"[documentsDirectory stringByAppendingPathComponent:]: %@", filePath);
    // 添加扩展名
    filePath = [filePath stringByAppendingPathExtension:@"plist"];
    
    // 是否绝对路径
    NSLog(@"filePath.absolutePath:%d", filePath.absolutePath);
    
    // 最后一个路径名
    NSLog(@"filePath.lastPathComponent:%@", filePath.lastPathComponent);
    
    // 扩展名
    NSLog(@"filePath.pathExtension:%@", filePath.pathExtension);
    
    // 去掉扩展名
    string = filePath.stringByDeletingPathExtension;
    NSLog(@"filePath.stringByDeletingPathExtension: %@", string);
    
    // 去掉最后一个路径
    string = filePath.stringByDeletingLastPathComponent;
    NSLog(@"filePath.stringByDeletingLastPathComponent: %@", string);
    
    // 批量增加路径，并返回生成的路径
    pathComponents = [filePath stringsByAppendingPaths:pathComponents];
    NSLog(@"[filePath stringsByAppendingPaths:]: %@", pathComponents);
    
    // 没啥用
    string = filePath.stringByExpandingTildeInPath;
    NSLog(@"filePath.stringByExpandingTildeInPath: %@", string);
    string = filePath.stringByResolvingSymlinksInPath;
    NSLog(@"filePath.stringByResolvingSymlinksInPath: %@", string);
    string = filePath.stringByStandardizingPath;
    NSLog(@"filePath.stringByStandardizingPath: %@", string);
}


#pragma mark - 使用URL
+ (void)workWithURLs {
    NSLog(@"***Working with URL Strings***");
    NSString *path = @"hello/world";
    
    NSCharacterSet *set = [NSCharacterSet controlCharacterSet];
    
    // 转%格式码
    NSString *string = [path stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSLog(@"[path stringByAddingPercentEncodingWithAllowedCharacters:]: %@",string);
    
    // 转可见
    string = string.stringByRemovingPercentEncoding;
    NSLog(@"string.stringByRemovingPercentEncoding: %@",string);
}


#pragma mark - 初始化动态字符串
+ (void)createAndInitMutableString {
    NSLog(@"***Creating and Initializing a Mutable String***");
    // 创建空字符串
    NSMutableString *mString = [NSMutableString stringWithCapacity:3];
    NSLog(@"[NSMutableString stringWithCapacity:]: %@", mString);
    
    mString = [[NSMutableString alloc] initWithCapacity:3];
    NSLog(@"[[NSMutableString alloc] initWithCapacity:]: %@", mString);
}


#pragma mark - 修改动态字符串
+ (void)modifyMutableString
{
    NSLog(@"***Modifying a String***");
    NSMutableString *mString = [NSMutableString stringWithCapacity:10];
    
    // Format添加
    [mString appendFormat:@"%@",@"Hello,"];
    NSLog(@"[mString appendFormat:]: %@", mString);
    
    //添加单一字符串
    [mString appendString:@"World"];
    NSLog(@"[mString appendString:]: %@", mString);
    
    // 删除指定范围的字符串
    NSRange range = {0,3};
    [mString deleteCharactersInRange:range];
    NSLog(@"[mString deleteCharactersInRange:]: %@", mString);
    
    // 指定位置后插入字符串
    [mString insertString:@"***" atIndex:0];
    NSLog(@"[mString insertString:]: %@", mString);
    
    // 替换指定范围的字符串
    [mString replaceCharactersInRange:range withString:@"111"];
    NSLog(@"[mString replaceCharactersInRange:withString:]: %@", mString);
    
    // 将指定范围内的字符串替换为指定的字符串，并返回替换了几次
    NSUInteger index =  [mString replaceOccurrencesOfString:@"1" withString:@"23" options:NSCaseInsensitiveSearch range:range];
    NSLog(@"[mString replaceOccurrencesOfString:withString:options:range:]: %@ index: %lu", mString, (unsigned long)index);
    
    // 字符串全替换
    [mString setString:@"lalalalala"];
    NSLog(@"[mString setString:]: %@", mString);
}

@end
