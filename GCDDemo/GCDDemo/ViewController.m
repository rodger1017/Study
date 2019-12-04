//
//  ViewController.m
//  GCDDemo
//
//  Created by rodgerjluo on 2019/11/29.
//  Copyright © 2019 rodgerjluo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) int ticketSurplusCount;   // 剩余火车票数

@end

@implementation ViewController {
    dispatch_semaphore_t semaphoreLock;     // 信号量
    dispatch_source_t sourceTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 测试不同case
    [self dispatchSetTargetQueueDemo];
    // [NSThread detachNewThreadSelector:@selector(dispatchSyncMainDemo) toTarget:self withObject:nil];
}

#pragma mark - 队列层级设置
/**
 * 可以设置优先级，也可以设置队列层级体系
 */
- (void)dispatchSetTargetQueueDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSetTargetQueueDemo---begin");
    dispatch_queue_t serialQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t firstQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.firstqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t secondQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.secondqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(firstQueue, serialQueue);
    dispatch_set_target_queue(secondQueue, serialQueue);
    
    dispatch_async(firstQueue, ^{
        NSLog(@"1---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.f];
    });
    dispatch_async(secondQueue, ^{
        NSLog(@"2---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
    });
    dispatch_async(secondQueue, ^{
        NSLog(@"3---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1.f];
    });
    NSLog(@"dispatchSetTargetQueueDemo---end");
}


#pragma mark - 任务+队列
/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)dispatchSyncConcurrentDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSyncConcurrentDemo---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.rodgerjluo.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchSyncConcurrentDemo---end");
}


/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
- (void)dispatchAsyncConcurrentDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchAsyncConcurrentDemo---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.rodgerjluo.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchAsyncConcurrentDemo---end");
}


/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)dispatchSyncSerialDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSyncSerialDemo---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchSyncSerialDemo---end");
}


/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)dispatchAsyncSerialDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchAsyncSerialDemo---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchAsyncSerialDemo---end");
}


/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)dispatchSyncMainDemo {
    
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSyncMainDemo---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchSyncMainDemo---end");
}


/**
 * 异步执行 + 主队列
 * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
 */
- (void)dispatchAsyncMainDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchAsyncMainDemo---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchAsyncMainDemo---end");
}


#pragma mark - 线程间通信
/**
 * 线程间通信
 */
- (void)dispatchCommunicationDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchCommunicationDemo---begin");
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        // 异步追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);      // 打印当前线程
        
        // 回到主线程
        dispatch_async(mainQueue, ^{
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);      // 打印当前线程
        });
    });
    
    NSLog(@"dispatchCommunicationDemo---end");
}


#pragma mark - GCD 其它用法
/**
 * 一次性代码（只执行一次）dispatch_once
 */
- (void)dispatchOnceDemo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行 1 次的代码（这里面默认是线程安全的）
    });
}


/**
 * 延时执行方法 dispatch_after
 */
- (void)dispatchAfterDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchAfterDemo---begin");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0 秒后异步追加任务代码到主队列，并开始执行
        NSLog(@"after---%@", [NSThread currentThread]);  // 打印当前线程
    });
    
    NSLog(@"dispatchAfterDemo---end");
}


/**
 * 快速迭代方法 dispatch_apply
 */
- (void)dispatchApplyDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchApplyDemo---begin");
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_apply(5, concurrentQueue, ^(size_t i) {
            NSLog(@"%zu---%@", i, [NSThread currentThread]);
        });
    });
    NSLog(@"dispatchApplyDemo---end");
    //注意：dispatch_apply 会阻塞主线程。这个 log 打印会在 dispatch_apply 都结束后才开始执行，但是使用 dispatch_async 包一下就不会阻塞了。
}

/**
 * 避免线程爆炸
 */
- (void)dispatchApplyThreadExplodeDemo:(BOOL)explode {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchApplyThreadExplodeDemo---begin");
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.concurrentqueue",DISPATCH_QUEUE_CONCURRENT);
    if (explode) {
        // 有问题的情况，可能会死锁
        for (int i = 0; i < 999 ; i++) {
            dispatch_async(concurrentQueue, ^{
                NSLog(@"wrong %d---%@", i, [NSThread currentThread]);
                //do something hard
                [NSThread sleepForTimeInterval:2.f];
            });
        }
    } else {
        //会优化很多，能够利用GCD管理
        dispatch_apply(999, concurrentQueue, ^(size_t i){
            NSLog(@"correct %zu---%@", i, [NSThread currentThread]);
            //do something hard
            [NSThread sleepForTimeInterval:2.f];
        });
    }
    
    NSLog(@"dispatchApplyThreadExplodeDemo---end");
}


/**
 * 栅栏方法 dispatch_barrier_async
 */
- (void)dispatchBarrierAsyncDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchBarrierAsyncDemo---begin");
    dispatch_queue_t queue = dispatch_queue_create("com.rodgerjluo.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_barrier_async(queue, ^{
        // 追加任务 barrier
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"barrier---%@", [NSThread currentThread]);   // 打印当前线程
    });
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2.f];                  // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);             // 打印当前线程
    });
    dispatch_async(queue, ^{
        // 追加任务 4
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"4---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchBarrierAsyncDemo---end");
}


#pragma mark - Dispatch Group
/**
 * 队列组 dispatch_group_notify
 */
- (void)dispatchGroupNotifyDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchGroupNotifyDemo---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务 1、任务 2 都执行完毕后，回到主线程执行下边任务
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchGroupNotifyDemo---end");
}


/**
 * 队列组 dispatch_group_wait
 */
- (void)dispatchGroupWaitDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchGroupWaitDemo---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"dispatchGroupWaitDemo---end");
}


/**
 * 队列组 dispatch_group_enter、dispatch_group_leave
 */
- (void)dispatchGroupEnterAndLeaveDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchGroupEnterAndLeaveDemo---begin");
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程

        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
    });
    
    NSLog(@"dispatchGroupEnterAndLeaveDemo---end");
}


#pragma mark - Dispatch Block
/**
 * 创建 dispatch_block_create
 */
- (void)dispatchCreateBlockDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchCreateBlockDemo---begin");
    
    // normal way
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"1---%@", [NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, block);
    
    // QOS way
    dispatch_block_t qosBlock = dispatch_block_create_with_qos_class(0, QOS_CLASS_USER_INITIATED, -1, ^{
        NSLog(@"2---%@", [NSThread currentThread]);
    });
    dispatch_async(concurrentQueue, qosBlock);
    
    NSLog(@"dispatchCreateBlockDemo---end");
}


/**
 * 等待 dispatch_block_wait
 */
- (void)dispatchBlockWaitDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchBlockWaitDemo---begin");
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"1---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:5.f];
        NSLog(@"2---%@",  [NSThread currentThread]);
    });
    dispatch_async(serialQueue, block);
    // 设置 DISPATCH_TIME_FOREVER 会一直等到前面任务都完成
    dispatch_block_wait(block, DISPATCH_TIME_FOREVER);
    
    NSLog(@"dispatchBlockWaitDemo---end");
}


/**
 * 通知 dispatch_block_notify
 */
- (void)dispatchBlockNotifyDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchBlockNotifyDemo---begin");
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"1---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2---%@", [NSThread currentThread]);
    });
    dispatch_async(serialQueue, firstBlock);
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"3---%@", [NSThread currentThread]);
    });
    // first block执行完才在serial queue中执行second block
    dispatch_block_notify(firstBlock, serialQueue, secondBlock);
    
    NSLog(@"dispatchBlockNotifyDemo---end");
}


/**
 * 取消 dispatch_block_cancel(iOS8+)
 */
- (void)dispatchBlockCancelDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchBlockCancelDemo---begin");
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t firstBlock = dispatch_block_create(0, ^{
        NSLog(@"1---%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2---%@", [NSThread currentThread]);
    });
    dispatch_block_t secondBlock = dispatch_block_create(0, ^{
        NSLog(@"3---%@", [NSThread currentThread]);
    });
    dispatch_async(serialQueue, firstBlock);
    dispatch_async(serialQueue, secondBlock);
    // 取消secondBlock
    dispatch_block_cancel(secondBlock);
    
    NSLog(@"dispatchBlockCancelDemo---end");
}


#pragma mark - Dispatch Source
/**
 * 监视文件夹内文件变化
 */
- (void)dispatchSourceDirectoryDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSourceDirectoryDemo---begin");
    
    NSURL *directoryURL; // assume this is set to a directory
    int const fd = open([[directoryURL path] fileSystemRepresentation], O_EVTONLY);
    if (fd < 0) {
        char buffer[80];
        strerror_r(errno, buffer, sizeof(buffer));
        NSLog(@"Unable to open \"%@\": %s (%d)", [directoryURL path], buffer, errno);
        return;
    }
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fd,
                                                      DISPATCH_VNODE_WRITE | DISPATCH_VNODE_DELETE, DISPATCH_TARGET_QUEUE_DEFAULT);
    dispatch_source_set_event_handler(source, ^(){
        unsigned long const data = dispatch_source_get_data(source);
        if (data & DISPATCH_VNODE_WRITE) {
            NSLog(@"The directory changed.");
        }
        if (data & DISPATCH_VNODE_DELETE) {
            NSLog(@"The directory has been deleted.");
        }
    });
    dispatch_source_set_cancel_handler(source, ^(){
        close(fd);
    });
    dispatch_resume(source);
    // 注意需要用DISPATCH_VNODE_DELETE 去检查监视的文件或文件夹是否被删除，如果删除了就停止监听
    
    NSLog(@"dispatchSourceDirectoryDemo---end");
}


/**
 * 设置与 runloop 无关定时器
 */
