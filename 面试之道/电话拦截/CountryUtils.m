//
//  CountryUtils.m
//  CallPlus
//
//  Created by 龙格 on 2019/10/23.
//  Copyright © 2019 LiuShuo. All rights reserved.
//

#import "CountryUtils.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <YYModel/YYModel.h>

static NSArray *_countryInfos;

@implementation CountryUtils

+ (NSArray *)getAuthCountryInfos {
    if (!_countryInfos) {
        NSArray *countryCodes = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"country_allcodes.plist" ofType:nil]];
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:countryCodes.count];
        NSArray *areaDefault = [self currentAuthCountry];
        
        for (NSString *countryCode in countryCodes) {
            NSArray *strs = [countryCode componentsSeparatedByString:@"#"];
//            if (![areaDefault containsObject:strs[3]]) continue;
            NSDictionary *countryInfo = @{ @"name": strs[0],
                                           @"code": [strs[1] stringByReplacingOccurrencesOfString:@"+" withString:@""],
                                           @"flag": strs[2],
                                           @"idn": strs[3],
                                           };
            CountryInfoModel *model = [CountryInfoModel yy_modelWithDictionary:countryInfo];
            [mArray addObject:model];
        }
        _countryInfos = [mArray copy];
    }
    return _countryInfos;
}

+ (CountryInfoModel *)getCurrentCountryInfo {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    NSString *codeStr = [[carrier isoCountryCode] uppercaseString];
    if (codeStr.length == 0) codeStr = @"US";
    
    CountryInfoModel *countryInfo = nil;
    // 获取授权国家
    NSArray *infos = [self getAuthCountryInfos];
    for (CountryInfoModel *tempInfo in infos) {
        if ([codeStr isEqualToString:tempInfo.idn]) {
            countryInfo = tempInfo;
            break;
        }
    }
    
    if (!countryInfo) {
        NSDictionary *dic = @{@"name": @"United States", @"code": @"1", @"flag": @"🇺🇸", @"idn": @"US"};
        countryInfo = [CountryInfoModel yy_modelWithDictionary:dic];
    }
    
    return countryInfo;
}

+ (CountryInfoModel *)getCountryInfoWithAreaCode:(NSString *)areaCode {
    NSArray *countryInfos = [self getAuthCountryInfos];
    CountryInfoModel *countryModel = [CountryInfoModel yy_modelWithDictionary:@{@"name": @"United States", @"code": @"1", @"flag": @"🇺🇸", @"idn": @"US"}];
    for (CountryInfoModel *tempInfo in countryInfos) {
        if ([areaCode isEqualToString:tempInfo.code]) {
            countryModel = tempInfo;
            break;
        }
    }
    return countryModel;
}


#pragma mark - Private Method
// 已开通国家和地区
+ (NSArray *)currentAuthCountry {
    // 中国CN、日本JP、美国US、英国GB、澳大利亚AU
    // 目前开通了US_AU_GB_JP
//    NSString *countriesKey = [APP_DELEGATE.remoteConfig[@"auth_country"] stringValue];
//    return  [countriesKey componentsSeparatedByString:@"_"];
    return @[];
}


@end


@implementation CountryInfoModel

@end
