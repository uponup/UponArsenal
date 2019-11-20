//
//  CountryUtils.h
//  CallPlus
//
//  Created by 龙格 on 2019/10/23.
//  Copyright © 2019 LiuShuo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CountryInfoModel;
@interface CountryUtils : NSObject

/**
 获取所有国家和地区的信息
 */
+ (NSArray<CountryInfoModel *> *)getAuthCountryInfos;

/**
 获取用户国家区号
 1、优先读取sim卡
 2、其次获取
 */
+ (CountryInfoModel *)getCurrentCountryInfo;

/**
 获取国家信息
 param：国家电话代码
 */
+ (CountryInfoModel *)getCountryInfoWithAreaCode:(NSString *)areaCode;


@end

@interface CountryInfoModel : NSObject

@property (nonatomic, copy) NSString *name;     //国名
@property (nonatomic, copy) NSString *code;     //电话代码
@property (nonatomic, copy) NSString *flag;     //国旗
@property (nonatomic, copy) NSString *idn;      //国际域名

@end
