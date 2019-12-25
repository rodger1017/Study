//
//  OBDNSDictionaryDemo.m
//  ObjcBaseDemo
//
//  Created by rodgerjluo on 2019/12/24.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import "OBDNSDictionaryDemo.h"

@implementation OBDNSDictionaryDemo

+ (void)obdNSDictionaryDemo {
    // 创建字典
    [self creatDictionary];
    
    // 初始化字典
    [self initDictionary];
    
    // 计算个数
    [self countEntries];
    
    // 比较
    [self compareDictionaries];
    
    // 访问键和值
    [self accessKeysAndValues];
    
    // 遍历
    [self enumerateDictionary];
    
    // 排序
    [self sortDictionary];
    
    // 过滤
    [self filterDictionary];
    
    // 存储到文件
    [self storeDictionary];
    
    // 访问文件属性
    [self accessFileAttributes];
    
    // 动态字典创建与初始化
    [self createAndInitDictionary];
    
    // 动态字典添加元素
    [self addEntries];
    
    // 动态字典删除元素
    [self removeEntries];
}


#pragma mark - 创建字典
+ (void)creatDictionary
{
    NSLog(@"***Creating a Dictionary***");
    //空字典
    NSDictionary *dictionary = [NSDictionary dictionary];
    NSLog(@"[NSDictionary dictionary]: %@", dictionary);
    // 测试数据
    NSString *filePath = [self testData];
    
    // 通过文件路径创建字典
    dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"[NSDictionary dictionaryWithContentsOfFile:]: %@", dictionary);
    dictionary = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    NSLog(@"[NSDictionary dictionaryWithContentsOfURL:]: %@", dictionary);
    
    //通过字典生成一个新的字典
    dictionary = [NSDictionary dictionaryWithDictionary:dictionary];
    NSLog(@"[NSDictionary dictionaryWithDictionary:]: %@", dictionary);
    
    // 生成只有一个键-值对的字典
    dictionary = [NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
    NSLog(@"[NSDictionary dictionaryWithObject:forKey:]: %@", dictionary);
    
    // 根据两个数组合并生成包含多个键-值对的字典
    NSArray *values = [NSArray arrayWithObjects:@"value1",@"value2",nil];
    NSArray *keys = [NSArray arrayWithObjects:@"key1",@"key2",nil];
    dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSLog(@"[NSDictionary dictionaryWithObjects:forKeys:]: %@", dictionary);
    
    // 生成包含多个键-值对的字典。数据的顺序为value，key，nil
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"Key2", nil];
    NSLog(@"[NSDictionary dictionaryWithObjectsAndKeys:]: %@", dictionary);
    
    // 字面量初始化
    dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    NSLog(@"dictionary: %@", dictionary);
}


#pragma mark - 初始化字典
+ (void)initDictionary
{
    NSLog(@"***Initializing a Dictionary***");
    // 空字典
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    NSLog(@"[[NSDictionary alloc] init]: %@", dictionary);
    
    // 测试数据
    NSString *filePath = [self testData];
    
    // 通过文件路径创建字典
    dictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSLog(@"[[NSDictionary alloc] initWithContentsOfFile]: %@", dictionary);
    dictionary = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    NSLog(@"[[NSDictionary alloc] initWithContentsOfURL]: %@", dictionary);
    
    
    // 通过字典生成一个新的字典
    dictionary = [[NSDictionary alloc] initWithDictionary:dictionary];
    NSLog(@"[[NSDictionary alloc] initWithDictionary]: %@", dictionary);
    dictionary = [[NSDictionary alloc] initWithDictionary:dictionary copyItems:YES];
    NSLog(@"[[NSDictionary alloc] initWithDictionary:copyItems:]: %@", dictionary);

    // 根据两个数组合并生成包含多个键-值对的字典
    NSArray *values = [NSArray arrayWithObjects:@"value1", @"value2", nil];
    NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", nil];
    dictionary = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    NSLog(@"[[NSDictionary alloc] initWithObjects:forKeys:]: %@", dictionary);
    
    // 生成包含多个键-值对的字典。数据的顺序为value，key，nil
    dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSLog(@"[[NSDictionary alloc] initWithObjectsAndKeys:]: %@", dictionary);
}


