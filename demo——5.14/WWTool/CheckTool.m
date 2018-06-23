//
//  CheckTool.m
//  HZOA
//
//  Created by hz_02 on 2018/3/28.
//  Copyright © 2018年 hz_02. All rights reserved.
//

#import "CheckTool.h"

@implementation CheckTool

#pragma mark - 邮箱校验
+(BOOL)checkForEmail:(NSString *)emailStr{
    
    NSString *regEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    if (([card evaluateWithObject:emailStr])) {
        return YES;
    }
    return NO;
}
#pragma mark - 验证手机号
+(BOOL)checkForMobilePhoneNo:(NSString *)mobilePhone{
    
    NSString *regEx = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *card = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    if (([card evaluateWithObject:mobilePhone])) {
        return YES;
    }
    return NO;
}


@end
