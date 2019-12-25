//
//  ViewController.m
//  ObjcBaseDemo
//
//  Created by rodgerjluo on 2019/12/12.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import "ViewController.h"
#import "OBDNSStringDemo.h"
#import "OBDNSArrayDemo.h"
#import "OBDNSDictionaryDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 测试 case
    //[OBDNSStringDemo obdNSStringDemo];
    //[OBDNSArrayDemo obdNSArrayDemo];
    [OBDNSDictionaryDemo obdNSDictionaryDemo];
}


@end
