//
//  TImeChange.m
//  WWWSDemo1
//
//  Created by qianfeng on 16/1/20.
//  Copyright (c) 2016年 WangWu. All rights reserved.
//

#import "TImeChange.h"

@implementation TImeChange

/******** 2016-01-07T10:00:00.000Z 对于这种时间格式的时间转换 T（可为任意字符）.000Z(可不要)   **********/
-(NSString*)timeChange:(NSString*)timeStr
{
   
    NSString* dayStr = [timeStr substringToIndex:10];
    NSString* secondString = [timeStr substringWithRange:NSMakeRange(11, 8)];
    NSString* beforTime = [NSString stringWithFormat:@"%@ %@",dayStr,secondString];
    NSLog(@"%@",beforTime);
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-DD HH:mm:ss"];
    
    NSDate *date1 = [formatter dateFromString:beforTime];
    NSLog(@"%@",date1);
    
    
    
    NSDate* date2 = [[NSDate alloc]initWithTimeInterval:8*60*60 sinceDate:date1];
    NSString * nowTime = [formatter stringFromDate:date2];
    NSLog(@"nowTime -- %@",nowTime);
    
    
    //时间更改
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSString* data = [formatter1 stringFromDate:[NSDate date]];
    
    NSLog(@"%@",data);
    
    // 比较当前时间和给取的时间的差距
    NSInteger indexOfDisequal =  [self compareStr:data andStr2:nowTime];
    
    if (indexOfDisequal == 1 || indexOfDisequal == 2 || indexOfDisequal == 3 || indexOfDisequal == 4 || indexOfDisequal == 6 || indexOfDisequal == 7 || indexOfDisequal == 9 || indexOfDisequal == 10) {
        return nowTime;
    }
    else if (indexOfDisequal == 5 || indexOfDisequal ==8 || indexOfDisequal == 11 || indexOfDisequal == 14 || indexOfDisequal == 17)
    {
        return @"时间格式错误";
    }
    //小时
    else if (indexOfDisequal == 12 || indexOfDisequal == 13)
    {
        NSString* subStrH1 = [nowTime substringWithRange:NSMakeRange(11, 2)];
        NSString* subStrH2 = [data substringWithRange:NSMakeRange(11, 2)];
        
        
        
        if ([subStrH2 intValue]-[subStrH1 intValue] == 1) {
            
            //小时差在一个小时之间  要判断 是否超过一个小时
            NSString* subStr1 = [nowTime substringWithRange:NSMakeRange(14, 2)];
            NSString* subStr2 = [data substringWithRange:NSMakeRange(14, 2)];
            if ([subStr2 intValue]-[subStr1 intValue] >=0) {
                return [NSString stringWithFormat:@"%d小时前", [subStrH2 intValue]-[subStrH1 intValue]];
            }else
            {
                return [NSString stringWithFormat:@"%d分钟前", 60+[subStr2 intValue]-[subStr1 intValue]];
            }
            
        }else
        {
            NSString* subStr1 = [nowTime substringWithRange:NSMakeRange(14, 2)];
            NSString* subStr2 = [data substringWithRange:NSMakeRange(14, 2)];
            if ([subStr2 intValue]-[subStr1 intValue]>0) {
                return [NSString stringWithFormat:@"%d小时前", [subStrH2 intValue]-[subStrH1 intValue]];
            }else
            {
                return [NSString stringWithFormat:@"%d小时前", [subStrH2 intValue]-[subStrH1 intValue]-1];
            }
            
        }
        
        
    }
    // 分钟
    else if (indexOfDisequal == 15 || indexOfDisequal == 16)
    {
        NSString* subStr1 = [nowTime substringWithRange:NSMakeRange(14, 2)];
        NSString* subStr2 = [data substringWithRange:NSMakeRange(14, 2)];
        return [NSString stringWithFormat:@"%d分钟前", [subStr2 intValue]-[subStr1 intValue]];
    }
    else
    {
        return @"1分钟以前";
    }
    
}

