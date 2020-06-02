//
//  DateTranslate.m
//  jwtong
//
//  Created by 王梦辉 on 2017/7/3.
//  Copyright © 2017年 王梦辉. All rights reserved.
//

#import "DateTranslate.h"

@implementation DateTranslate


///获取当前时间的时间戳,13位的
+(long long)getNowTimeStamp{
    long long time = [[NSDate date] timeIntervalSince1970]*1000;
//    NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
    return time;
}
/**
 时间戳转换时间
 
 @param date 时间戳
 @param type 得到的时间类型 @"YYYY-MM-dd"，@"MM月dd日"
 @return 时间
 */
+(NSString*)datetime:(NSTimeInterval )date fromType:(NSString*)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *confromTimesp;
    
    [formatter setDateFormat:type];
    confromTimesp = [NSDate dateWithTimeIntervalSince1970:date/1000];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
/**
 时间转换时间戳
 
 @param time 时间
 @param type 时间类型 @"YYYY-MM-dd"，@"MM月dd日"
 @return 时间戳
 */
+(NSString*)getTimeStampFromTime:(NSString*)time type:(NSString*)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:type];
    NSDate* date = [formatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%d000",(int)[date timeIntervalSince1970]];
    return timeSp;
}
/**
 //     和当前时间比较
 //     1）1分钟以内 显示        :    刚刚
 //     2）1小时以内 显示        :    X分钟前
 //     3）当前时间之前或者昨天 显示      :    今天 09:30   昨天 09:30
 //     4）当前时间之前或者明天 显示      :    今天 09:30   明天 09:30
 //     5) 今年显示              :   09月12日
 //     6) 大于本年      显示    :    2013/09/09
 //
 //     @param dateString @"2016-04-04 20:21"
 //     @param formate    @"YYYY-MM-dd hh:mm"
 //     hh与HH的区别:分别表示12小时制,24小时制
 **/
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    @try {
    
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        //  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        //  取当前时间和转换时间两个日期对象的时间间隔
        //  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
          BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:needFormatDate];
         BOOL isYesterday = [[NSCalendar currentCalendar] isDateInYesterday:needFormatDate];
        // 再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        if (time < 0) {
            if (time >= -60*60*24) {
                dateStr = @"明天";
                [dateFormatter setDateFormat:@"YYYY/MM/dd"];
                NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
                NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
                
                [dateFormatter setDateFormat:@"HH:mm"];
                if ([need_yMd isEqualToString:now_yMd]) {
                    //在同一天
                    dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
                }else{
                    //明天天
                    dateStr = [NSString stringWithFormat:@"明天 %@",[dateFormatter stringFromDate:needFormatDate]];
                }
            }else{
                [dateFormatter setDateFormat:@"yyyy"];
                NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
                NSString *nowYear = [dateFormatter stringFromDate:nowDate];
                
             
                    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }

       else if(isToday == YES){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY.MM.dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];

            [dateFormatter setDateFormat:@"HH:mm"];
//
//            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
//            }else{
//                ////  昨天
//                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
//            }
        }

else if (isYesterday == YES)
{
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
    NSString *now_yMd = [dateFormatter stringFromDate:nowDate];

    [dateFormatter setDateFormat:@"HH:mm"];
 dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
}
       else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
          
                [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
        
        return dateStr;
        

    } @catch (NSException *exception) {
        return @"";
    }
}




+ (NSString *)cellformateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    @try {
    
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        //  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        //  取当前时间和转换时间两个日期对象的时间间隔
        //  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        // 再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        if (time < 0) {
            if (time >= -60*60*24) {
                dateStr = @"明天";
                [dateFormatter setDateFormat:@"YYYY/MM/dd"];
                NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
                NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
                
                [dateFormatter setDateFormat:@"HH:mm"];
                if ([need_yMd isEqualToString:now_yMd]) {
                    //在同一天
                    dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
                }else{
                    //明天天
                    dateStr = [NSString stringWithFormat:@"明天 %@",[dateFormatter stringFromDate:needFormatDate]];
                }
            }else{
                [dateFormatter setDateFormat:@"yyyy"];
                NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
                NSString *nowYear = [dateFormatter stringFromDate:nowDate];
                
             
                    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
       else if(time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY.MM.dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
          
                [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
        
        return dateStr;
        

    } @catch (NSException *exception) {
        return @"";
    }
}


@end