// dispatch source timer demo
- (void)dispatchSourceTimerDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSourceTimerDemo---begin");
    
    // NSTimer在主线程的runloop里会在runloop切换其它模式时停止，这时就需要手动在子线程开启一个模式为NSRunLoopCommonModes的runloop，
    // 如果不想开启一个新的runloop可以用不跟runloop关联的dispatch source timer
    sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, DISPATCH_TARGET_QUEUE_DEFAULT);
    dispatch_source_set_event_handler(sourceTimer, ^(){
        NSLog(@"Time flies");
    });
    dispatch_source_set_timer(sourceTimer, DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC, 10 * NSEC_PER_MSEC);
    dispatch_resume(sourceTimer);
    
    NSLog(@"dispatchSourceTimerDemo---end");
}


#pragma mark - Dispatch Semaphore
/**
 * semaphore 线程同步
 */
- (void)dispatchSemaphoreThreadSyncDemo {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSemaphoreThreadSyncDemo---begin");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2.f];                // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        number = 100;
        
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSLog(@"dispatchSemaphoreThreadSyncDemo---end, number = %d", number);
}


/**
 * 使用 semaphore 保证线程安全
 * 初始化火车票数量、卖票窗口（非线程安全）、并开始卖票
 * safe：指定是否使用安全模式
 */
- (void)dispatchSemaphoreThreadSafeDemo:(BOOL)safe {
    NSLog(@"currentThread---%@", [NSThread currentThread]);  // 打印当前线程
    NSLog(@"dispatchSemaphoreThreadSafeDemo---begin");
    
    if (safe) {
        semaphoreLock = dispatch_semaphore_create(1);
    }
    
    self.ticketSurplusCount = 20;
    
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        if (safe) {
            [weakSelf saleTicketSafe];
        } else {
            [weakSelf saleTicketNotSafe];
        }
    });
    
    dispatch_async(queue2, ^{
        if (safe) {
            [weakSelf saleTicketSafe];
        } else {
            [weakSelf saleTicketNotSafe];
        }
    });
    
    NSLog(@"dispatchSemaphoreThreadSafeDemo---end");
}


/**
 * 售卖火车票（非线程安全）
 */
- (void)saleTicketNotSafe {
    while (1) {
        //如果还有票，继续售卖
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { // 如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}


/**
 * 售卖火车票（线程安全）
 */
- (void)saleTicketSafe {
    while (1) {
        // 相当于加锁
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
        
        // 如果还有票，继续售卖
        if (self.ticketSurplusCount > 0) {
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { // 如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            
            // 相当于解锁
            dispatch_semaphore_signal(semaphoreLock);
            break;
        }
        
        // 相当于解锁
        dispatch_semaphore_signal(semaphoreLock);
    }
}


#pragma mark - Dead Lock
- (void)deadLockCase1 {
    NSLog(@"1---%@", [NSThread currentThread]);
    // 主队列的同步线程，按照FIFO的原则（先入先出），2排在3后面会等3执行完，但因为同步线程，3又要等2执行完，相互等待成为死锁。
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2---%@", [NSThread currentThread]);
    });
    NSLog(@"3---%@", [NSThread currentThread]);
}

// Dead Lock case 2
- (void)deadLockCase2 {
    NSLog(@"1---%@", [NSThread currentThread]);
    // 3会等2，因为2在全局并行队列里，不需要等待3，这样2执行完回到主队列，3就开始执行
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2---%@", [NSThread currentThread]);
    });
    NSLog(@"3---%@", [NSThread currentThread]);
}

// Dead Lock case 3
- (void)deadLockCase3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.rodgerjluo.gcddemo.serialqueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1---%@", [NSThread currentThread]);
    dispatch_async(serialQueue, ^{
        NSLog(@"2---%@", [NSThread currentThread]);
        // 串行队列里面同步一个串行队列就会死锁
        dispatch_sync(serialQueue, ^{
            NSLog(@"3---%@", [NSThread currentThread]);
        });
        NSLog(@"4---%@", [NSThread currentThread]);
    });
    NSLog(@"5---%@", [NSThread currentThread]);
}

// Dead Lock case 4
- (void)deadLockCase4 {
    NSLog(@"1---%@", [NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2---%@", [NSThread currentThread]);
        // 将同步的串行队列放到另外一个线程就能够解决
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3---%@", [NSThread currentThread]);
        });
        NSLog(@"4---%@", [NSThread currentThread]);
    });
    NSLog(@"5---%@", [NSThread currentThread]);
}


// Dead Lock case 5
- (void)deadLockCase5 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1---%@", [NSThread currentThread]);
        // 回到主线程发现死循环后就没法执行了
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2---%@", [NSThread currentThread]);
        });
        NSLog(@"3---%@", [NSThread currentThread]);
    });
    NSLog(@"4---%@", [NSThread currentThread]);
    // 死循环
    while (1) {

    }
}

#pragma mark - 待整理



@end