//第几个数不相同 0表示全部相同
-(NSInteger)compareStr:(NSString* )str1 andStr2:(NSString*)str2
{
    //你的时间格式必须为YYYY-MM-DD-hh:mm:ss
    for (NSInteger i = 0; i<str1.length; i++) {
        NSString* subStr1 = [str1 substringWithRange:NSMakeRange(i, 1)];
        NSString* subStr2 = [str2 substringWithRange:NSMakeRange(i, 1)];
        if ([subStr1 isEqualToString:subStr2]) {
        }else
            return i+1;
    }
    
    return 0;
}

//1表示闰年，0表示非闰年
+(NSInteger)isRunYear:(NSInteger)year
{
    if (!(year%100)) {
         return 0;
    }
    else{
       
        if (!(year%4)) {
            return 1;
        }
        else{
            return 0;
           
        }
    }
}

//获得1970年至今的毫秒数
+(NSInteger)getTimeFrom1970
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    NSInteger i=time;      //NSTimeInterval返回的是double类型
    
    return i;
  
}
//获得当前时间
+(NSString*)getNowTime
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString* dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//获得当前时间
+(NSString*)getNowTimewithStyle:(NSString*)style
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:style];
    NSString* dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//将秒数转成分钟与小时(不足一分钟按一分钟算，不足一小时按一小时算)
+(NSString*)getSecondTominutesOrHoour:(NSInteger)time
{
    if (time/60) {
        if (time/3600) {
            return [NSString stringWithFormat:@"使用时长：%ld小时",time/3600+1];
        }
        else
        {
            return [NSString stringWithFormat: @"使用时长：%ld分钟",time/60 +1 ];
        }
    }
    else
    {
        return @"使用时长：1分钟";
    }
}

// 后台时间专成当前年月
+(NSString*)javaSecondToHourWithStyle:(NSString*)style andJavaTime:(long)time
{
    NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:(time / 1000)];
    NSDateFormatter* dateFoemate = [[NSDateFormatter alloc]init];
    [dateFoemate setDateFormat:style];
    NSString* str1 = [dateFoemate stringFromDate:tempDate];
    return str1;
}

// 后台时间专程转成周几（一周以内星期几，一天以内几点几分，今天显示）
+(NSString*)javaTimeToWeekOrDayOrHourWithTime:(long)time
{
    
    
    NSArray* weekday = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSDate* newDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    
    NSDateFormatter* dateFoemate1 = [[NSDateFormatter alloc]init];
    [dateFoemate1 setDateFormat:@"yyyy-MM-dd"];
    NSString* strjjj = [dateFoemate1 stringFromDate:newDate];
    NSLog(@"%@",strjjj);
    
    // 坑死爸爸了，这货从1开始
    NSCalendar* calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSInteger i = components.weekday;
    NSLog(@"%ld",i);
    NSString* weekStr = [weekday objectAtIndex:(components.weekday-1)];
    
    //获得当前时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString* dateTime = [formatter stringFromDate:[NSDate date]];
    
    //获得传过来的时间的天数
    NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:(time / 1000)];
    NSDateFormatter* dateFoemate = [[NSDateFormatter alloc]init];
    [dateFoemate setDateFormat:@"yyyy/MM/dd"];
    NSString* str1 = [dateFoemate stringFromDate:tempDate];
    
    //当天
    if ([str1 isEqualToString:dateTime]) {
        NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:(time / 1000)];
        NSDateFormatter* dateFoemate = [[NSDateFormatter alloc]init];
        [dateFoemate setDateFormat:@"HH:mm"]; // 大写24小时制
        NSString* str1 = [dateFoemate stringFromDate:tempDate];
        return str1;
    }
    //昨天
    else
    {
        NSTimeInterval timenow =[[NSDate date] timeIntervalSince1970]*1000;
        // NSDate* newDate = [NSDate dateWithTimeIntervalSinceNow:timenow];
        
        NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:(timenow / 1000)];
        NSDateFormatter* dateFoemate = [[NSDateFormatter alloc]init];
        [dateFoemate setDateFormat:@"HHmm"]; // 大写24小时制
        NSString* str1 = [dateFoemate stringFromDate:tempDate];
        long haoMiao = 1000*3600*24;
        for (int i= 0 ; i<4; i++) {
              NSString* tempStr = [str1 substringWithRange:NSMakeRange(i, 1)];
            if (i==0) {
              
                haoMiao += ([tempStr intValue] * 1000*3600*10);

            }
            if (i==1) {
               
                haoMiao += ([tempStr intValue] * 1000*3600);
            }
            if (i==2) {
                haoMiao += ([tempStr intValue] * 1000*60);
            }
            if (i==3) {
                 haoMiao += ([tempStr intValue] * 1000);
            }
        }
        
        if ((haoMiao + time)>timenow ) {
            return @"昨天";
        }
        // 一周以内
        else
        {
            if ((haoMiao+time+3600*1000*24*6)>timenow) {
                return weekStr;
            }
            else
            {
                NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:(time / 1000)];
                NSDateFormatter* dateFoemate = [[NSDateFormatter alloc]init];
                [dateFoemate setDateFormat:@"yyyy－MM－dd"];
                NSString* str1 = [dateFoemate stringFromDate:tempDate];
                return str1;
            }
        }
        
    }
    
}

