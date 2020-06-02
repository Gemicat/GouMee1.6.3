//
//  DateTranslate.h
//  jwtong
//
//  Created by 王梦辉 on 2017/7/3.
//  Copyright © 2017年 王梦辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTranslate : NSObject


///获取当前时间的时间戳,13位的，如果要10位的，把实现方法*1000删掉
+(long long)getNowTimeStamp;

/**
 时间戳转换时间

 @param date 时间戳 （13位的，如果是10位的，把实现方法/1000删掉）
 @param type 想要的时间类型 @"YYYY-MM-dd"，@"MM月dd日"
 @return 时间
 */
+(NSString*)datetime:(NSTimeInterval )date fromType:(NSString*)type;
/**
 时间转换时间戳

 @param time 时间 例如 2017-07-03
 @param type 时间的类型，例如@"YYYY-MM-dd"，@"MM月dd日"，@"YYYY-MM-dd HH:mm"，
 @return 时间戳 （13位，如需要10位的，把实现方法000删掉）
 */
+(NSString*)getTimeStampFromTime:(NSString*)time type:(NSString*)type;




/**
 //     和当前时间比较
 //     1）1分钟以内 显示        :    刚刚
 //     2）1小时以内 显示        :    X分钟前
 //     3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 //     4）当前时间之前或者明天 显示      :    今天 09:30   明天 09:30
 //     5) 今年显示              :   09月12日
 //     6) 大于本年      显示    :    2013/09/09
 //
 //     @param dateString @"2016-04-04 20:21"
 //     @param formate    @"YYYY-MM-dd HH:mm"
 //     hh与HH的区别:分别表示12小时制,24小时制
 **/
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;


+ (NSString *)cellformateDate:(NSString *)dateString withFormate:(NSString *) formate;
@end
