//
//  PhoneUtils.m
//  BookStore
//
//  Created by upon on 2019/7/24.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "PhoneUtils.h"
#import <NBPhoneNumber.h>
#import <NBPhoneNumberUtil.h>

@implementation PhoneUtils

+ (NSString *)countryCodeWithNumber:(NSString *)number {
    NSString *internationalNumber = [self parseNumber:number];
    NSString *nationNumber = nil;
    NSNumber *countryCode = [[NBPhoneNumberUtil sharedInstance] extractCountryCode:internationalNumber nationalNumber:&nationNumber];
    return [NSString stringWithFormat:@"%@", countryCode];
}

+ (NSString *)nationalNumberWithNumber:(NSString *)number {
    NSString *internationalNumber = [self parseNumber:number];
    NSString *nationNumber = nil;
    [[NBPhoneNumberUtil sharedInstance] extractCountryCode:internationalNumber nationalNumber:&nationNumber];
    return nationNumber;
}

+ (NSString *)parseNumber:(NSString *)number {
    return [self parseNumber:number withDefaultRegion:@"US"];
}

+ (NSString *)parseNumber:(NSString *)number withDefaultRegion:(NSString *)region {
    NBPhoneNumber *num = [self parse:number withDefaultRegion:region];
    if (!num) return @"";
    
    return [NSString stringWithFormat:@"%@%@", num.countryCode, num.nationalNumber];
}

+ (BOOL)isValideNumber:(NSString *)number {
    NBPhoneNumber *num = [self parse:number withDefaultRegion:@"US"];
    return [[NBPhoneNumberUtil sharedInstance] isValidNumber:num];
}

+ (NSString *)mavericks_formatPhoneNumber:(NSString *)number {
    NBPhoneNumber *num = [self parse:number withDefaultRegion:@"US"];
    NSString *nationalNumber = [self formatPhoneNumber:num withType:NBEPhoneNumberFormatNATIONAL];
    if (nationalNumber.length == 0) return @"";
    
    return [NSString stringWithFormat:@"+%@ %@", num.countryCode, nationalNumber];
}

+ (NSString *)mavericks_formatPhoneNumber:(NSString *)number withType:(NBEPhoneNumberFormat)type {
    NBPhoneNumber *num = [self parse:number withDefaultRegion:@"US"];
    return [self formatPhoneNumber:num withType:type];
}




#pragma mark - Private Method
// 号码解析，输出NBPhoneNumber格式的电话
+ (NBPhoneNumber *)parse:(NSString *)number withDefaultRegion:(NSString *)region {
    NSError *err = nil;
    NBPhoneNumber *num = [[NBPhoneNumberUtil sharedInstance] parse:number defaultRegion:region error:&err];
    if (err) {
        NSLog(@"号码解析失败, %@", err.localizedDescription);
        return nil;
    }
    return num;
}

+ (NSString *)formatPhoneNumber:(NBPhoneNumber *)number withType:(NBEPhoneNumberFormat)type {
    NSError *err = nil;
    NSString *numStr = [[NBPhoneNumberUtil sharedInstance] format:number numberFormat:type error:&err];
    if (err) return @"";
    
    return numStr;
}
@end
