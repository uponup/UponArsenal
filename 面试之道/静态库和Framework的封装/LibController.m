//
//  LibController.m
//  面试之道
//
//  Created by 龙格 on 2019/2/1.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "LibController.h"
#import "Lib/include/JPLib.h"
#import <JPFramework/JPClass.h>

@interface LibController ()

@end

@implementation LibController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [JPLib jpMethod];
//    [JPClass testMethod];
    
    JPClass *clas = [[JPClass alloc] init];
    NSLog(@"clas:%@", clas);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
