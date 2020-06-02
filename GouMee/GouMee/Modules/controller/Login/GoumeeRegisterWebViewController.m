//
//  GoumeeRegisterWebViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/4/12.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GoumeeRegisterWebViewController.h"
#import "JsApiTest.h"
#import "DWKWebView.h"
#import "GouMee_PushWebViewController.h"
#import "GouMee_GoodsDetailViewController.h"
#import "GouMee_LiveViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_LiveDetailViewController.h"
@interface GoumeeRegisterWebViewController ()<WKNavigationDelegate>
{
    DWKWebView * dwebview;
    NSInteger zxxx;
}

@end

@implementation GoumeeRegisterWebViewController

-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden = NO;
}
-(void)backItemClick
{
    if (dwebview.canGoBack==YES) {
        //返回上级页面
        [dwebview goBack];

    }else{
        //退出控制器
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    zxxx = 100;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *img = [[UIImage imageNamed:@"nav"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
//    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    wkWebConfig.userContentController = wkUController;
//    // 自适应屏幕宽度js
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    // 添加js调用
//    [wkUController addUserScript:wkUserScript];
//
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, SW, SH-[self navHeight]) configuration:wkWebConfig];
//    self.webView.backgroundColor = [UIColor clearColor];
//    self.webView.opaque = NO;
//    self.webView.UIDelegate = self;
//    self.webView.navigationDelegate = self;
//    [self.webView sizeToFit];
//
//    [self.view addSubview:self.webView];
//



    if (isNotNull(self.urlStr)) {

    }
    else
    {
 self.title =@"注册账号";
        _urlStr = @"https://kuran.goumee.com/h5/app_reg_cert.html";
    }


    dwebview=[[DWKWebView alloc] initWithFrame:CGRectMake(0, 0,SW, SH-[self navHeight])];
    [self.view addSubview:dwebview];
    dwebview.allowsBackForwardNavigationGestures = true;
    // register api object without namespace
//    [dwebview addJavascriptObject:[[JsApiTest alloc] init] namespace:nil];

    [dwebview evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {

          NSString *oldUA = result;
                    NSString *newUA =[NSString stringWithFormat:@"%@ kuranApp", oldUA];
                    dwebview.customUserAgent = newUA;
//        NSString *userAgent = result;
//        NSString *newUserAgent = [userAgent stringByAppendingString:@"kuranApp"];
//
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];

//        if (nil != self.urlStr) {
//            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
//            [request setTimeoutInterval:15];
//            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//            [dwebview loadRequest:request];
//        }
//        // After this point the web view will use a custom appended user agent
//        [dwebview evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
//            NSLog(@"%@", result);
//        }];
    }];





    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [dwebview loadRequest:request];

    // register api object with namespace "echo"
    [dwebview addJavascriptObject:[[JsApiTest alloc]init] namespace:@"kuranBridge"];

    // open debug mode, Release mode should disable this.
    [dwebview setDebugMode:true];

//    [dwebview customJavascriptDialogLabelTitles:@{@"alertTitle":@"Notification",@"alertBtn":@"OK"}];

    dwebview.navigationDelegate=self;

    // load test.html


    // call javascript method
//    [dwebview callHandler:@"kuranBridgepageBack" arguments:@[@3,@4] completionHandler:^(NSNumber * value){
//        NSLog(@"%@",value);
//    }];
//
//    [dwebview callHandler:@"kuranBridgepageBack" arguments:@[@"I",@"love",@"you"] completionHandler:^(NSString * _Nullable value) {
//        NSLog(@"call succeed, append string is: %@",value);
//    }];

    // this invocation will be return 5 times
    [dwebview callHandler:@"pageBack" completionHandler:^(NSNumber * _Nullable value) {
        NSLog(@"Timer: %@",value);
    }];

    // test if javascript method exists.
    [dwebview hasJavascriptMethod:@"pageBack" methodExistCallback:^(bool exist) {
        NSLog(@"method 'addValue' exist : %d",exist);
    }];
    [dwebview callHandler:@"go" completionHandler:^(NSNumber * _Nullable value) {
        NSLog(@"Timer: %@",value);
    }];

    // test if javascript method exists.
    [dwebview hasJavascriptMethod:@"go" methodExistCallback:^(bool exist) {
        NSLog(@"method 'addValue' exist : %d",exist);
    }];
    [dwebview callHandler:@"getToken" completionHandler:^(NSNumber * _Nullable value) {
        NSLog(@"Timer: %@",value);
    }];

    // test if javascript method exists.
    [dwebview hasJavascriptMethod:@"getToken" methodExistCallback:^(bool exist) {
        NSLog(@"method 'addValue' exist : %d",exist);
    }];

    // set javascript close listener
    [dwebview setJavascriptCloseWindowListener:^{
        NSLog(@"window.close called");
    } ];

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

        //注册、接收通知
        [center addObserver:self selector:@selector(chanegeLabelText)name:@"webBack"object:nil];
      [center addObserver:self selector:@selector(chanegeLabelTexts:)name:@"webPush"object:nil];



}
-(void)chanegeLabelTexts:(NSNotification*)notification
{
    NSDictionary *model = [notification object];
    [self pushView:model];
}


