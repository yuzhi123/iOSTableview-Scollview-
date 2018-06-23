//
//  TImeChange.h
//  WWWSDemo1
//
//  Created by qianfeng on 16/1/20.
//  Copyright (c) 2016年 WangWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TImeChange : NSObject
-(NSString*)timeChange:(NSString*)timeStr;
//是否是闰年
+(NSInteger)isRunYear:(NSInteger)year;
//获得1970后的毫秒
+(NSInteger)getTimeFrom1970;
// 获得当前的时间
+(NSString*)getNowTime;
//将秒数转成分钟或者小时
+(NSString*)getSecondTominutesOrHoour:(NSInteger)time;
//后台时间专成指定时间
+(NSString*)javaSecondToHourWithStyle:(NSString*)style andJavaTime:(long)time;
// 后台时间专程转成周几（一周以内星期几，一天以内几点几分，今天显示）
+(NSString*)javaTimeToWeekOrDayOrHourWithTime:(long)time;
// 获得当前时间
+(NSString*)getNowTimewithStyle:(NSString*)style;
//根据毫秒来的到几岁 返还虚岁 一岁半算1岁
+(NSString*)getAgeWithTime:(long)time;
//根据年月日专成毫秒数  参数1: 时间  参数2: 你穿入的时间的格式
+(NSInteger)getTimeToSeconds:(NSString*)time andStyle:(NSString*)style;
// 获得当前哪一年
+(NSString*)getnowYear;
// 获取某年某月有多少天 注意第五位和第六位为月  如2017/1/16
+(NSInteger)getDayInMonthWithTime:(NSString*)str;
@end
