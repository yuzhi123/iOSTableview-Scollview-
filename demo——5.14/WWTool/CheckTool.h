//
//  CheckTool.h
//  HZOA
//
//  Created by hz_02 on 2018/3/28.
//  Copyright © 2018年 hz_02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckTool : NSObject

#pragma mark - 验证手机号
+(BOOL)checkForMobilePhoneNo:(NSString *)mobilePhone;
#pragma mark - 邮箱校验
+(BOOL)checkForEmail:(NSString *)emailStr;
@end
