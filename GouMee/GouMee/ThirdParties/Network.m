//
//  Network.m
//  ShenMou
//
//  Created by 16 on 2018/7/11.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#import "Network.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
@interface Network ()
{
    UIView *showview;
   
}

@property (nonatomic , copy) networkSuccess success;
@property (nonatomic , copy) networkError error;

@end
@implementation Network


+(void)showMessages:(NSString *)message duration:(NSTimeInterval)time picture:(NSString *)image
{

    CGSize screenSize = [[UIScreen mainScreen] bounds].size;

    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = COLOR_STR1(0, 0, 0, 0.5);
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];


    UIImageView *backIcon = [[UIImageView alloc]init];
    [showview addSubview:backIcon];
    backIcon.image = [UIImage imageNamed:image];
    [backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(showview.mas_top).offset(scale(12));
        make.centerX.mas_equalTo(0);
    }];


    UILabel *label = [[UILabel alloc]init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};

    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(scale(150), 999)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes context:nil].size;

    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(scale(10));
        make.top.mas_equalTo(backIcon.mas_bottom).offset(scale(15));
    }];

    showview.frame = CGRectMake((screenSize.width - scale(150))/2,
                                screenSize.height/2.0-scale(65),
                                scale(150),
                                scale(80)+labelSize.height);
    [UIView animateWithDuration:time animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];


}
+(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = COLOR_STR1(0, 0, 0, 0.5);
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(207, 999)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes context:nil].size;
    
    label.frame = CGRectMake(10, 5, labelSize.width +20, labelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    
    showview.frame = CGRectMake((screenSize.width - labelSize.width - 20)/2,
                                screenSize.height/2.0-labelSize.height/2.0-5,
                                labelSize.width+40,
                                labelSize.height+10);
    [UIView animateWithDuration:time animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


-(void)showMessagess:(NSString *)message duration:(NSTimeInterval)time
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;

    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = COLOR_STR1(0, 0, 0, 0.5);
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];

    UILabel *label = [[UILabel alloc]init];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};

    CGSize labelSize = [message boundingRectWithSize:CGSizeMake(207, 999)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes context:nil].size;

    label.frame = CGRectMake(10, 5, labelSize.width +20, labelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];

    showview.frame = CGRectMake((screenSize.width - labelSize.width - 20)/2,
                                screenSize.height/2.0-labelSize.height/2.0-5,
                                labelSize.width+40,
                                labelSize.height+10);
    [UIView animateWithDuration:time animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}




+(void)PATCH:(NSString *)url paramenters:(NSDictionary *)parameters success:(networkSuccess)success error:(networkError)error
{
    [[self alloc] PATCH:url paramenters:parameters success:success error:error];
   
}
+(void)BVGHJGJKJHG
{
    
}
+ (void)DEL:(NSString *)url paramenters:(NSDictionary *)parameters success:(networkSuccess)success error:(networkError)error
{
    [[self alloc] DEL:url paramenters:parameters success:success error:error];
}
-(void)DEL:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error
{
     self.success = success;
        self.error = error;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
        if (loginModel) {
            NSString *token = [NSString stringWithFormat:@"Token %@",loginModel[@"token"]];
             [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
        }

    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 8.0f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
       
    //     [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"version"];
    //     [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"apptypes"];
    //
    //    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString *urlStr ;
        if ([url containsString:@"http"]) {
            urlStr = url;
        }
        else
        {
            urlStr = BASE_URL(url);
        }
    [manager DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.success) {
                                    NSDictionary *dic = responseObject;
                                    self.success(dic);
                                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.error) {
                                     self.error(error);
                                 }
    }];
   
        
       
      
    
}
-(void)PATCH:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error
{
     self.success = success;
        self.error = error;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
        if (loginModel) {
            NSString *token = [NSString stringWithFormat:@"Token %@",loginModel[@"token"]];
             [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
        }

    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 8.0f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
       
    //     [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"version"];
    //     [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"apptypes"];
    //
    //    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString *urlStr ;
        if ([url containsString:@"http"]) {
            urlStr = url;
        }
        else
        {
            urlStr = BASE_URL(url);
        }
    [manager PATCH:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.success) {
                              NSDictionary *dic = responseObject;
                              self.success(dic);
                          }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.error) {
                              self.error(error);
                          }
    }];
        
       
      
    
}