-(void)pushView:(NSDictionary *)model
{
    NSString *str = [NSString stringWithFormat:@"%@",model[@"value"]];
    if ([str isEqualToString:@"pinbo"]) {
        [self rightA];
    }
    if ([str isEqualToString:@"sample"]) {
        [self leftA];
    }
    if ([model[@"type"] isEqualToString:@"link"]) {
        GouMee_PushWebViewController *web = [[GouMee_PushWebViewController alloc]init];
        web.urlStr = model[@"value"];
        [self.navigationController pushViewController:web animated:YES];
    }
    if ([model[@"type"] isEqualToString:@"goods"]) {
        //            GouMee_GoodsDetailViewController *goods = [[GouMee_GoodsDetailViewController alloc]init];
        [self getgoodsUrl:model[@"value"]];
        //            goods.goodId = model[@"value"];
        //            [self.navigationController pushViewController:goods animated:YES];
    }
    if ([model[@"type"] isEqualToString:@"login"]) {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }

}
-(void)leftA
{
    GouMee_LiveViewController *vc = [[GouMee_LiveViewController alloc]init];
    vc.moduleType = 1;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)rightA
{

    self.tabBarController.selectedIndex = 1;
     [self.navigationController popToRootViewControllerAnimated:YES];

}
-(void)getgoodsUrl:(NSString *)ID
{
    [self showHub];
    if (zxxx == 100) {
        zxxx = 99;
    [Network GET:[NSString stringWithFormat:@"api/v1/good-items/?item_id=%@",ID] paramenters:nil success:^(id data) {
        if ([data[@"success"] integerValue] == 1) {
            if (isNotNull(data[@"data"][@"results"])) {
                NSDictionary *model = [data[@"data"][@"results"] lastObject];
                [self pushDetail:model];
            }
        }

    } error:^(id data) {

    }];
    }

}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable resultStr, NSError * _Nullable error) {
        NSString *title = resultStr;
        self.title = title;
    }];
}
-(void)pushDetail:(NSDictionary *)model
{
    if (isNotNull(model[@"live_group_info"])) {
        if ([model[@"live_group_info"][@"live_type"] intValue] == 1) {
            GouMee_LiveDetailViewController *vc = [[GouMee_LiveDetailViewController alloc]init];

            vc.ID = model[@"live_group_info"][@"id"];
            vc.postStr = @"changeGoodDetail100";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];
            vc.isFree = 1;

            vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    else
    {
        GouMee_GoodsDetailViewController *vc = [[GouMee_GoodsDetailViewController alloc]init];

        vc.goodId = [NSString stringWithFormat:@"%@",model[@"id"]];
        [self.navigationController pushViewController:vc animated:YES];

    }
 zxxx = 100;
    [self hiddenHub];
}
-(void)chanegeLabelText
{
    [self.navigationController popViewControllerAnimated:YES];
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
