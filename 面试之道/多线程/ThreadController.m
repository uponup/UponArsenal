//
//  ThreadController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/15.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

// 多线程编程的优缺点
// 优点：
//    1、简化了编程模型
//    2、更加轻量级
//    3、提高执行效率
//    4、提高资源利用率

// 缺点：
//    1、增加了程序设计的复杂性
//    2、占用内存空间
//    3、增加了cpu的调度开销

#import "ThreadController.h"
#import <pThread.h>
#import "TicketManager.h"
#import "CustomOperation.h"

@interface ThreadController ()
@property (nonatomic, strong) TicketManager *manager;
@end

@implementation ThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[TicketManager alloc] init];
}
- (IBAction)clickAction:(id)sender {
    NSLog(@"我在主线程中执行");
//    [self pThreadDemo];
//    [self nsThread];
//    [self multiThreadDemo];
//    [self.manager startSale];
//    [self gcdDemo];
//    [self gcdGroup];
//    [self gcdEnter];
//    [self operationDemo];
    [self customOperationDemo];
}

/**
 多线程：NSOperation，自定义Operation
 */
- (void)customOperationDemo{
    CustomOperation *operationA = [[CustomOperation alloc] initWithName:@"operationA"];
    CustomOperation *operationB = [[CustomOperation alloc] initWithName:@"operationB"];
    CustomOperation *operationC = [[CustomOperation alloc] initWithName:@"operationC"];
    CustomOperation *operationD = [[CustomOperation alloc] initWithName:@"operationD"];
    
    [operationD addDependency:operationA];
    [operationA addDependency:operationC];
    [operationC addDependency:operationB];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue setMaxConcurrentOperationCount:2];
    [queue addOperation:operationA];
    [queue addOperation:operationB];
    [queue addOperation:operationC];
    [queue addOperation:operationD];
}

/**
 多线程4: NSOperation
 */
- (void)operationDemo{
    //同步，需要手动start
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationTask) object:nil];
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        for (NSInteger i=0; i<10; i++) {
//            NSLog(@"%ld", i);
//            sleep(1);
//        }
//    }];
//    [operation start];
    
    
    //异步,将operation加入队列中，不需要手动start
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}
- (void)operationTask{
    for (NSInteger i=0; i<10; i++) {
        NSLog(@"%ld", i);
        sleep(1);
    }
}

/**
 多线程3.2: 两个异步的请求
 */
- (void)gcdEnter{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.gcdEnter", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"第一个任务");
//        [self loadRequest1:^{
//            NSLog(@"第一个任务执行完毕");
//        }];
//    });
//
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"第二个任务");
//        [self loadRequest2:^{
//            NSLog(@"第二个任务执行完毕");
//        }];
//    });
//
//    dispatch_group_notify(group, queue, ^{
//        NSLog(@"完毕");
//    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSLog(@"第一个任务");
        [self loadRequest1:^{
            NSLog(@"第一个任务执行完毕");
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSLog(@"第一个任务");
        [self loadRequest2:^{
            NSLog(@"第一个任务执行完毕");
            dispatch_group_leave(group);
        }];
    });
}
/**
 多线程3.1:  dispatch_group
 */
- (void)gcdGroup{
    dispatch_queue_t queue = dispatch_queue_create("com.gcdGroup", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"子线程执行3秒");
        sleep(2);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"子线程执行3秒");
        sleep(2);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"子线程执行3秒");
        sleep(2);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"三个线程全部执行完毕");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"刷新UI");
        });
    });
}
/**
 多线程3：GCD
 */
- (void)gcdDemo{
    NSLog(@"执行GCD");
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"子线程执行3秒");
//        sleep(3);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"刷新UI");
//        });
//    });
    
    //globalQueue
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSLog(@"start task1");
//        sleep(1);
//        NSLog(@"end task1");
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"start task2");
//        sleep(1);
//        NSLog(@"end task2");
//    });
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        NSLog(@"start task3");
//        sleep(1);
//        NSLog(@"end task3");
//    });
    
    
    //自定义queue，执行三个任务（默认是串行队列，只创建一个线程）
//    dispatch_queue_t queue = dispatch_queue_create("com.queue", NULL);
    dispatch_queue_t queue = dispatch_queue_create("com.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"start task1");
        sleep(1);
        NSLog(@"end task1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"start task2");
        sleep(1);
        NSLog(@"end task2");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"start task3");
        sleep(1);
        NSLog(@"end task3");
    });
    
    //dispatch_barrier 必须在自己创建的异步线程中执行
    //dispatch_barrier_sync：同步栅栏，barrier之前添加的block任务全部执行完毕之后，才执行barrier里面的任务
    //dispatch_barrier_async：异步栅栏，不会阻挡当前线程中的任务
    
    //dispatch_apply
    //按指定的次数将指定的Block追加到指定的Dispatch Queue中,并等到全部的处理执行结束(类似for循环)
    
    //dispatch_once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    //dispatch_after
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}
/**
 多线程2.1：资源共享
 */
- (void)multiThreadDemo{
    
}

/**
 多线程2：NSThread
 */
- (void)nsThread{
    //三种初始化方法
    NSLog(@"主线程执行");
    //1、alloc init
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(runThread) object:nil];
    //设置线程名字
    [thread setName:@"zi线程"];
    //设置优先级
    [thread setThreadPriority:0.5];
    //开启线程
    [thread start];
    //2、detach
//    [NSThread detachNewThreadSelector:@selector(runThread) toTarget:self withObject:nil];
    //3、perform
//    [self performSelectorInBackground:@selector(runThread) withObject:nil];
}
- (void)runThread{
    NSLog(@"子线程执行:%@", [NSThread currentThread].name);
    for (NSInteger i=0; i<10; i++) {
        NSLog(@"%ld", i);
        sleep(1);
        if (i==9) {
            [self performSelectorOnMainThread:@selector(backMainThread) withObject:nil waitUntilDone:YES];
        }
    }
}
- (void)backMainThread{
    NSLog(@"回到主线程");
}
/**
 多线程1：pThread
 */
- (void)pThreadDemo{
    pthread_t pThread;
    pthread_create(&pThread, NULL, run, NULL);
}
void *run(void *data) {
    NSLog(@"我在子线程中执行");
    for (NSInteger i=0; i<10; i++) {
        NSLog(@"%ld", (long)i);
        sleep(1);
    }
    return NULL;
}


#pragma mark - Private Method
- (void)loadRequest1:(void(^)())block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}
- (void)loadRequest2:(void(^)())block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
    });
}
@end
