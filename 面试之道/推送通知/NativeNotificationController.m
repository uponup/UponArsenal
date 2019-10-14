//
//  NativeNotificationController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/24.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "NativeNotificationController.h"
#import <UserNotifications/UserNotifications.h>
@interface NativeNotificationController ()

@end

NSString *LocalNotiReqIdentifer = @"LocalNotiReqIdentifer";

@implementation NativeNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)fireThreeAfter:(id)sender {
}
- (IBAction)fireRightNow:(id)sender {
    [self sendLocalNotification];
}


- (void)sendLocalNotification{
    NSString *title = @"本地通知";
    NSString *subTitle = @"TM_subTitle";
    NSString *body = @"这是一个本地通知";
    NSInteger badge = 1;
    NSInteger timeInterval = 5;
    NSDictionary *info = @{@"id": @"12046", @"content": @"请你回家吃饭了"};
    
    if (@available(iOS 10.0, *)) {
        //1、创建通知内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        [content setValue:@(YES) forKeyPath:@"shouldAlwaysAlertWhileAppIsForeground"];
        content.sound = [UNNotificationSound defaultSound];
        content.title = title;
        content.subtitle = subTitle;
        content.body = body;
        content.badge = @(badge);
        content.userInfo = info;
        
        //2、设置通知附件内容
        NSError *error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"notification" ofType:@".png"];
        UNNotificationAttachment *att = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
        if (error) {
            NSLog(@"attachment error: %@", error);
            return;
        }
        content.attachments = @[att];
        content.launchImageName = @"notification_icon";
        
        //3、设置声音
//        UNNotificationSound *sound = [UNNotificationSound soundNamed:@""];
//        content.sound = sound;

        //4、触发模式
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO];
        //5、设置NotificationRequest
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"" content:LocalNotiReqIdentifer trigger:trigger];
        //6、把通知加到UNUserNotificationCenter
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"错误：%@", error);
        }];
    }else{
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        
        // 1.设置触发时间（如果要立即触发，无需设置）
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
        
        // 2.设置通知标题
        localNotification.alertBody = title;
        
        // 3.设置通知动作按钮的标题
        localNotification.alertAction = @"查看";
        
        // 4.设置提醒的声音
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        // 5.设置通知的 传递的userInfo
        localNotification.userInfo = info;
        
        // 6.在规定的日期触发通知
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        // 7.立即触发一个通知
        //[[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
