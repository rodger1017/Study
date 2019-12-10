//
//  ORDClassDemo.h
//  ObjcRuntimeDemo
//
//  Created by rodgerjluo on 2019/12/6.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

#pragma mark - Class Demo
@interface ORDClassDemo : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;

+ (void)classMethod1;

- (void)method1;
- (void)method2;

@end


#pragma mark - Property Demo
@interface ORDPropertyDemo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString * status;

- (void)setDataWithDict: (NSDictionary *)dict;
@end

@interface ORDPropertyAttributeDemo : NSObject
@end

@interface ORDPropertyDemo (Category)
@property (nonatomic, strong) NSString *categoryProperty;
@end

//返回字典数据有不同的字段名，一般是写两个方法，但是如果灵活用runtime只用写一个方法
//定义一个映射字典（全局）
static NSMutableDictionary *map = nil;


#pragma mark - Method Demo
@interface ORDMethodHelper : NSObject

- (void)forwardTargetMethod;
- (void)forwardInvocationMethod;

@end

@interface ORDMethodDemo : NSObject

@property (nonatomic, strong)NSString *propertyName;

- (void)dynamicMethod;
- (void)forwardTargetMethod;
- (void)forwardInvocationMethod;

@end


#pragma mark - Catetory Demo
@interface NSObject (ORDCategoryDemo)
+ (void)hello;
@end


#pragma mark - Block Demo
@interface ORDBlockDemo : NSObject
@end


#pragma mark - Method Swizzling
@interface UIViewController (Logging)

@end
