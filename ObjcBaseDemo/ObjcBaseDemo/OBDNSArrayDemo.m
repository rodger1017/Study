//
//  OBDNSArrayDemo.m
//  ObjcBaseDemo
//
//  Created by rodgerjluo on 2019/12/20.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import "OBDNSArrayDemo.h"

@implementation Person

- (id)initWithName:(NSString *)name andAge:(int)age
{
    if (self = [super init])
    {
        _name = name;
        _age = age;
    }
    return self;
}

-(void)printInfo {
    NSLog(@"%@", [self description]);
}

- (void)say:(id)hello {
    NSLog(@"%@ say %@", _name, hello);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"age = %d name = %@", _age, _name];
}

@end

@implementation OBDNSArrayDemo

// https://developer.apple.com/documentation/foundation/nsarray?language=objc
#pragma mark - NSArray & NSMutableArray
+ (void)obdNSArrayDemo {
    // 创建静态数组
    [self createArray];
    
    // 初始化静态数组
    [self initArray];
    
    // 查询与遍历元素
    [self queryArray];
    
    // 查询元素位置
    [self findObjectInArray];

    // 向数组元素发送消息
    [self sendMessageToArrayElements];
    
    // 数组比较
    [self compareArray];
    
    // 生成新数组
    [self deriveNewArray];
    
    // 静态数组排序
    [self sortArray];
    
    // 处理字符串数组
    [self workWithStringArrayElements];
    
    // 存储数组
    [self creatArrayDescription];
    
    // 动态数组初始化
    [self creatAndInitMutalbeArray];
    
    // 动态数组增加元素
    [self addMutableArray];
    
    // 动态数组删除元素
    [self removMutalbeArray];
    
    // 动态数组替换元素
    [self replacMutableArray];
    
    // 动态数组过滤
    [self filterMutalbeArray];
    
    // 动态数组排序
    [self sortMutableArray];
    
    
}


#pragma mark - 创建静态数组
+ (void)createArray {
    NSLog(@"***Creating an Array***");
    // 创建空数组
    NSArray *arr1 = [NSArray array];
    NSLog(@"arr1: %@", arr1);
    
    // 使用字面量创建数组
    // 注意不能用 nil, 编译报错：Collection element of type 'void *' is not an Objective-C object
    NSArray *arr2 = @[@"test", @1, @2.0];
    NSLog(@"arr2: %@", arr2);
    
    // 通过数组创建新数组
    NSArray *arr3 = [NSArray arrayWithArray:arr2];
    NSLog(@"arr3: %@", arr3);
    
    // 从文件获取
    NSString *filePath = @"./test.data";
    NSArray *arr4 = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"arr4: %@", arr4);
    NSArray *arr5 = [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    NSLog(@"arr5: %@", arr5);
    
    // 通过对象创建数组
    NSArray *arr6 = [NSArray arrayWithObject:@"test"];
    NSLog(@"arr6: %@", arr6);
    
    NSDate *aDate = [NSDate distantFuture];
    NSValue *aValue = @(5);
    NSString *aString = @"hello";
    // 不能缺少 nil， 告警提示：Missing sentinel in method dispatch
    // 运行时崩溃：Thread 1: EXC_BAD_ACCESS (code=1, address=0x40)
    NSArray *arr7 = [NSArray arrayWithObjects:aDate, aValue, aString, nil];
    NSLog(@"arr7: %@", arr7);
    
    // 通过c数组创建，取前count个元素
    NSString *strs[3];
    strs[0] = @"First";
    strs[1] = @"Second";
    strs[2] = @"Third";
    NSArray *arr8 = [NSArray arrayWithObjects:strs count:2];
    NSLog(@"arr8: %@", arr8);
}


