//
//  CallDirectoryController.m
//  面试之道
//
//  Created by 龙格 on 2019/11/20.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "CallDirectoryController.h"
#import "CallDirectoryManager.h"
#import "CountryUtils.h"
#import "PhoneUtils.h"


@interface CallDirectoryController ()

@end

@implementation CallDirectoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%zd", [[CallDirectoryManager sharedInstance] requestAuth]);
    
    [[CallDirectoryManager sharedInstance] addPhoneNumber:@"4089898876" withLabel:@""];
    //    [[CallDirectoryManager sharedInstance] addPhoneNumber:@"17611102431" withLabel:@""];
    //
    //    [[CallDirectoryManager sharedInstance] addPhoneNumber:@"17611102431" withLabel:@""];
    //
    //    [[CallDirectoryManager sharedInstance] addPhoneNumber:@"17611102431" withLabel:@""];
    //
    //    [[CallDirectoryManager sharedInstance] addPhoneNumber:@"14081112431" withLabel:@""];
    //    [[CallDirectoryManager sharedInstance] addPhoneNumber:@"17611102431" withLabel:@""];
    
}
- (IBAction)add:(id)sender {
    for (NSInteger i=16637735000; i<16637736000; i++) {
        NSString *str = [NSString stringWithFormat:@"%@", @(i)];
//        CountryInfoModel *info = [CountryUtils getCurrentCountryInfo];
        NSString *phoneNumber = [PhoneUtils parseNumber:str withDefaultRegion:@"CN"];
        if (i == 16637735029) {
            [[CallDirectoryManager sharedInstance] addPhoneNumber:phoneNumber withLabel:@"董贺傻逼"];
        }else {
            [[CallDirectoryManager sharedInstance] addPhoneNumber:phoneNumber withLabel:@"黑名单"];
        }
    }
    
    BOOL success = [[CallDirectoryManager sharedInstance] reloadExtensionContext];
    if (success) {
        NSLog(@"插入成功");
    }else {
        NSLog(@"插入失败");
    }
}

@end
