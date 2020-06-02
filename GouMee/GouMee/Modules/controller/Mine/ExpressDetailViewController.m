//
//  ExpressDetailViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/4/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "ExpressDetailViewController.h"
#import <WebKit/WebKit.h>

@interface ExpressDetailViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *url;

@end

@implementation ExpressDetailViewController


-(void)viewWillAppear:(BOOL)animated
{
  [self resetRedNavBar];
    UIImage *img = [[UIImage imageNamed:@"back_new"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;

}
-(void)backItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"物流详情";

    self.view.backgroundColor =viewColor;



    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    wkWebConfig.userContentController = wkUController;
    // 自适应屏幕宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加js调用
    [wkUController addUserScript:wkUserScript];

    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SW, SH-[self navHeight]) configuration:wkWebConfig];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView sizeToFit];

    [self.view addSubview:self.webView];
//物流详情 https://kuran-admin.goumee.com/h5/express_detail.html?id=%@


    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://kuran-admin.goumee.com/h5/express_detail.html?id=%@",self.ID]]];
    [self.webView loadRequest:request];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSURL *URL = navigationAction.request.URL;

    NSString *scheme = [URL scheme];

    if ([scheme isEqualToString:@"tel"]) {

        NSString *resourceSpecifier = [URL resourceSpecifier];

        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];

        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现

        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];

        });

    }

    decisionHandler(WKNavigationActionPolicyAllow);

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