#pragma mark - 初始化静态数组
+ (void)initArray
{
    NSLog(@"***Initializing an Array***");
    // 空数组
    NSArray *arr1 = [[NSArray alloc]init];
    NSLog(@"arr1: %@", arr1);
    // 根据数组创建数组
    NSArray *arr2 = [[NSArray alloc] initWithArray:arr1];
    NSLog(@"arr2: %@", arr2);
    NSArray *arr3 = [[NSArray alloc] initWithArray:arr2 copyItems:YES];
    NSLog(@"arr3: %@", arr3);
    
    // 从文件获取
    NSString *filePath = [self testData];
    NSArray *arr4 = [[NSArray alloc] initWithContentsOfFile:filePath];
    NSLog(@"arr4: %@", arr4);
    NSArray *arr5 = [[NSArray alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    NSLog(@"arr5: %@", arr5);
    
    // 包含多个数据的数组
    NSArray *arr6 = [[NSArray alloc] initWithObjects:@"Hello", @"World", nil];
    NSLog(@"arr6: %@", arr6);
}


#pragma mark - 查询与遍历元素
+ (void)queryArray
{
    NSLog(@"***Querying an Array***");
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", nil];
    // 判断是否存在
    NSString *str = @"Two";
    BOOL contain = [array containsObject:str];
    NSLog(@"array%@ containsObject %@", contain?@"":@" not", str);
    
    // 元素个数
    NSLog(@"array count:%lu", (unsigned long)[array count]);
    
    // 读取第一个元素
    NSLog(@"[array firstObject]: %@", [array firstObject]);
    NSLog(@"array[0]: %@", array[0]);
    
    // 读取最后一个元素
    NSLog(@"[array lastObject]: %@", [array lastObject]);
    
    // 读取第0个位置元素
    NSLog(@"[array objectAtIndex:1]: %@", [array objectAtIndex:0]);
    NSLog(@"[array objectAtIndexedSubscript:1]: %@", [array objectAtIndexedSubscript:0]);
    NSLog(@"[array objectsAtIndexes:]: %@", [array objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,2)]]);
    // 枚举遍历获取
    NSEnumerator *enumerator = [array objectEnumerator];
    id anObject;
    while (anObject = [enumerator nextObject]) {
        NSLog(@"[array objectEnumerator]: %@", anObject);
    }
    
    enumerator = [array reverseObjectEnumerator];
    while (anObject = [enumerator nextObject]) {
        NSLog(@"[array reverseObjectEnumerator]: %@", anObject);
    }
    
    // 快速遍历
    for (anObject in array) {
        NSLog(@"[array for in]: %@", anObject);
    }
    
    // 获取C组数
    id *objects;
    NSRange range = NSMakeRange(1, 2);
    objects = malloc(sizeof(id) * range.length);
    [array getObjects:objects range:range];
    for (int i = 0; i < range.length; i++) {
        NSLog(@"[array getObjects:range:][%d]: %@", i, objects[i]);
    }
    free(objects);
}


#pragma mark - 查询元素位置
+ (void)findObjectInArray
{
    NSLog(@"***Finding Objects in an Array***");
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", nil];
    NSString *two = @"Two";
    NSString *three = @"Three";
    NSRange range = NSMakeRange(1, 2);
    NSLog(@"[array indexOfObjcet:%@]:%lu", two, (unsigned long)[array indexOfObject:two]);
    NSLog(@"[array indexOfObject:%@ inRange:range]:%lu", two, (unsigned long)[array indexOfObject:two inRange:range]);
    NSLog(@"[array indexOfObjectIdenticalTo:%@]:%lu", two, (unsigned long)[array indexOfObjectIdenticalTo:two]);
    NSLog(@"[array indexOfObjectIdenticalTo:%@ inRange:range]:%lu", two, (unsigned long)[array indexOfObjectIdenticalTo:two inRange:range]);
    // 串行查找单个
    NSInteger index = [array indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:two]) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    NSLog(@"[array indexOfObjectPassingTest:...]: %lu", (unsigned long)index);
    
    // 并发查找单个
    index = [array indexOfObjectWithOptions:NSEnumerationConcurrent passingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:two]) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    NSLog(@"[array indexOfObjectWithOptions:passingTest:]: %lu", (unsigned long)index);
    
    // 串行查找多个
    NSIndexSet *set = [array indexesOfObjectsPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:two] || [obj isEqualToString:three]) {
            return YES;
        }
        return NO;
    }];
    NSLog(@"[array indexesOfObjectsPassingTest:]: %@", set);
    
    // 并发查找多个
    set = [array indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:two] || [obj isEqualToString:three]) {
            return YES;
        }
        return NO;
    }];
    NSLog(@"[array indexesOfObjectsWithOptions:passingTest:]: %@", set);
}


