//
//  IndexedTableview.m
//  面试之道
//
//  Created by 龙格 on 2019/2/2.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "IndexedTableview.h"
#import "ViewReusePool.h"

@interface IndexedTableview(){
    UIView *reuseBaseView;
    ViewReusePool *pool;
}
@end

@implementation IndexedTableview

- (void)reloadData{
    [super reloadData];
    if (reuseBaseView == nil) {
        reuseBaseView = [[UIView alloc] initWithFrame:CGRectZero];
        reuseBaseView.backgroundColor = UIColor.redColor;
        [self addSubview:reuseBaseView];
        [self.superview insertSubview:reuseBaseView aboveSubview:self];
    }
    if (pool == nil) {
        pool = [[ViewReusePool alloc] init];
    }
    [pool reset];
    [self reloadIndexView];
}
- (void)reloadIndexView{
    NSArray<NSString *> *arrayTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexedTableview:)]) {
        arrayTitles = [self.indexedDataSource indexTitlesForIndexedTableview:self];
    }
    if (!arrayTitles || arrayTitles.count == 0) {
        [reuseBaseView setHidden:YES];
        return;
    }
    NSInteger count = arrayTitles.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    for (NSInteger i=0; i<count; i++) {
        NSString *title = arrayTitles[i];
        UIButton *button = (UIButton *)[pool dequeueReusableView];
        if (button == nil) {
            //重用池中没有该view的话，就重新创建
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = UIColor.whiteColor;
            //添加到重用池中
            [pool addReusePool:button];
            NSLog(@"重新创建");
        }else{
            NSLog(@"重用了");
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        button.frame = CGRectMake(0, i*buttonHeight, buttonWidth, buttonHeight);
        [reuseBaseView addSubview:button];
    }
    [reuseBaseView setHidden:NO];
    reuseBaseView.frame = CGRectMake(self.frame.origin.x+self.frame.size.width-buttonWidth, self.frame.origin.y, buttonWidth, self.frame.size.height);
}
@end
