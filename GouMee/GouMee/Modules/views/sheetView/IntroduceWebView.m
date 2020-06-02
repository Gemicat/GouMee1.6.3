//
//  IntroduceWebView.m
//  GouMee
//
//  Created by 白冰 on 2020/4/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "IntroduceWebView.h"

@interface IntroduceWebView()
{

    CGFloat h ;
}

@end
@implementation IntroduceWebView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SW, SH);
               self.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
        [self creaView];
        
    }
    return self;
}
-(void)creaView
{
    h = scale(200);
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, SH, SW, SH-h)];
    [self addSubview:_backView];
    _backView.layer.cornerRadius = 8;
    _backView.layer.masksToBounds = YES;
    _backView.backgroundColor = [UIColor whiteColor];
    self.titleLab = [UILabel new];
       [_backView addSubview:self.titleLab];
       [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(_backView.mas_top).offset(scale(0));
           make.centerX.mas_equalTo(0);
           make.height.mas_equalTo(scale(44));
       }];
       self.titleLab.textColor = COLOR_STR(0x333333);
       self.titleLab.font = font1(@"PingFangSC-Medium", scale(16));
       self.titleLab.text = @"拼播介绍";
    
    _closeBtn = [UIButton new];
       [_backView addSubview:_closeBtn];
       [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(self.titleLab.mas_centerY).offset(0);
           make.right.mas_equalTo(-12);
           make.height.width.mas_equalTo(30);
       }];
       [_closeBtn setImage:[UIImage imageNamed:@"sheet_close"] forState:UIControlStateNormal];
       [_closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
       
    UIView *line = [UIView new];
    [_backView addSubview:line];
    line.backgroundColor = COLOR_STR(0xEBEBEB);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));
    }];
    
    
       WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        wkWebConfig.userContentController = wkUController;
        // 自适应屏幕宽度js
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        // 添加js调用
        [wkUController addUserScript:wkUserScript];
    
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, scale(45), SW, SH-scale(244)) configuration:wkWebConfig];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self.webView sizeToFit];
     
        [self.backView addSubview:self.webView];
       
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://kuran.goumee.com/h5/pinbo_intro.html"]];
    [self.webView loadRequest:request];
    
}
-(void)setUrl:(NSString *)url
{

    if (isNotNull(url)) {
        h = scale(250);
        self.webView.frame = CGRectMake(0, scale(45), SW, SH-h-scale(45));
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.webView loadRequest:request];
    }
    else
    {
          h = scale(200);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://kuran.goumee.com/h5/pinbo_intro.html"]];
        [self.webView loadRequest:request];
    }
}
//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_backView];
    
    [_backView setFrame:CGRectMake(0, SH, SW, SH-h)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_backView setFrame:CGRectMake(0,h, SW, SH-h)];
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    
    [_backView setFrame:CGRectMake(0, h, SW, SH-h)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [_backView setFrame:CGRectMake(0, SH, SW, SH-h)];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [_backView removeFromSuperview];
                         
                     }];
    
}


@end