#pragma mark - 计算个数
+ (void)countEntries
{
    NSLog(@"***Counting Entries***");
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSLog(@"[NSDictionary dictionaryWithObjectsAndKeys:]: %@", dictionary);
    
     // 字典内的key-value个数,
    NSUInteger count = [dictionary count];
    NSLog(@"[dictionary count]: %lu", (unsigned long)count);
     count = dictionary.count;
    NSLog(@"dictionary.count: %lu", (unsigned long)count);
}


#pragma mark - 比较
+ (void)compareDictionaries
{
    NSLog(@"***Comparing Dictionaries***");
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSLog(@"dictionary: %@", dictionary);
    NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSLog(@"dictionary1: %@", dictionary1);
    
    // 比较字典中的数据是否一致
    BOOL isEqual = [dictionary isEqualToDictionary:dictionary1];
    NSLog(@"[dictionary isEqualToDictionary:]: %d", isEqual);
}


#pragma mark - 访问键和值
+ (void)accessKeysAndValues
{
    NSLog(@"***Accessing Keys and Values***");
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    NSLog(@"dictionary: %@", dictionary);
    
    // 所有的keys
    NSArray *keys = dictionary.allKeys;
    NSLog(@"dictionary.allKeys: %@", keys);
    
    // 根据value获取keys，可能多个key指向
    keys = [dictionary allKeysForObject:@"value1"];
    NSLog(@"[dictionary allKeysForObject:]: %@", keys);
    
    // 所有的values
    NSArray *values = dictionary.allValues;
    NSLog(@"dictionary.values:%@", values);
    
    // 根据key提取value
    NSString *value = [dictionary objectForKey:@"key1"];
    NSLog(@"[dictionary objectForKey:]: %@", value);
    value = [dictionary valueForKey:@"key2"];
    NSLog(@"[dictionary valueForKey:]: %@", value);
    value = [dictionary objectForKeyedSubscript:@"key1"];
    NSLog(@"[dictionary objectForKeyedSubscript:]: %@", value);
    
    // 根据多个key获取多个value,如果没找到
    values = [dictionary objectsForKeys:keys notFoundMarker:@"NotFound"];
    NSLog(@"[dictionary objectsForKeys:notFoundMarker:]: %@", values);
}


#pragma mark - 遍历
+ (void)enumerateDictionary
{
    NSLog(@"***Enumerating Dictionaries***");
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    
    //遍历keys
    NSEnumerator *enumerator = [dictionary keyEnumerator];
    id key;
    while (key = [enumerator nextObject]) {
        NSLog(@"[enumerator nextObject] key: %@", key);
    }
    
    // 遍历values
    enumerator = [dictionary objectEnumerator];
    id value;
    while (value = [enumerator nextObject]) {
        NSLog(@"[enumerator nextObject] value: %@", value);
    }
    
    // 快速遍历key,value
    for (id key in dictionary) {
        id value = [dictionary objectForKey:key];
        NSLog(@"for in: %@=%@", key, value);
    }
    
    // key-value遍历
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"[dictionary enumerateKeysAndObjectsUsingBlock:] key: %@ value: %@", key, obj);
        // 当stop设为YES时，会停止遍历
        //*stop = YES;
    }];
    
    [dictionary enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"[dictionary enumerateKeysAndObjectsWithOptions:usingBlock:] key:%@ value:%@", key, obj);
        // 当stop设为YES时，会停止遍历,必须设NSEnumerationReverse
        // *stop = YES;
    }];
}


