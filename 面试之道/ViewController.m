//
//  ViewController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/3.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "objc/runtime.h"
#import "JPWebController.h"
@interface ViewController ()
//retain是持有属性
@property (nonatomic, retain) NSString *name;
//copy是赋值属性
@property (nonatomic, copy) NSString *name2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self copyAndStrongDemo];
//    [self memeryDemo];
//    [self multiThread];
//    [self messageResolve];
}

- (void)copyAndStrongDemo{
    //用strong修饰NSString类型的属性的话，原本的值改变，那么该属性也会发生改变。一般而言，我们希望给某个字符串属性赋值之后，他的值不会再次改变。
    //用copy修饰字符串的话，会进行内存拷贝，从而保证原来值的改变不会影响属性的变化
    
    //编译器对copy关键字做的优化：赋值时的对象是一个可变对象的时候，会发生内存拷贝；如果不是可变对象的话，那么和strong无异，仅仅是指针的强引用
    NSMutableString *str = [NSMutableString stringWithFormat:@"Tom"];
    Person *p = [Person new];
    p.name = str;
    
    NSLog(@"1、p.name:%@ %p", p.name, p.name);
    
    [str appendString:@" Peter"];
    NSLog(@"2、p.name:%@ %p", p.name, p.name);
}
- (void)intAndIntegerDemo{
    //int只表示32位整型数据，而NSInteger会根据操作系统是32位还是64位决定地址长度
}
- (void)memeryDemo {
    //判断两个字符串是否相等不能使用 ==
    //==判断的是两个指针是否指向同一个对象
    //如果两个字符串一模一样，那么编译器会优化内存分配，让两个字符串对象指向同一个地址
    NSString *str1 = @"China";
    NSString *str2 = @"Chinaa";
    NSLog(@"===========");
    NSLog(@"%p", str1);
    NSLog(@"%p", str2);
}
- (void)multiThread{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"Wait 4 seconds...";
    [self.view addSubview:label];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:4]];
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            label.text = @"ready!";
//        }];
        label.text = @"ready!";
    }];
}

@end
