//
//  GouMee.h
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#ifdef __OBJC__


#ifndef GouMee_h
#define GouMee_h
#import "common.h"
#import "AppDelegate.h"
#import "UIView+Gradient.h"
#import "UIImageView+WebCache.h"
#import "Network.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "SDWebImageDownloader.h"
#import "HPSingleton.h"
#import "UIFont+HPFont.h"
#import "UIImage+HPCategory.h"
#import "UIColor+HPCategory.h"
#import "UIButton+HPExtension.h"
#import "UIButton+HPImageTitleSpacing.h"
#import "UIView+HPFrame.h"
#import "UIImageView+HPExtension.h"
#import "UILabel+HPExtension.h"
#import "UIView+HPCategory.h"
#import "UITextField+HPExtension.h"
#import "UIViewController+HPExtension.h"
#import "NSArray+HPSafe.h"
#import "Macro.h"
#import "UIScrollView+AddRefresh.h"
#import <MJRefresh.h>

#define ConfigSixteenColor(s,al)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:al]
#define ConfigWidth  ([UIScreen mainScreen].bounds.size.width)
#define ConfigHeight ([UIScreen mainScreen].bounds.size.height)

#define isiPhoneX (CGSizeEqualToSize([UIScreen mainScreen].bounds.size,CGSizeMake(375, 812)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)))

#define iPhoneXSafeArea       24
#define ConfigTabBarHeight    ((iPhoneX)?83:49)
#define hConfigNaviBarHeight  ((iPhoneX)?88:64)
#define cStatusBarHeight      ((iPhoneX)?44:20)
#define cNaviBarABXHeight     (hConfigNaviBarHeight - cStatusBarHeight)
#define DeviceIsPortrait      [HPSSharedSystemModel deviceIsPortrait]


#endif

#endif /* GouMee_h */