#pragma mark - 排序
+ (void)sortDictionary
{
    NSLog(@"***Sorting Dictionaries***");
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    NSLog(@"dictionary: %@", dictionary);
    
    // 使用Selector比较获取key, compare:由对象去实现
    NSArray *array = [dictionary keysSortedByValueUsingSelector:@selector(compare:)];
    NSLog(@"[dictionary keysSortedByValueUsingSelector:]: %@", array);
    
    // 使用block比较value,排序key
    array = [dictionary keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"[dictionary keysSortedByValueUsingComparator:]: %@", array);
    
    // 并发排序
    array = [dictionary keysSortedByValueWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"[dictionary keysSortedByValueWithOptions:usingComparator:]: %@", array);
}


#pragma mark - 过滤
+ (void)filterDictionary
{
    NSLog(@"***Filtering Dictionaries***");
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    NSLog(@"dictionary: %@", dictionary);
    
    // 返回过滤后的keys
    NSSet *set = [dictionary keysOfEntriesPassingTest:^BOOL(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // stop 是否停止过滤
        // return 通过yes，禁止no
        return YES;
    }];
    NSLog(@"[dictionary keysOfEntriesPassingTest:]: %@", set);
    
    // 并发过滤
    set = [dictionary keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // stop 是否停止过滤
        // return 通过yes，禁止no
        return YES;
    }];
    NSLog(@"[dictionary keysOfEntriesWithOptions:passingTest:]: %@", set);
}


#pragma mark - 存储到文件
+ (void)storeDictionary
{
    NSLog(@"***Storing Dictionaries***");
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    NSLog(@"dictionary: %@", dictionary);
    NSString *filePath = [self testData];
    NSLog(@"filePath: %@", filePath);
    
    // 根据路径存储字典
    BOOL write = [dictionary writeToFile:filePath atomically:YES];
    NSLog(@"[dictionary writeToFile:atomically:]: %d", write);
    
    write = [dictionary writeToURL:[NSURL fileURLWithPath:filePath] atomically:YES];
    NSLog(@"[dictionary writeToFile:atomically:]: %d", write);
}


#pragma mark - 访问文件属性
+ (void)accessFileAttributes {
    NSLog(@"***Accessing File Attributes***");
    
    NSString *filePath = [self testData];
    NSError *error;
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    
    // 创建时间
    NSLog(@"dictionary.fileCreationDate: %@", dictionary.fileCreationDate);
    // 是否可见
    NSLog(@"dictionary.fileExtensionHidden: %d", dictionary.fileExtensionHidden);
    // 用户组ID
    NSLog(@"dictionary.fileGroupOwnerAccountID: %@", dictionary.fileGroupOwnerAccountID);
    // 用户组名
    NSLog(@"[dictionary fileGroupOwnerAccountName]: %@", [dictionary fileGroupOwnerAccountName]);
    // HFS编码
    NSLog(@"(unsigned int)dictionary.fileHFSCreatorCode: %u", (unsigned int)dictionary.fileHFSCreatorCode);
    // HFS类型编码
    NSLog(@"(unsigned int)dictionary.fileHFSTypeCode: %u", (unsigned int)dictionary.fileHFSTypeCode);
    // 是否只读
    NSLog(@"dictionary.fileIsAppendOnly: %d", dictionary.fileIsAppendOnly);
    // 是否可修改
    NSLog(@"dictionary.fileIsImmutable: %d", dictionary.fileIsImmutable);
    // 修改时间
    NSLog(@"dictionary.fileModificationDate: %@", dictionary.fileModificationDate);
    // 所有者ID
    NSLog(@"dictionary.fileOwnerAccountID: %@", dictionary.fileOwnerAccountID);
    // 所有者名
    NSLog(@"dictionary.fileOwnerAccountName:%@", dictionary.fileOwnerAccountName);
    // Posix权限
    NSLog(@"(unsigned long)dictionary.filePosixPermissions: %lu", (unsigned long)dictionary.filePosixPermissions);
    // 文件大小
    NSLog(@"dictionary.fileSize:%llu", dictionary.fileSize);
    // 系统文件数量
    NSLog(@"(unsigned long)dictionary.fileSystemFileNumber: %lu", (unsigned long)dictionary.fileSystemFileNumber);
    // 文件系统的数量
    NSLog(@"(long)dictionary.fileSystemNumber: %ld", (long)dictionary.fileSystemNumber);
    // 文件类型
    NSLog(@"dictionary.fileType: %@", dictionary.fileType);
}


