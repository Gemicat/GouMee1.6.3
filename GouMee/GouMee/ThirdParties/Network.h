//
//  Network.h
//  ShenMou
//
//  Created by 16 on 2018/7/11.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^networkSuccess)(id data);
typedef void(^networkError)(id data);
@interface Network: NSObject

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber;
/*
 GET 请求
 */
+ (void)GET:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error;
+(void)showMessage:(NSString *)message duration:(NSTimeInterval)time;

+(void)showMessages:(NSString *)message duration:(NSTimeInterval)time picture:(NSString *)image;
+(NSString *)notRounding:(float)price afterPoint:(int)position;

/*
 POST 请求
 */
+ (void)POST:(NSString *)url
 paramenters:(NSDictionary *)parameters
     success:(networkSuccess)success
       error:(networkError)error;

+ (void)PATCH:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error;

+ (void)DEL:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error;

+ (void)PUT:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error;

+(NSString *)removeSuffix:(NSString *)numberStr;
@end
