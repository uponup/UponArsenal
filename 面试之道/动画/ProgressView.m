//
//  ProgressView.m
//  面试之道
//
//  Created by 龙格 on 2020/2/13.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()
@property (nonatomic, strong) CAShapeLayer *layer2;

@end
@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCircle];
    }
    return self;
}

- (void)initCircle{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = 5;
    //圆环的颜色
    layer.strokeColor = [UIColor lightGrayColor].CGColor;
    //背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //设置半径为10
    CGFloat radius = (self.bounds.size.width - 5)/2.0f;
    //按照顺时针方向
    BOOL clockWise = false;
    //初始化一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:radius startAngle:0 endAngle:2.0f*M_PI clockwise:clockWise];
    layer.path = [path CGPath];
//    [self.layer addSublayer:layer];
    [self.layer insertSublayer:layer atIndex:0];
    
    self.layer2 = [CAShapeLayer new];
    self.layer2.lineWidth = 5;
    self.layer2.strokeColor = [UIColor redColor].CGColor;
    self.layer2.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.layer2];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    CGFloat radius = (self.bounds.size.width - 5)/2.0f;
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:radius startAngle:-M_PI_4 endAngle:(2*M_PI)*_progress-M_PI_4 clockwise:YES];
    
    p.lineWidth = 5.0;
    p.lineCapStyle = kCGLineCapRound;
    p.lineJoinStyle = kCGLineJoinRound;
    self.layer2.path = p.CGPath;
}

@end