//根据毫秒来的到几岁 返还虚岁 一岁半算1岁 
+(NSString*)getAgeWithTime:(long)time
{
    NSDate* tempDate = [NSDate dateWithTimeIntervalSince1970:(time / 1000)];
    NSDateFormatter* dateFoemate = [[NSDateFormatter alloc]init];
    [dateFoemate setDateFormat:@"yyyyMMdd"];
    NSString* strBirth = [dateFoemate stringFromDate:tempDate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString* dateTime = [formatter stringFromDate:[NSDate date]];
    
    NSString* strYear1 = [strBirth substringWithRange:NSMakeRange(0, 4)];
    NSString* strYear2 = [dateTime substringWithRange:NSMakeRange(0, 4)];
    
    NSInteger year = [strYear2 integerValue] - [strYear1 integerValue];
    
    NSString* strMonth = [strBirth substringWithRange:NSMakeRange(4, 2)];
    NSString* strMonth1 = [strBirth substringWithRange:NSMakeRange(4, 2)];
    
    if ([strMonth integerValue] <[strMonth1 integerValue]) {  //
        
        return [NSString stringWithFormat:@"%ld",year];
    }
    else if ([strMonth integerValue] <[strMonth1 integerValue])
    {
        return [NSString stringWithFormat:@"%ld",year-1];
    }
    else
    {
        NSString* strDay = [strBirth substringWithRange:NSMakeRange(6, 2)];
        NSString* strDay1 = [strBirth substringWithRange:NSMakeRange(6, 2)];
        if (strDay<strDay1) {
            return [NSString stringWithFormat:@"%ld",year-1];
        }else
        {
            return [NSString stringWithFormat:@"%ld",year];
        }
    }

}

//根据年月日专成毫秒数
+(NSInteger)getTimeToSeconds:(NSString*)time andStyle:(NSString*)style
{

    NSDateFormatter* dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:style];
    NSDate* date = [dateFormater dateFromString:time];
    NSTimeInterval interval = [date timeIntervalSince1970];
    return (NSInteger)(interval*1000);

}
// 获得当前哪一年
+(NSString*)getnowYear
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString* dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//指定那一年的某一个月是多少天
+(NSInteger)getDayInMonthWithTime:(NSString*)str
{
    NSString* strYear = [str substringWithRange:NSMakeRange(0, 4)];
    
        NSString* strMonth = [str substringWithRange:NSMakeRange(5, 2)];
        if ([strMonth integerValue] == 2) {
            
            if ([self isRunYear:[strYear integerValue]]) {
                return 29;
            }
            else{
                return 28;
            }
        }
       
        if ([strMonth integerValue] == 1 || [strMonth integerValue] == 3 || [strMonth integerValue] == 5 || [strMonth integerValue] == 7 || [strMonth integerValue] == 8 || [strMonth integerValue] == 10 || [strMonth integerValue] == 12) {
            return 31;
        }
        if ([strMonth integerValue] == 4 || [strMonth integerValue] == 6 || [str integerValue] == 9 || [str integerValue] == 11) {
            return 30;
        }
    
    
    return 0;
}








@end
