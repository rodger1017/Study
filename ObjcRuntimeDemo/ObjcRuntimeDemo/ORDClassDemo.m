//
//  ORDClassDemo.m
//  ObjcRuntimeDemo
//
//  Created by rodgerjluo on 2019/12/6.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import "ORDClassDemo.h"
#import "objc/runtime.h"

@interface ORDClassDemo () {
    NSInteger _instance1;
    NSString * _instance2;
}

@property (nonatomic, assign) NSUInteger integer;

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;

@end

@implementation ORDClassDemo

+ (void)classMethod1 {

}

- (void)method1 {
     NSLog(@"call method method1");
}

- (void)method2 {

}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
     NSLog(@"arg1 : %ld, arg2 : %@", arg1, arg2);
}

@end


@implementation ORDPropertyDemo
+ (void)load
{
    map = [NSMutableDictionary dictionary];
    map[@"name1"] = @"name";
    map[@"status1"] = @"status";
    map[@"name2"] = @"name";
    map[@"status2"] = @"status";
}


- (void)speak
{
     unsigned int numberOfIvars = 0;
     Ivar *ivars = class_copyIvarList([self class], &numberOfIvars);
     for(const Ivar *p = ivars; p < ivars+numberOfIvars; p++) {
          Ivar const ivar = *p;
          ptrdiff_t offset = ivar_getOffset(ivar);
          const char *name = ivar_getName(ivar);
          NSLog(@"ORDPropertyDemo ivar name = %s, offset = %td", name, offset);
     }
     NSLog(@"my name is %p", &_name);
     NSLog(@"my name is %@", *(&_name));
}


- (void)setDataWithDict: (NSDictionary *)dict  {
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
         NSString *propertyKey = [self propertyForKey:key];
         if (propertyKey)
         {
              // objc_property_t property = class_getProperty([self class], [propertyKey UTF8String]);
              // TODO: 针对特殊数据类型做处理
              // NSString *attributeString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
              [self setValue:obj forKey:propertyKey];
         }
        NSLog(@"name:%@ status:%@", self.name, self.status);
    }];
}

- (NSString *)propertyForKey: (NSString*) key {
    return map[key];
}

@end


@implementation ORDPropertyAttributeDemo
- (instancetype)init
{
     self = [super init];
     if (self) {
          NSLog(@"ORDPropertyAttributeDemo instance = %@", self);
          void *self2 = (__bridge void *)self;
          NSLog(@"ORDPropertyAttributeDemo instance pointer = %p", &self2);
          id cls = [ORDPropertyDemo class];
          NSLog(@"Class instance address = %p", cls);
          void *obj = &cls;
          NSLog(@"Void *obj = %@", obj);
          [(__bridge id)obj speak];
     }
     return self;
}

@end


@implementation ORDPropertyDemo (Category)

- (NSString *)categoryProperty {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCategoryProperty:(NSString *)categoryProperty {
    objc_setAssociatedObject(self, @selector(categoryProperty), categoryProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


#pragma mark - Method Demo
void dynamicMethodIMP(id self, SEL _cmd) {
    NSLog(@"%@, %p", self, _cmd);
}

@implementation ORDMethodHelper

- (void)forwardTargetMethod {
    NSLog(@"%@, %p", self, _cmd);
}

- (void)forwardInvocationMethod {
    NSLog(@"%@, %p", self, _cmd);
}

@end


@interface ORDMethodDemo () {
    ORDMethodHelper *_helper;
}
@end


@implementation ORDMethodDemo
@dynamic propertyName;

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _helper = [[ORDMethodHelper alloc] init];
    }
    return self;
}


+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"resolveInstanceMethod");
    NSString *selStr = NSStringFromSelector(sel);
    if ([selStr isEqualToString:@"dynamicMethod"]) {
        // v@:表示返回值和参数，可以在苹果官网查看Type Encoding相关文档 https://developer.apple.com/library/mac/DOCUMENTATION/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
        class_addMethod([self class], sel, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    NSString *selStr = NSStringFromSelector(aSelector);
    // 将消息转发给_helper来处理
    if ([selStr isEqualToString:@"forwardMethod"]) {
        return _helper;
    }
    return [super forwardingTargetForSelector:aSelector];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSLog(@"methodSignatureForSelector");
    NSMethodSignature *signature = [super methodSignatureForSelector:sel];
    if (!signature) {
        if ([ORDMethodHelper instancesRespondToSelector:sel]) {
            signature = [ORDMethodHelper instanceMethodSignatureForSelector:sel];
        }
    }
    return signature;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation");
    if ([ORDMethodHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    }
}

@end


#pragma mark - Category Demo
@implementation NSObject (ORDCategoryDemo)
- (void)hello
{
     NSLog(@"IMP: -[NSObject(ORDCategoryDemo) hello]");
}
@end


#pragma mark - Block Demo
@implementation ORDBlockDemo
@end


#pragma mark - Method Swizzling
void (*gOriginalViewDidAppear)(id, SEL, BOOL);
@implementation UIViewController (Logging)
// 先定义一个类别，添加要 Swizzle 的方法
- (void)swizzled_viewDidAppear:(BOOL)animated
{
    // call original implementation
    [self swizzled_viewDidAppear:animated]; // Logging
    NSLog(@"%@", NSStringFromClass([self class]));
}

// 接下来实现 Swizzle 方法
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) { // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)); // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector,  method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 最后要确保在程序启动的时候调用 swizzleMethod 方法在之前的 UIViewController 的 Logging 类别里添加 +load: 方法，然后在 +load: 里把 viewDidAppear 替换掉
//+ (void)load
//{
//    swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzled_viewDidAppear:));
//}

//更简化直接用新的IMP取代原IMP，不是替换，只需要有全局的函数指针指向原IMP即可。
void newViewDidAppear(UIViewController *self, SEL _cmd, BOOL animated)
{
    // call original implementation
    gOriginalViewDidAppear(self, _cmd, animated); // Logging
    NSLog(@"%@", NSStringFromClass([self class]));
}

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(viewDidAppear:));
    gOriginalViewDidAppear = (void *)method_getImplementation(originalMethod);
    if(!class_addMethod(self, @selector(viewDidAppear:), (IMP) newViewDidAppear, method_getTypeEncoding(originalMethod))) {
        method_setImplementation(originalMethod, (IMP) newViewDidAppear);
    }
}

@end
