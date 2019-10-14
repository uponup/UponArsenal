//
//  PrivatePodsController.m
//  面试之道
//
//  Created by 龙格 on 2019/10/11.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "PrivatePodsController.h"
#import <JPKit/JPKit.h>

@interface PrivatePodsController ()

@end

@implementation PrivatePodsController

- (void)viewDidLoad {
    [super viewDidLoad];

    //私有库
    /*
    创建模版库：
    1、pod lib create JPFoundation
    2、将做好的类文件放到classes目录下
    3、进入Example，pod install安装创建好的pod库，检查执行效果
    4、修改podspec配置文件，打tag
    5、上传git
    6、检查私有库
    本地：pod lib lint --private
    远程：pod spec lint --private
    7、链接远程索引库
    pod repo add 远程私有库名称 远程私有库地址
    8、提交到索引库
    pod repo push JPSpec JPFoundation.podspec --verbose --use-libraries --private
    */
    
    // 使用：
    // Podfile中添加source，
    // pod相应的库名
    
    UILabel *label = [UILabel new];
    label.font = [UIFont small];
}

@end