+ (void)GET:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error
{
    [[self alloc] GET:url paramenters:parameters success:success error:error];
}
- (void)GET:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error
{
    self.success = success;
    self.error = error;
   
//     if (!showview) {
//            dispatch_queue_t mainQueue = dispatch_get_main_queue(); dispatch_async(mainQueue,^{
//
//                  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//                     showview =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
//                    [keyWindow addSubview:showview];
//                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showview animated:YES];
//                           hud.mode =MBProgressHUDModeIndeterminate;
//                           hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//                           hud.label.textColor = COLOR_STR(0xffffff);
//                           hud.activityIndicatorColor =COLOR_STR(0xffffff);
//
//                           hud.opacity = 1;
//
//                           hud.color = COLOR_STR(0xffffff);
//
//                            hud.color = [hud.color colorWithAlphaComponent:1];
//
//                           hud.bezelView.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
//
//                           hud.label.text = @"正在加载中...";
//
//                });
//       }
//     
  
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];


    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
       if (loginModel) {
           NSString *token = [NSString stringWithFormat:@"Token %@",loginModel[@"token"]];
            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
       }
    [manager.requestSerializer setValue:@"1.6.3" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"apptypes"];
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *urlStr ;
    if ([url containsString:@"http"]) {
        urlStr = url;
    }
    else
    {
        urlStr = BASE_URL(url);
    }
    
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//       [showview removeFromSuperview];
        if (self.success) {
                   self.success(responseObject);
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         [showview removeFromSuperview];
    
        if (self.error) {
            [self showMessagess:@"暂无网络" duration:2.0];
                  self.error(error);
              }
    }];
    
    
    
    
    
    
//    [manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        if (self.success) {
//            self.success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (self.error) {
//            self.error(error);
//        }
//    }];
    
}

+(void)POST:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error
{
    [[self alloc] POST:url paramenters:parameters success:success error:error];
}


-(void)POST:(NSString *)url
 paramenters:(NSDictionary *)parameters
     success:(networkSuccess)success
       error:(networkError)error
{
    self.success = success;
    self.error = error;
//    if (!showview) {
//         dispatch_queue_t mainQueue = dispatch_get_main_queue(); dispatch_async(mainQueue,^{
//
//               UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//                  showview =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
//                 [keyWindow addSubview:showview];
//
//
//             });
//    }
  
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if (loginModel) {
        NSString *token = [NSString stringWithFormat:@"Token %@",loginModel[@"token"]];
         [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }

//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
   
//     [manager.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"version"];
//     [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"apptypes"];
//   
//    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *urlStr ;
    if ([url containsString:@"http"]) {
        urlStr = url;
    }
    else
    {
        urlStr = BASE_URL(url);
    }
    
    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        if (self.success) {
                   NSDictionary *dic = responseObject;
                   self.success(dic);
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.error) {
            [self showMessagess:@"暂无网络" duration:2.0];
                   self.error(error);
               }
    }];
  

    
//    [manager POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        if (self.success) {
//            NSDictionary *dic = responseObject;
//            self.success(dic);
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (self.error) {
//            self.error(error);
//        }
//    }];
    
}

+(NSString *)removeSuffix:(NSString *)numberStr{
    double num = [numberStr doubleValue];
    NSNumber *number = @(num);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###0.00"];
    formatter.roundingMode = NSNumberFormatterRoundDown;
    formatter.maximumFractionDigits = 2;
    NSLog(@"%@", [formatter stringFromNumber:number]);

    NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithString:[formatter stringFromNumber:number]];

    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    //    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    //
    //
    //
    //    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [decimal1 decimalNumberByRoundingAccordingToBehavior:roundingBehavior];


    return [NSString stringWithFormat:@"%@",roundedOunces];



//    return [formatter stringFromNumber:number];

}
+ (BOOL)checkTelephoneNumber:(NSString *)telephoneNumber {
    NSString *MOBILE             = @"^1([3-9][0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    return [regextestmobile evaluateWithObject:telephoneNumber] ;
}
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{

    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];

    [formatter setTimeZone:timeZone];

    

    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate

    //时间转时间戳的方法:

    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];

    

    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值

    

    return timeSp;

}

+(NSString *)notRounding:(float)price afterPoint:(int)position{

    NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.2f",price]];
    NSDecimalNumber *decimal2 = [NSDecimalNumber decimalNumberWithString:@"10000"];
    NSDecimalNumber *dividDecimal = [decimal1 decimalNumberByDividingBy:decimal2];
    NSLog(@"%@",dividDecimal);

    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
//    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
//
//
//
//    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [dividDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];


    return [NSString stringWithFormat:@"%@",roundedOunces];




}
 

//将某个时间戳转化成 时间

#pragma mark - 将某个时间戳转化成 时间

+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{

    

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];

    [formatter setTimeZone:timeZone];

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSLog(@"1296035591  = %@",confromTimesp);

    

    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    

    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);

    

    return confromTimespStr;

}


+ (void)PUT:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error
{
    [[self alloc] PUT:url paramenters:parameters success:success error:error];
}
- (void)PUT:(NSString *)url
paramenters:(NSDictionary *)parameters
    success:(networkSuccess)success
      error:(networkError)error
{
    self.success = success;
    self.error = error;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];


    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 60.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
       if (loginModel) {
          NSString *token = [NSString stringWithFormat:@"Token %@",loginModel[@"token"]];
            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
       }
    [manager.requestSerializer setValue:@"1.6.3" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"apptypes"];
    [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *urlStr ;
    if ([url containsString:@"http"]) {
        urlStr = url;
    }
    else
    {
        urlStr = BASE_URL(url);
    }
    
    [manager PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.success) {
            self.success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.error) {
                         self.error(error);
                     }
    }];
    
    
}


@end
