//
//  ResponeLinkController.m
//  面试之道
//
//  Created by 龙格 on 2019/2/18.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "ResponeLinkController.h"

@interface ResponeLinkController ()

@end

@implementation ResponeLinkController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIView和CALayer（设计原则：单一职责原则）
    //UIView: 为CALayer提供内容，以及负责处理触摸等事件，参与响应链
    //CALayer: 负责显示内容
    
    //事件传递机制
    /*
     1、点击屏幕，将事件加入到UIApplication管理的任务队列中
     2、传递给当前UIWindow
     3、向下分发到UIView，检查是否有能力响应这个事件
        1）调用hitTest:withEvent:
        2）调用pointInside:withEvent:
     4、如果返回yes，遍历subview（倒叙），重复以上两步。
     5、找到最终的view或者返回nil
     */
    
    //响应链
    //响应链是很多响应者组合在一起的一个链条
    //如何找到一个响应者呢？
    //一般做法是将事件顺着响应链向上传递，将事件交给上一个响应者进行处理。
    //1、判断是否是当前控制器的view，如果是控制器的view，那么响应者就是控制器
    //2、如果不是控制器的view，上一个响应者就是父控件
    
}

//代码实战：实现一个方形按钮，圆形区域可点击，四角不可点击

@end
