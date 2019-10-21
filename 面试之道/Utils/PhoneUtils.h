//
//  PhoneUtils.h
//  BookStore
//
//  Created by upon on 2019/7/24.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NBPhoneNumberDefines.h>

@interface PhoneUtils : NSObject

/*
 @title: 解析电话号码，将字符串号码转换成NBPhoneNumber对象，输出标准的电话号码（international number）
 @param: number：字符串电话号码。   eg：14089981234、4089981234、+14089981234
         region：国际域名缩写。    eg：美帝是US，中国CN，加拿大CA
 */
+ (NSString *)parseNumber:(NSString *)number;
+ (NSString *)parseNumber:(NSString *)number withDefaultRegion:(NSString *)region;


/*
 @title: 获取电话号码国家区号
 @param: number：电话号码（默认美国）
         eg: 4081101123、14081101123
 */
+ (NSString *)countryCodeWithNumber:(NSString *)number;
/*
 @title: 获取电话号码国家区号
 @param: number：电话号码（默认美国）
         eg: 4081101123、14081101123
 */
+ (NSString *)nationalNumberWithNumber:(NSString *)number;


/*
 @title: 判断号码是否有效
 @param: number：标准电话号码（international number）
 */
+ (BOOL)isValideNumber:(NSString *)number;


#pragma mark - PhoneNumber Formatter
/*
 @title: CallPlus 电话号码格式化    eg： +1 (408) 206-9989
 @param: number：标准电话号码（international number）
 */
+ (NSString *)mavericks_formatPhoneNumber:(NSString *)number;

/*
 @title: 格式化电话号码
 @param: type：
         NBEPhoneNumberFormatINTERNATIONAL  eg: +1 408-606-9128
         NBEPhoneNumberFormatE164           eg: +14086069128
         NBEPhoneNumberFormatRFC3966        eg: tel:+1-408-606-9128
         NBEPhoneNumberFormatNATIONAL       eg: (408) 606-9128
 */
+ (NSString *)mavericks_formatPhoneNumber:(NSString *)number withType:(NBEPhoneNumberFormat)type;

@end

