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
#import "TransactionDB.h"


@interface CallDirectoryController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;
@end

@implementation CallDirectoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%zd", [[CallDirectoryManager sharedInstance] requestAuth]);
}
- (IBAction)addToDB:(id)sender {
    NSInteger count = [self.tf.text integerValue] * 10000;
    NSString *number = [TransactionDB getLastNumber];
    if (number.length == 0) {
        number = @"8617600000000";
    }
    
    NSInteger startIndex = [number integerValue];
    
    NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i=startIndex+1; i<startIndex+count; i++) {
        NSString *temp = [NSString stringWithFormat:@"%zd", i];
        [contacts addObject:temp];
    }
    
    NSTimeInterval timeStart = [[NSDate date] timeIntervalSince1970];
    [TransactionDB addNumbers:contacts];
    NSTimeInterval timeEnd = [[NSDate date] timeIntervalSince1970];
    NSLog(@"===》插入%zd条数据，消耗时间：%.f", count, timeEnd-timeStart);
    
    [self showContent];
}


- (IBAction)update:(id)sender {
    BOOL success = [[CallDirectoryManager sharedInstance] reloadExtensionContext];
    if (success) {
        NSLog(@"插入成功");
    }else {
        NSLog(@"插入失败");
    }
}

- (IBAction)remove:(id)sender {
    NSLog(@">> 删除数据");
}


- (void)showContent {
    NSArray *dataArr = [TransactionDB allNumbers];
    self.labelContent.text = [NSString stringWithFormat:@"%zd", dataArr.count];
}

@end