#pragma mark - 向数组元素发送消息
+ (void)sendMessageToArrayElements
{
    NSLog(@"***Sending Messages to Elements***");
    Person *p1 = [[Person alloc] initWithName:@"Tom" andAge:20];
    Person *p2 = [[Person alloc] initWithName:@"Jim" andAge:18];
    Person *p3 = [[Person alloc] initWithName:@"Kim" andAge:38];

    NSArray * array = [[NSArray alloc] initWithObjects:p1, p2, p3, nil];

    // 通知数组中的每个元素执行方法
    [array makeObjectsPerformSelector:@selector(printInfo)];
    
    // 携带参数发出通知
    [array makeObjectsPerformSelector:@selector(say:) withObject:@"hello"];
    
    // 串行自定义通知
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"[array enumerateObjectsUsingBlock:]: %lu", (unsigned long)idx);
        [obj say:@(idx)];
        
    }];
    
    // 并行自定义通知
    [array enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"[array enumerateObjectsWithOptions:usingBlock:]: %lu", (unsigned long)idx);
        [obj say:@(idx)];
    }];
    
    // 根据索引发出通知
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    [array enumerateObjectsAtIndexes:indexSet options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"[array enumerateObjectsAtIndexes:options:usingBlock:]: %lu", (unsigned long)idx);
        [obj say:@(idx)];
    }];
}


#pragma mark - 数组比较
+ (void)compareArray
{
    NSLog(@"***Comparing Arrays***");
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    NSArray<NSString *> *array2 = [NSArray arrayWithObjects:@"One", @"Two", nil];
    
    // 返回第一个相同的数据
    NSString *str = [array firstObjectCommonWithArray:array2];
    NSLog(@"[array firstObjectCommonWithArray:]: %@", str);
    
    // 数组内的内容是否相同
    BOOL isEqual = [array isEqualToArray:array2];
    NSLog(@"[array isEqualToArray:]: %d", isEqual);
}


#pragma mark - 生成新数组
+ (void)deriveNewArray
{
    NSLog(@"***Deriving New Arrays***");
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"One", @"Two", nil];
    
    // 添加单个数据，并生成一个新的数组
    array = [array arrayByAddingObject:@"Three"];
    NSLog(@"[array arrayByAddingObject:]: %@", array);
    
    // 添加多个数据，并返回一个新的数组
    array = [array arrayByAddingObjectsFromArray:array];
    NSLog(@"[array arrayByAddingObjectsFromArray:]: %@", array);
    
    // 通过过滤器筛选数组
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    array = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"[array filteredArrayUsingPredicate:]: %@", array);
    
    // 通过范围生成数组
    NSRange range = {0, 2};
    array = [array subarrayWithRange:range];
    NSLog(@"[array subarrayWithRange:]: %@", array);
}


#pragma mark - 数组排序
NSInteger sortByFunction(NSString * obj1, NSString * obj2, void * context)
{
    return [obj1 compare:obj2];
}


+ (void)sortArray
{
    NSLog(@"***Sorting***");
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    
    // Function 排序
    array = [array sortedArrayUsingFunction:sortByFunction context:nil];
    NSLog(@"[array sortedArrayUsingFunction:]: %@", array);
    NSData *sortedArrayHint = array.sortedArrayHint;
    array = [array sortedArrayUsingFunction:sortByFunction context:nil hint:sortedArrayHint];
    NSLog(@"[array sortedArrayUsingFunction:context:hint]: %@", array);
    
    // Selector 排序
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"[array sortedArrayUsingSelector:]: %@", array);
    
    // Block排序
    array = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"[array sortedArrayUsingComparator:^]: %@", array);
    
    // 并发block排序
    array = [array sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"[array sortedArrayWithOptions:usingComparator^]: %@", array);
}


#pragma mark - 处理字符串数组
+ (void)workWithStringArrayElements
{
    NSLog(@"***Working with String Elements***");
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    
    // 数组中的NSString元素拼接
    NSString *str = [array componentsJoinedByString:@","];
    NSLog(@"[array componentsJoinedByString:]: %@", str);
}


