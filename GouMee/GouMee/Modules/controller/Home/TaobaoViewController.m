//
//  TaobaoViewController.m
//  xiaolvlan
//
//  Created by 白冰 on 2019/5/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TaobaoViewController.h"
#import <MJRefresh.h>
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define NAV_HEIGHT 64
#define SCREEN_W self.view.bounds.size.width

@interface TaobaoViewController ()<WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshNormalHeader;
@property (nonatomic, strong) UIButton *reloadButton;

@end

@implementation TaobaoViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWorkView:) name:SHOW_NAVBAR_NOTIFI object:nil];
    self.navigationController.navigationBarHidden = NO;
    [self.view addSubview:self.reloadButton];
    self.isHideNavigationBar = NO;///默认显示导航栏
    self.canRefresh = YES;/// 默认刷新
    [self createWebView];
    [self loadRequest];

}
- (void)reload
{
    [self.wk_webView reload];

}
- (void)loadRequest {


    if (_sourceStr != nil) {
        NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        [request setValue:_cookieValue forHTTPHeaderField:@"Cookie"];
        [_wk_webView loadRequest:request];
    }else {
        [_wk_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10]];
    }
}

- (UIProgressView *)progressView {
    if (_progressView != nil) return _progressView;
    _progressView = [[UIProgressView alloc]init];
    // 显示/隐藏导航栏
    _progressView.frame = _isHideNavigationBar ? CGRectMake(0, 20, SCREEN_W, 3) :CGRectMake(0, 0, SCREEN_W, 3);
    _progressView.progressTintColor = _progressViewColor == nil? COLOR_STR(0xcccccc) : _progressViewColor;

    return _progressView;
}

-(float)navHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;
    return rectStatus.size.height + rectNav.size.height;
}

- (MJRefreshNormalHeader *)refreshNormalHeader
{
    if (_refreshNormalHeader != nil) return _refreshNormalHeader;
    _refreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reload)];

    return _refreshNormalHeader;
}



- (void)refreshWorkView:(NSNotification *)info
{
    [self showNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 [self resetWhiteNavBar];
    //设置代理
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //启用系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = !_offPopGesture;

}

// 导航栏操作
- (void)showNavigationBar {
    [self.navigationController setNavigationBarHidden:_isHideNavigationBar];
    if (_isHideNavigationBar == NO) {
        self.navigationController.navigationBar.translucent = NO;
    }
}

//MARK: - 创建并添加 webView
- (void)createWebView
{


    NSMutableString *javascript = [[NSMutableString alloc] initWithString:@"document.documentElement.style.webkitTouchCallout='none';document.documentElement.style.webkitUserSelect='none';"];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    [userContentController addUserScript:script];

    WKProcessPool *processPool = [[WKProcessPool alloc] init];
    WKWebViewConfiguration *webViewController = [[WKWebViewConfiguration alloc] init];
    webViewController.processPool = processPool;
    webViewController.allowsInlineMediaPlayback = YES;
    webViewController.userContentController = userContentController;

    WKWebView *wk_webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SW, SH-[self navHeight]) configuration:webViewController];
    self.wk_webView = wk_webView;
    self.wk_webView.navigationDelegate = self;
    self.wk_webView.UIDelegate = self;
    self.wk_webView.scrollView.showsVerticalScrollIndicator = !_hideVScIndicator;
    self.wk_webView.scrollView.showsHorizontalScrollIndicator = !_hideHScIndicator;
    // 允许侧滑返回至上一网页
    self.wk_webView.allowsBackForwardNavigationGestures = YES;
    // 添加下拉刷新
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 10.0 && _canRefresh) {
        self.wk_webView.scrollView.mj_header = self.refreshNormalHeader;
    }
    // 监听网页的加载进度
    [self.wk_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];

    [self.view addSubview:self.wk_webView];
    [self.view addSubview:self.progressView];


}
- (void)blackNavBackBtn {
    UIImage *img = [[UIImage imageNamed:@"nav"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)backAction {
    if (self.wk_webView.canGoBack==YES) {
        //返回上级页面
        [self.wk_webView goBack];

    }else{
        //退出控制器
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        // 防止进度条回退, goback可能会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) return;

        _progressView.progress = [change[@"new"] floatValue];
        if (_progressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self->_progressView.hidden = YES;
            });
        } else if (_progressView.progress < 1.0 && _progressView.progress > 0) {
            //            self.title = @"加载中...";
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark ----------------------------------------------------------- 是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *hostname = navigationAction.request.URL.absoluteString;
     decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"-----------------------%@----------------",hostname);


}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{

}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    webView.hidden = NO;
    _progressView.hidden = NO;
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}
// 导航完成时，会回调（也就是页面载入完成了）
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    // 设置导航栏标题

        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
            if (isNotNull(title)) {
                self.title = title;
            }
        }];

    // 是否打开js的复制黏贴功能
    if (_canCopy) {
        [self.wk_webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='block';" completionHandler:nil];
        [self.wk_webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='block';" completionHandler:nil];
    }
    [_refreshNormalHeader endRefreshing];
}

//MARK: - HTTPS认证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }

}


@end
