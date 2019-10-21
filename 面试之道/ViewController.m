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
#import "PhoneUtils.h"
#import <NBPhoneNumber.h>
#import <NBPhoneNumberUtil.h>

@interface ViewController () {
    NBEPhoneNumberFormat _type;
}
//retain是持有属性
@property (nonatomic, retain) NSString *name;
//copy是赋值属性
@property (nonatomic, copy) NSString *name2;

@property (nonatomic, strong) IBOutlet UITextField *tf;
@property (nonatomic, strong) IBOutlet UILabel *label1;
@property (nonatomic, strong) IBOutlet UILabel *label2;
@property (nonatomic, strong) IBOutlet UILabel *label3;
@property (nonatomic, strong) IBOutlet UILabel *label4;
@property (nonatomic, strong) IBOutlet UILabel *label5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self copyAndStrongDemo];
//    [self memeryDemo];
//    [self multiThread];
//    [self messageResolve];
    
    
    _type = NBEPhoneNumberFormatINTERNATIONAL;
    [self.tf addTarget:self action:@selector(tfTextChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)btn136Action:(id)sender {
    _type = NBEPhoneNumberFormatE164;
}
- (IBAction)btnInternationalAction:(id)sender {
    _type = NBEPhoneNumberFormatINTERNATIONAL;
}
- (IBAction)btnRfcAction:(id)sender {
    _type = NBEPhoneNumberFormatRFC3966;
}
- (IBAction)btnNationalAction:(id)sender {
    _type = NBEPhoneNumberFormatNATIONAL;
}


- (NSString *)parsePhoneNumberWithRegion:(NSString *)regionStr {
    NBPhoneNumber *phone = [self parse:self.tf.text withDefaultRegion:regionStr];
    
    NSError *err = nil;
    NSString *numStr = [[NBPhoneNumberUtil sharedInstance] format:phone numberFormat:_type error:&err];
    if (err) {
        NSLog(@"号码解析失败-02： %@", err);
        return @"";
    };
    
    return numStr ? numStr : @"";
}

// 号码解析，输出NBPhoneNumber格式的电话
- (NBPhoneNumber *)parse:(NSString *)number withDefaultRegion:(NSString *)region {
    NSError *err = nil;
    NBPhoneNumber *num = [[NBPhoneNumberUtil sharedInstance] parse:number defaultRegion:region error:&err];
    if (err) {
        NSLog(@"号码解析失败-01, %@", err.localizedDescription);
        return nil;
    }
    return num;
}

- (NSString *)formatPhoneNumber:(NBPhoneNumber *)number withType:(NBEPhoneNumberFormat)type {
    NSError *err = nil;
    NSString *numStr = [[NBPhoneNumberUtil sharedInstance] format:number numberFormat:type error:&err];
    if (err) return @"";
    
    return numStr;
}

- (void)tfTextChanged:(UITextField *)tf {
    
    self.label1.text = [NSString stringWithFormat:@"美国： %@", [self parsePhoneNumberWithRegion:@"US"]];
    self.label2.text = [NSString stringWithFormat:@"中国： %@", [self parsePhoneNumberWithRegion:@"CN"]];
    self.label3.text = [NSString stringWithFormat:@"英国： %@", [self parsePhoneNumberWithRegion:@"GB"]];
    self.label4.text = [NSString stringWithFormat:@"日本： %@", [self parsePhoneNumberWithRegion:@"JP"]];
    self.label5.text = [NSString stringWithFormat:@"西班牙： %@", [self parsePhoneNumberWithRegion:@"ES"]];
    
    // 美国、加拿大 +1
//    NSString *us = [PhoneUtils parseNumber:tf.text];
//    self.label1.text = [NSString stringWithFormat:@"美国：%@", us];
    
    // 中国 +86
//    NSString *cn = [PhoneUtils parseNumber:tf.text withDefaultRegion:@"CN"];
//    self.label2.text = [self parsePhoneNumberWithRegion:@"CN"];
    
    // 英国 +44
//    NSString *gb = [PhoneUtils parseNumber:tf.text withDefaultRegion:@"GB"];;
//    self.label3.text = [NSString stringWithFormat:@"英国：%@", gb];
    
    // 日本 +81
//    NSString *jp = [PhoneUtils parseNumber:tf.text withDefaultRegion:@"JP"];
//    self.label4.text = [NSString stringWithFormat:@"日本：%@", jp];
    
    // 西班牙 +34
//    NSString *es = [PhoneUtils parseNumber:tf.text withDefaultRegion:@"ES"];
//    self.label5.text = [NSString stringWithFormat:@"西班牙：%@", es];
    
    
    
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