#pragma mark - 创建描述信息
+ (void)creatArrayDescription {
    NSLog(@"***Creating a Description***");
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    
    // 描述信息
    NSString *description = [array description];
    NSLog(@"[array description]: %@", description);
    description = [array descriptionWithLocale:nil];
    NSLog(@"[array descriptionWithLocale:]: %@", description);
    description = [array descriptionWithLocale:nil indent:1];
    NSLog(@"[array descriptionWithLocale:indent:]: %@", description);
    
    // 获取Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // 存储的路径
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    
    // 写入
    BOOL write = [array writeToFile:filePath atomically:YES];
    write = [array writeToURL:[NSURL fileURLWithPath:filePath] atomically:YES];
}

#pragma mark - 测试数据
+ (NSString *)testData {
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 测试数据
    NSArray *array = [NSArray arrayWithObjects:@"One", @"Two", nil];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    BOOL write = [array writeToFile:filePath atomically:YES]; // 输入写入
    NSLog(@"writeToFile: %d", write);
    
    return filePath;
}


#pragma mark - 动态数组初始化
+ (void)creatAndInitMutalbeArray {
    NSLog(@"***Creating and Initializing a Mutable Array***");
    NSString *filePath = [self testData];
    
    // (+)创建
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"[NSMutableArray arrayWithCapacity:]: %@", mArray);
    // 根据文件路径创建数组
    mArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    NSLog(@"[NSMutableArray arrayWithContentsOfFile:]: %@", mArray);
    mArray = [NSMutableArray arrayWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    NSLog(@"[NSMutableArray arrayWithContentsOfURL:]: %@", mArray);
    
    // (-)创建
    mArray = [[NSMutableArray alloc] initWithCapacity:1];
    NSLog(@"[[NSMutableArray alloc] initWithCapacity:]: %@", mArray);
    mArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSLog(@"[[NSMutableArray alloc] initWithContentsOfFile:]: %@", mArray);
    mArray = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    NSLog(@"[[NSMutableArray alloc] initWithContentsOfURL:[NSURL fileURLWithPath:]]: %@", mArray);
}


#pragma mark - 动态数组增加元素
+ (void)addMutableArray {
    NSLog(@"***Adding Objects***");
    NSMutableArray *mArray = [NSMutableArray array];
    NSLog(@"[mArray]: %@", mArray);
    // 增加单一数据
    [mArray addObject:@"One"];
    NSLog(@"[mArray addObject:]: %@", mArray);
    
    // 批量添加数据
    NSArray *array = [NSArray arrayWithObjects:@"Two", @"Three", nil];
    [mArray addObjectsFromArray:array];
    NSLog(@"[mArray addObjectsFromArray:]: %@", mArray);
    
    // 指定位置插入单一数据
    [mArray insertObject:@"Zero" atIndex:0];
    NSLog(@"[mArray insertObject:]: %@", mArray);
    
    // 指定位置插入多个数据
    NSRange range = {1, array.count};
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
    [mArray insertObjects:array atIndexes:indexSet];
    NSLog(@"[mArray insertObjects:atIndexes]: %@", mArray);
}


#pragma mark - 动态数组删除数据
+ (void)removMutalbeArray {
    NSLog(@"***Removing Objects***");
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", nil];
    NSLog(@"[mArray]: %@", mArray);
    // 删除所有元素
    [mArray removeAllObjects];
    NSLog(@"[mArray removeAllObjects]: %@", mArray);
    
    // 删除最后一个元素
    mArray = [NSMutableArray arrayWithObjects:@"Zero", @"One", @"Two", @"Three", @"Four", @"Five", nil];
    NSLog(@"[mArray]: %@", mArray);
    [mArray removeLastObject];
    NSLog(@"[mArray removeLastObject]: %@", mArray);
    
    // 根据位置删除对象
    [mArray removeObjectAtIndex:0];
    NSLog(@"[mArray removeObjectAtIndex]: %@", mArray);
    
    // 根据数组删除对象
    NSArray *array = [NSArray arrayWithObjects:@"Three", @"Four", nil];
    [mArray removeObjectsInArray:array];
    NSLog(@"[mArray removeObjectAtIndex]: %@", mArray);
    
    // 根据对象删除
    [mArray removeObject:@"Two"];
    NSLog(@"[mArray removeObject]: %@", mArray);
    [mArray removeObjectIdenticalTo:@"One"];
    NSLog(@"[mArray removeObjectIdenticalTo]: %@", mArray);
    
    // 删除指定范围内的对象
    NSRange range = {0, 2};// 第0个位置开始，连续2个
    mArray = [NSMutableArray arrayWithObjects:@"Zero", @"One", @"Two", @"Three", @"Four", @"Five", nil];
    NSLog(@"[mArray]: %@", mArray);
    [mArray removeObject:@"One" inRange:range];
    NSLog(@"[mArray removeObject:inRange:]: %@", mArray);
    [mArray removeObjectIdenticalTo:@"Two" inRange:range];
    NSLog(@"[mArray removeObjectIdenticalTo:inRange:]: %@", mArray);
    
    // 删除指定NSRange范围内的对象，批量删除
    [mArray removeObjectsInRange:range];
    NSLog(@"[mArray removeObjectsInRange:]: %@", mArray);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [mArray removeObjectsAtIndexes:indexSet];
    NSLog(@"[mArray removeObjectsAtIndexes:]: %@", mArray);
}


