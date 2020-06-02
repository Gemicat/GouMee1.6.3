//
//  GoodsWebbViewCell.m
//  xiaolvlan
//
//  Created by 白冰 on 2019/5/29.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "GoodsWebbViewCell.h"

@implementation GoodsWebbViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {
//    UIView *superView = self.contentView;
//    superView.backgroundColor = [UIColor clearColor];
//   WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    wkWebConfig.userContentController = wkUController;
//    // 自适应屏幕宽度js
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    // 添加js调用
//    [wkUController addUserScript:wkUserScript];
//
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SW, 1) configuration:wkWebConfig];
//    self.webView.backgroundColor = [UIColor clearColor];
//    self.webView.opaque = NO;
//    self.webView.userInteractionEnabled = NO;
//    self.webView.scrollView.bounces = NO;
//    self.webView.UIDelegate = self;
//    self.webView.navigationDelegate = self;
//    [self.webView sizeToFit];
//    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SW, 1)];
//    [self.scrollView addSubview:self.webView];
//    [self.contentView addSubview:self.scrollView];
    self.backImg = [UIImageView new];
    [self addSubview:self.backImg];
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//       UIScrollView *scrollView = (UIScrollView *)object;
//              CGFloat height = scrollView.contentSize.height;
//        if (self.webHeightChangedCallback) {
//            self.webHeightChangedCallback(height);
//        }
//              self.webView.frame = CGRectMake(0, 0, SW, height);
//              self.scrollView.frame = CGRectMake(0, 0, SW, height);
//              self.scrollView.contentSize =CGSizeMake(SW, height);
//    }
//}
//
//- (void)dealloc
//{
//    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//     [self.webView stopLoading];
//}
    
@end
