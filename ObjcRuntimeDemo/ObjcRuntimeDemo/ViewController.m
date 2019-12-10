//
//  ViewController.m
//  ObjcRuntimeDemo
//
//  Created by rodgerjluo on 2019/12/5.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import "ViewController.h"
#import "objc/objc.h"
#import "objc/runtime.h"
#import "ORDClassDemo.h"


@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//
//        // 通过 methodswizzling 修改了 UIViewController 的 @selecto(viewWillAppear:) 的指针使其指向了自定义的 xxx_viewWillAppear
//        SEL originalSelector = @selector(viewWillAppear:);
//        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//
//        // 如果类中不存在要替换的方法，就先用 class_addMethod 和 class_replaceMethod 函数添加和替换两个方法现。
//        // 但如果已经有了要替换的方法，就调用 method_exchangeImplementations 函数交换两个方法的 Implemenation。
//        if (didAddMethod) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
}

#pragma mark - Method Swizzling
- (void)xxx_viewWillAppear:(BOOL)animated {
    [self xxx_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 调用测试 case
    //[self runtimeLibraryDemo];
}

#pragma mark - Meta Class
- (void)runtimeMetaClassDemo {
     Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
     class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
     objc_registerClassPair(newClass);
     id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
     [instance performSelector:@selector(testMetaClass)];
}

void TestMetaClass(id self, SEL _cmd) {
     NSLog(@"This objcet is %p", self);
     NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
     Class currentClass = [self class];

     for (int i = 0; i < 4; i++) {
          NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
          // 通过objc_getClass获得对象isa，这样可以回溯到Root class及NSObject的meta class，可以看到最后指针指向的是0x0和NSObject的meta class类地址一样。
          currentClass = objc_getClass((__bridge void *)currentClass);
     }
     NSLog(@"NSObject's class is %p", [NSObject class]);
     NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}


- (void)runtimeClassDemo {
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL res3 = [(id)[ORDClassDemo class] isKindOfClass:[ORDClassDemo class]];
    BOOL res4 = [(id)[ORDClassDemo class] isMemberOfClass:[ORDClassDemo class]];
    BOOL res5 = [(id)[[NSObject alloc] init] isKindOfClass:[NSObject class]];
    BOOL res6 = [(id)[[NSObject alloc] init] isMemberOfClass:[NSObject class]];
    BOOL res7 = [(id)[[ORDClassDemo alloc] init] isKindOfClass:[ORDClassDemo class]];
    BOOL res8 = [(id)[[ORDClassDemo alloc] init] isMemberOfClass:[ORDClassDemo class]];
    NSLog(@"%d %d %d %d %d %d %d %d", res1, res2, res3, res4, res5, res6, res7, res8);
}


#pragma  mark - Class Method
- (void)runtimeClassMethodDemo {
    ORDClassDemo *ordClassDemo = [[ORDClassDemo alloc] init];
     unsigned int outCount = 0;
     Class cls = ordClassDemo.class;
     // 类名
     NSLog(@"class name: %s", class_getName(cls));
     NSLog(@"==========================================================");
     // 父类
     NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
     NSLog(@"==========================================================");
     // 是否是元类
     NSLog(@"ORDClassDemo is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
     NSLog(@"==========================================================");
     Class meta_class = objc_getMetaClass(class_getName(cls));
     NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
     NSLog(@"==========================================================");
     // 变量实例大小
     NSLog(@"instance size: %zu", class_getInstanceSize(cls));
     NSLog(@"==========================================================");
     // 成员变量
     Ivar *ivars = class_copyIvarList(cls, &outCount);
     for (int i = 0; i < outCount; i++) {
          Ivar ivar = ivars[i];
          NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
     }
     free(ivars);
     Ivar string = class_getInstanceVariable(cls, "_string");
     if (string != NULL) {
          NSLog(@"instace variable %s", ivar_getName(string));
     }
     NSLog(@"==========================================================");
     // 属性操作
     objc_property_t * properties = class_copyPropertyList(cls, &outCount);
     for (int i = 0; i < outCount; i++) {
          objc_property_t property = properties[i];
          NSLog(@"property's name: %s", property_getName(property));
     }
     free(properties);
     objc_property_t array = class_getProperty(cls, "array");
     if (array != NULL) {
          NSLog(@"property %s", property_getName(array));
     }
     NSLog(@"==========================================================");
     // 方法操作
     Method *methods = class_copyMethodList(cls, &outCount);
     for (int i = 0; i < outCount; i++) {
          Method method = methods[i];
          NSLog(@"method's signature: %s", method_getName(method));
     }
     free(methods);
     Method method1 = class_getInstanceMethod(cls, @selector(method1));
     if (method1 != NULL) {
          NSLog(@"method %s", method_getName(method1));
     }
     Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
     if (classMethod != NULL) {
          NSLog(@"class method : %s", method_getName(classMethod));
     }
     NSLog(@"ORDClassDemo is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
     IMP imp = class_getMethodImplementation(cls, @selector(method1));
     imp();
     NSLog(@"==========================================================");
     // 协议
     Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
     Protocol * protocol;
     for (int i = 0; i < outCount; i++) {
          protocol = protocols[i];
          NSLog(@"protocol name: %s", protocol_getName(protocol));
     }
     NSLog(@"ORDClassDemo is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
     NSLog(@"==========================================================");
}


#pragma mark - Creat Class
void imp_submethod1(id self, SEL _cmd) {
    NSLog(@"run sub method 1");
}

- (void)runtimeCreatClassDemo {
    Class cls = objc_allocateClassPair(ORDClassDemo.class, "ORDSubClassDemo", 0);
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
}


#pragma mark - Creat Instance
- (void)runtimeCreateInstance {
    //可以看出 class_createInstance 和 alloc 的不同
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
    id str1 = [theObject init];
    NSLog(@"%@", [str1 class]);
    id str2 = [[NSString alloc] initWithString:@"test"];
    NSLog(@"%@", [str2 class]);
}

#pragma mark - Object Method
- (void)runtimeObjectMethodDemo {
//    //把a转换成占用更多空间的子类b
//    NSObject *a = [[NSObject alloc] init];
//    id newB = object_copy(a, class_getInstanceSize(ORDClassDemo.class));
//    object_setClass(newB, ORDClassDemo.class);
//    object_dispose(a);
    
    int numClasses;
    Class * classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
         classes = malloc(sizeof(Class) * numClasses);
         numClasses = objc_getClassList(classes, numClasses);
         NSLog(@"number of classes: %d", numClasses);
         for (int i = 0; i < numClasses; i++) {
              Class cls = classes[i];
              NSLog(@"class name: %s", class_getName(cls));
         }
         free(classes);
    }
}


- (void)runtimePropertyMethodDemo {
    // 获取属性列表
    id ordClassDemo = objc_getClass("ORDClassDemo");
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(ordClassDemo, &outCount);

    unsigned int i;
    for (i = 0; i < outCount; i++) {
         objc_property_t property = properties[i];
         fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
}


- (void)runtimePropertyAttributeDemo {
    [[ORDPropertyAttributeDemo alloc] init];
}

// 不同字段映射到MyObject相同属性上
- (void)runtimePropteryIvarDemo {
    ORDPropertyDemo *ordPropertyDemo = [[ORDPropertyDemo alloc] init];
    
    // @{@"name1": "test", @"status1": @"start"}
    [ordPropertyDemo setDataWithDict:@{@"name1": @"test", @"status1": @"start"}];
    
    // @{@"name1": "test", @"status1": @"end"}
    [ordPropertyDemo setDataWithDict:@{@"name1": @"test", @"status1": @"end"}];
}


#pragma mark - Method Demo
- (void)runtimeDynamicMethodDemo {
    ORDMethodDemo *ordMethodDemo = [[ORDMethodDemo alloc] init];
    //[ordMethodDemo setPropertyName:@"dynamic"];
    [ordMethodDemo performSelector:@selector(dynamicMethod)];
    [ordMethodDemo performSelector:@selector(forwardTargetMethod)];
    [ordMethodDemo performSelector:@selector(forwardInvocationMethod)];
}


#pragma mark - Category Demo
- (void)runtimeCategoryDemo {
    [NSObject hello];
    [[NSObject new] hello];
}


#pragma mark - Block Demo
- (void)runtimeBlockDemo {
    IMP imp = imp_implementationWithBlock(^(id obj, NSString *str) {
        NSLog(@"%@", str);
    });
    class_addMethod(ORDBlockDemo.class, @selector(testBlock:), imp, "v@:@");
    ORDBlockDemo *ordBlock = [[ORDBlockDemo alloc] init];
    [ordBlock performSelector:@selector(testBlock:) withObject:@"hello world!"];
}


#pragma mark - Library Demo
- (void)runtimeLibraryDemo {
    NSLog(@"获取指定类所在动态库");
    NSLog(@"UIView's Framework: %s", class_getImageName(NSClassFromString(@"UIView")));
    NSLog(@"获取指定库或框架中所有类的类名");
    int outCount = 0;
    const char ** classes = objc_copyClassNamesForImage(class_getImageName(NSClassFromString(@"UIView")), &outCount);
    for (int i = 0; i < outCount; i++) {
         NSLog(@"class name: %s", classes[i]);
    }
}

@end
