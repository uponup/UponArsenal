//
//  AnimationController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/5.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController ()
@property (nonatomic, strong) IBOutlet UIView *circle1;
@property (nonatomic, strong) IBOutlet UIView *circle2;
@property (nonatomic, strong) IBOutlet UIView *circle3;
@property (nonatomic, strong) UIViewPropertyAnimator *animator;
@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self animatorDemo];
    [self animationDemo];
    [self calayerDemo];
}
- (void)animatorDemo{
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:2 curve:UIViewAnimationCurveLinear animations:^{
        self.circle1.frame = CGRectMake(self.circle1.frame.origin.x+200, self.circle1.frame.origin.y, self.circle1.frame.size.width, self.circle1.frame.size.height);
    }];
    [self.animator startAnimation];
}
- (void)animationDemo{
    [UIView animateWithDuration:2 animations:^{
        self.circle2.frame = CGRectMake(self.circle2.frame.origin.x+200, self.circle2.frame.origin.y, self.circle2.frame.size.width, self.circle2.frame.size.height);
    }];
}
- (void)calayerDemo{
    CABasicAnimation *animate = [[CABasicAnimation alloc] init];
    animate.keyPath = @"position.x";
    animate.fromValue = @(self.circle3.center.x);
    animate.toValue = @(self.circle3.center.x + 200);
    animate.duration = 2;
    [self.circle3.layer addAnimation:animate forKey:nil];
}
@end
