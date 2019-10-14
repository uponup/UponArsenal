//
//  DesignModeController.m
//  面试之道
//
//  Created by 龙格 on 2019/2/1.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "DesignModeController.h"
#import "DomesticDuck.h"
#import "MallardDuck.h"

#import "Espresso.h"
#import "Milk.h"
#import "Mocha.h"
@interface DesignModeController ()

@end

@implementation DesignModeController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self strategyPattern];
    [self decoratorPattern];
}
//策略模式
- (void)strategyPattern{
    DomesticDuck *duck1 = [[DomesticDuck alloc] init];
    [duck1 fly];
    [duck1 quack];
    
    MallardDuck *duck2 = [[MallardDuck alloc] init];
    [duck2 fly];
    [duck2 quack];
}
//装饰者模式
- (void)decoratorPattern{
    //想要一杯玛奇诺（由咖啡Espresso、牛奶Milk和摩卡Mocha组成），我们可以像俄罗斯套娃一样，一层一层地做
    //1、先做一杯Espresso咖啡
    id coffee = [[Espresso alloc] init];
    //2、再添加牛奶，该对象持有Espresso咖啡
    id milkCoffee = [[Milk alloc] initWithBeverage:coffee];
    //3、再添加摩卡，该对象持有Milk牛奶
    id maqinuo = [[Mocha alloc] initWithBeverage:milkCoffee];
    
    //打印最后的名字和价格
    NSLog(@"%@, 需要%.2f元", [maqinuo getName], [maqinuo cost]);
}
@end