#pragma mark - 动态数组替换元素
+ (void)replacMutableArray{
    NSLog(@"***Replacing Objects***");
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    NSLog(@"[mArray]: %@", mArray);
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSRange range = {0, array.count};// 第0个位置开始，连续count个
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    
    // 指定位置替换对象
    [mArray replaceObjectAtIndex:0 withObject:@"I"];
    NSLog(@"[mArray replaceObjectAtIndex:]: %@", mArray);
    [mArray setObject:@"II" atIndexedSubscript:1];
    
    // 数组替换
    [mArray setArray:array];
    NSLog(@"[mArray setArray:]: %@", mArray);
    
    // 用array替换数组中指定位置的所有元素
    mArray = [NSMutableArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    NSLog(@"[mArray]: %@", mArray);
    [mArray replaceObjectsInRange:range withObjectsFromArray:array];
    NSLog(@"[mArray replaceObjectsInRange:withObjectsFromArray:]: %@", mArray);
    mArray = [NSMutableArray arrayWithObjects:@"I", @"II", @"III", nil];
    NSLog(@"[mArray]: %@", mArray);
    [mArray replaceObjectsAtIndexes:indexSet withObjects:array];
    NSLog(@"[mArray replaceObjectsAtIndexes:withObjects:]: %@", mArray);
    
    // 局部替换，使用array中的部分元素替换目标数组指定位置的元素
    mArray = [NSMutableArray arrayWithObjects:@"Un", @"Deux", @"Trois", nil];
    NSLog(@"[mArray]: %@", mArray);
    range.length = 2;
    [mArray replaceObjectsInRange:range withObjectsFromArray:array range:range];
    NSLog(@"[mArray replaceObjectsInRange:withObjectsFromArray:]: %@", mArray);
}


#pragma mark - 动态数组过滤
+ (void)filterMutalbeArray {
    NSLog(@"***Filtering Content***");
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    NSLog(@"[mArray]: %@", mArray);
    
    // 使用过滤器过滤数组中的元素
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        BOOL filter = NO;
        if ([@"Two" isEqualToString:evaluatedObject]) {
            filter = YES;
        }
        NSLog(@"evaluatedObject: %@ predicate: %d", evaluatedObject, filter);
        return filter;
    }];
    [mArray filterUsingPredicate:predicate];
    NSLog(@"[mArray filterUsingPredicate]: %@", mArray);
}


#pragma mark - 动态数组排序
NSInteger mSortByFunction(NSString * obj1, NSString * obj2, void * context) {
    return [obj1 compare:obj2];
}


+ (void)sortMutableArray {
    NSLog(@"***Rearranging Content***");
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSLog(@"[mArray]: %@", mArray);
    
    // 交换两个位置的数据
    [mArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    NSLog(@"[mArray exchangeObjectAtIndex:withObjectAtIndex]: %@", mArray);
    
    // 对象自带的方法排序
    [mArray sortUsingSelector:@selector(compare:)];
    NSLog(@"[mArray sortUsingSelector]: %@", mArray);
    
    // Function排序
    [mArray sortUsingFunction:mSortByFunction context:nil];
    NSLog(@"[mArray sortUsingFunction]: %@", mArray);
    
    // block排序
    [mArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"[mArray sortUsingComparator:^]: %@", mArray);
    
    // 并发排序
    [mArray sortWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSLog(@"[mArray sortWithOptions:usingComparator^]: %@", mArray);
}
@end
