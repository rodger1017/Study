//
//  OBDBasicType.h
//  ObjcBaseDemo
//
//  Created by rodgerjluo on 2019/12/13.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,strong)NSString * name;
@property (nonatomic,assign)int age;

- (id)initWithName:(NSString *)name andAge:(int)age;
- (void)printInfo;
- (void)say:(id)hello;

@end

@interface OBDBasicType : NSObject

+ (void)obdNSStringDemo;
+ (void)obdNSArrayDemo;

@end
