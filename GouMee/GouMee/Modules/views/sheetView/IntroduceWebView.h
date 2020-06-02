//
//  IntroduceWebView.h
//  GouMee
//
//  Created by 白冰 on 2020/4/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface IntroduceWebView : UIView<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *titleLab;

@property (nonatomic, strong) UIButton *closeBtn;
- (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