#pragma mark - 测试数据
+ (NSString *)testData {
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 测试数据
    NSArray *values = [NSArray arrayWithObjects:@"value1", @"value2", nil];
    NSArray *keys = [NSArray arrayWithObjects:@"key1", @"key2", nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    BOOL write = [dictionary writeToFile:filePath atomically:YES];
    NSLog(@"writeToFile: %d", write);
    
    return filePath;
}


#pragma mark - 动态字典创建与初始化
+ (void)createAndInitDictionary
{
    NSLog(@"***Creating and Initializing a Mutable Dictionary***");
    // 创建包含一个key-value的可变字典。
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    NSLog(@"[NSMutableDictionary dictionaryWithCapacity:]: %@", mDictionary);
    mDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSLog(@"[[NSMutableDictionary alloc] dictionaryWithCapacity:]: %@", mDictionary);
    
    // 空字典
    mDictionary = [NSMutableDictionary dictionary];
    NSLog(@"[NSMutableDictionary dictionary:]: %@", mDictionary);
    mDictionary = [[NSMutableDictionary alloc] init];
    NSLog(@"[[NSMutableDictionary alloc] init:]: %@", mDictionary);
}


#pragma mark - 动态字典添加元素
+ (void)addEntries
{
    NSLog(@"***Adding Entries to a Mutable Dictionary***");
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionary];
    NSLog(@"[NSMutableDictionary dictionary]: %@", mDictionary);
    
    //增加单一记录
    [mDictionary setObject:@"value1" forKey:@"key1"];
    NSLog(@"[mDictionary setObject:forKey]: %@", mDictionary);
    [mDictionary setObject:@"value2" forKeyedSubscript:@"key2"];
    NSLog(@"[mDictionary setObject:forKeyedSubscript]: %@", mDictionary);
    [mDictionary setValue:@"value3" forKey:@"key3"];
    NSLog(@"[mDictionary setValue:forKey]: %@", mDictionary);
    
    // 从字典中增加数据
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:@"value4" forKey:@"key4"];
    [mDictionary addEntriesFromDictionary:dictionary];
    NSLog(@"[mDictionary addEntriesFromDictionary:]: %@", mDictionary);
    
    // 用新的字典数据覆盖原有字典数据
    [mDictionary setDictionary:dictionary];
    NSLog(@"[mDictionary setDictionary:]: %@", mDictionary);
}


#pragma mark - 动态字典删除元素
+ (void)removeEntries
{
    NSLog(@"***Removing Entries From a Mutable Dictionary***");
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionary];
    NSLog(@"[NSMutableDictionary dictionary]: %@", mDictionary);

    // 添加元素
    [mDictionary setObject:@"value1" forKey:@"key1"];
    [mDictionary setObject:@"value2" forKeyedSubscript:@"key2"];
    [mDictionary setValue:@"value3" forKey:@"key3"];
    [mDictionary setValue:@"value4" forKey:@"key4"];
    NSLog(@"mDictionary: %@", mDictionary);
    
    // 根据key删除单一记录
    [mDictionary removeObjectForKey:@"key1"];
    
    NSLog(@"[mDictionary removeObjectForKey:]: %@", mDictionary);
    
    // 批量删除多个key对应的记录
    NSArray *keys = [NSArray arrayWithObjects:@"key2", @"key3", nil];
    [mDictionary removeObjectsForKeys:keys];
    NSLog(@"[mDictionary removeObjectsForKeys:]: %@", mDictionary);
    
    // 删除所有记录
    [mDictionary removeAllObjects];
    NSLog(@"[mDictionary removeAllObjects]: %@", mDictionary);
}

@end
