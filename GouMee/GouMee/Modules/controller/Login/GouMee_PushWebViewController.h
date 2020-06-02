//
//  GouMee_PushWebViewController.h
//  GouMee
//
//  Created by 白冰 on 2020/5/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_BaseViewController.h"
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GouMee_PushWebViewController : GouMee_BaseViewController<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong)NSString *urlStr;


@end

NS_ASSUME_NONNULL_END
