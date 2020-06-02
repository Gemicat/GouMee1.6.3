//
//  common.h
//  ShenMou
//
//  Created by 16 on 2018/7/11.
//  Copyright © 2018年 冀佳伟. All rights reserved.
//

#ifndef common_h
#define common_h

// 测试环境baseurl
//#define BASE_URL(x) [NSString stringWithFormat:@"http://192.168.2.38:8888/%@",x]
//#define BASE_URL(x) [NSString stringWithFormat:@"https://kuran-pre.goumee.com/%@",x]
#define BASE_URL(x) [NSString stringWithFormat:@"https://kuran-server.goumee.com/%@",x]
#define Img_URL(x)  [NSString stringWithFormat:@"https://sensemoment.oss-cn-hangzhou.aliyuncs.com/%@",x]
// 判断机型
#define BOTTOM_SAFE_HEIGHT   (CGFloat)(iPhoneX ? (34) : (0)) //iPhone X底部home键高度
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define NAVIGATIONBAR_HEIGHT (iPhoneX?88:64)
#define TABBAR_HEIGHT (iPhoneX?83:49)
#define STATUSBAR_HEIGHT (iPhoneX?44:20)
//是否是空对象
#define isObjectNull(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
#define isNotNull(obj)   (!isObjectNull(obj))
// 适配
#define scaleH(y)       y*[UIScreen mainScreen].bounds.size.height/667
#define scale(x)        x*[UIScreen mainScreen].bounds.size.width/375
#define font(x)         [UIFont systemFontOfSize:x*[UIScreen mainScreen].bounds.size.width/375]
#define font1(a,b)      [UIFont fontWithName:a size:b]
#define kFitWidth  ([UIScreen mainScreen].bounds.size.width  / 375)
#define kFitHeight ([UIScreen mainScreen].bounds.size.height / 667)


#define fontBload(x)    [UIFont boldSystemFontOfSize:x*[UIScreen mainScreen].bounds.size.width/375]
#define SW              [UIScreen mainScreen].bounds.size.width
#define SH              [UIScreen mainScreen].bounds.size.height

// block循环引用
#define weak(obj)   __weak typeof(obj) weakSelf = obj
#define strong(obj) __strong typeof(weakSelf) obj = weakSelf
// 颜色
#define COLOR_STR(color) [UIColor colorWithRed:((float)((color & 0xFF0000) >> 16))/255.0 green:((float)((color & 0xFF00) >> 8))/255.0 blue:((float)(color & 0xFF))/255.0 alpha:1.0]
#define iPhoneXRAndXSMAX (kScreenWidth == 414.f && kScreenHeight == 896.f ? YES : NO)
// iPhoneX
#define iPhoneXAndXS (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
#define autoNavBarHeight ((iPhoneXAndXS || iPhoneXRAndXSMAX)  ? 88.f : 64.f)

#define COLOR_STR1(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
#define backGray   [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]
#define headBlue   [UIColor colorWithRed:70/255.0 green:146/255.0 blue:215/255.0 alpha:1.0]
#define buttonBlue   [UIColor colorWithRed:32/255.0 green:144/255.0 blue:231/255.0 alpha:1.0]
#define viewColor   COLOR_STR(0xf4f6f6)
#define ThemeRedColor   COLOR_STR(0xD72E51)
#define ThemeGreenColor   COLOR_STR(0x0FB74E)
#define ISEmptyString(str) ([str isKindOfClass:[NSNull class]] || !str || str.length == 0)
// 是否是iOS9或者更高版本
#define IS_IOS9_OR_HIGHER      (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
#define IS_IOS10_OR_HIGHER      (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
#define IS_IOS11_OR_HIGHER      (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0"))

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif /* common_h */
