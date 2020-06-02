//
//  GouMee_BaseViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_BaseViewController.h"
#import <MJRefresh.h>
#import <objc/runtime.h>
#import <MBProgressHUD.h>
#import "GouMee_NavigationViewController.h"
#import "AccountMessageViewController.h"
#import "GouMee_BalanceViewController.h"
#import "Goumee_OrderDetailViewController.h"
#import "ServiceMessageViewController.h"
#define IS_IOS_VERSION_11 (([[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0)? (YES):(NO))
@interface GouMee_BaseViewController ()
{
    
    UIView *showview;
    
}
@property (nonatomic, assign) BOOL isNeedUpdate;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, assign, readwrite) float navHeight;
@property (nonatomic, assign, readwrite) float tabBarHeight;
@property (nonatomic, assign, readwrite) float statusBarHeight;
@property (nonatomic, copy) RefreshViewBlock headerAction;
@property (nonatomic, copy) FooterAction footerAction;
@property (nonatomic, strong)MBProgressHUD *hud;

@end

@implementation GouMee_BaseViewController


static void *pagaIndexKey = &pagaIndexKey;
- (void)setPageIndex:(NSInteger)pageIndex{
    objc_setAssociatedObject(self, &pagaIndexKey, @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)pageIndex {
    return [objc_getAssociatedObject(self, &pagaIndexKey) integerValue];
}

- (void)setHeaderAction:(RefreshViewBlock)headerAction {
    objc_setAssociatedObject(self, @"RefreshViewBlock", headerAction, OBJC_ASSOCIATION_COPY);
}

- (RefreshViewBlock)headerAction {
    return objc_getAssociatedObject(self, @"RefreshViewBlock");
}

- (void)setFooterAction:(FooterAction)footerAction {
    objc_setAssociatedObject(self, @"FooterAction", footerAction, OBJC_ASSOCIATION_COPY);
}

- (FooterAction)footerAction {
    return objc_getAssociatedObject(self, @"FooterAction");
}
-(void)endRefrsh:(UICollectionView *)collectView
{
    [collectView.mj_header endRefreshing];
    [collectView.mj_footer endRefreshing];
}
-(void)endRefrshTableView:(UITableView *)tableView
{
    [tableView.mj_header endRefreshing];
       [tableView.mj_footer endRefreshing];
    
}

-(void)showHub
{

    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!showview) {
  
    showview =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
    showview.backgroundColor = COLOR_STR1(255, 255, 255, 0);

    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
        _hud = [MBProgressHUD showHUDAddedTo:showview animated:YES];
             _hud.label.text = @"正在加载中...";

             _hud.label.textColor = COLOR_STR(0x333333);
             //hud.bezelView.style = MBProgressHUDBackgroundStyleSolidCo;
             _hud.label.font = font(15);
             _hud.userInteractionEnabled= NO;
            
             _hud.mode = MBProgressHUDModeIndeterminate;
    }
    else
    {
        
    }
      
}

-(NSString *)userId
{
  NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if (loginModel.count > 0) {
         return loginModel[@"id"];
    }
    return @"";
   

}
-(void)TableView:(UITableView *)tableView headWithRefresh:(nonnull RefreshViewBlock)block
{
     self.headerAction = block;
    self.pageIndex = 1;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        if (self.headerAction) {
            self.headerAction();
        }
        [self endRefrshTableView:tableView];
        
    }];
}
-(void)CollectView:(UICollectionView *)collectView footWithRefresh:(void (^)(NSInteger))footerAction
{
     self.footerAction = footerAction;
//    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                self.pageIndex += 1;
//               if (self.footerAction) {
//                   self.footerAction(self.pageIndex);
//               }
//        [self endRefrsh:collectView];;
//           }];
    MJRefreshBackFooter *footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self.pageIndex += 1;
        if (self.footerAction) {
            self.footerAction(self.pageIndex);
        }
        [self endRefrsh:collectView];
    }];
//    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                self.pageIndex += 1;
//               if (self.footerAction) {
//                   self.footerAction(self.pageIndex);
//               }
//               [self endRefrsh:collectView];
//           }];
    collectView.mj_footer = footer;
}
-(void)TableView:(UITableView *)tableView footWithRefresh:(nonnull void (^)(NSInteger))footerAction
{
    self.footerAction = footerAction;
       MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                   self.pageIndex += 1;
                  if (self.footerAction) {
                      self.footerAction(self.pageIndex);
                  }
           [self endRefrshTableView:tableView];;
              }];
       tableView.mj_footer = footer;
}
-(void)CollectView:(UICollectionView *)collectView headWithRefresh:(RefreshViewBlock)block
{
     self.headerAction = block;
    
    collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
             self.pageIndex = 1;
           if (self.headerAction) {
               self.headerAction();
           }
        [self endRefrsh:collectView];
           
       }];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.isNeedUpdate) {
           [self.view setNeedsLayout];
       }
    [self.navigationController.navigationBar setTitleTextAttributes:@{
          NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
          NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isNeedUpdate=YES;
}

- (void)viewDidAppear:(BOOL)animated{
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self updateNavLayout];
}

- (void)updateNavLayout{
    if (!IS_IOS_VERSION_11||!self.isNeedUpdate) {
        return;
    }
    self.isNeedUpdate=NO;
    UINavigationItem * item=self.navigationItem;
    NSArray * array=item.leftBarButtonItems;
    if (array&&array.count!=0){
        UIBarButtonItem * buttonItem=array[0];
        UIView * view =[[[buttonItem.customView superview] superview] superview];
        NSArray * arrayConstraint=view.constraints;
        for (NSLayoutConstraint * constant in arrayConstraint) {
            //由于各个系统、手机类型（iPhoneX）的间距不一样，这里要根据不同的情况来做判断m，不一定是等于16的
            if (fabs(constant.constant)==10) {
                constant.constant=0;
            }
            NSLog(@"%f",constant.constant);
        }
    }
}

- (void)initBarItem:(UIView*)view withType:(int)type{
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    //解决按钮不靠左 靠右的问题.iOS 11系统需要单独处理
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -20;//这个值可以根据自己需要自己调整
    switch (type) {
        case 0:
            if (!IS_IOS_VERSION_11) {
                self.navigationItem.leftBarButtonItems =@[spaceItem,buttonItem];
            }else{
                self.navigationItem.leftBarButtonItems =@[buttonItem];
            }
            break;
        case 1:

                self.navigationItem.rightBarButtonItems =@[spaceItem,buttonItem];
            break;

        default:
            break;
    }
}
- (BOOL)isPanBackGestureEnable {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // Do any additional setup after loading the view.
//self.isNeedUpdate=YES;
    BOOL isPanBackEnable = [self isPanBackGestureEnable];
    ((GouMee_NavigationViewController*)self.navigationController).isPanBackGestureEnable = isPanBackEnable;
    UIImage *img = [[UIImage imageNamed:@"nav"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"pushNoti" object:nil];



//    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, -10, 40, 40)];
//    //设置UIButton的图像
//    [backButton setImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
//    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
//    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
//    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//    //覆盖返回按键
//    self.navigationItem.leftBarButtonItem = backItem;
    [self resetWhiteNavBar];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
          NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
          NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
    [self getUVJson:self.title];

}
-(void)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//获取app版本信息
    NSLog(@"%@",infoDictionary);  //这里会得到很对关于app的相关信息

    // 2.app版本
    NSString *applocalversion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"2.app版本: %@",applocalversion);
    NSString *url = [NSString stringWithFormat:@"api/v1/versions/?page_size=1&page=1&os=2&version=%@",applocalversion];
    [Network GET:url paramenters:nil success:^(id data) {

        if (isNotNull(data[@"data"])) {
            NSInteger type = [data[@"data"][@"update_status"] integerValue];
            if (type != 0) {
                [self isUpApp:type jumpWithUrl:data[@"data"][@"donwload"]];
            }
        }
    } error:^(id data) {

    }];
    
    
   


}
-(void)isUpApp:(NSInteger )type jumpWithUrl:(NSString *)url
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新提示" message:@"我们的app上新版本了，快去更新吧" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }];
    if (type == 1) {
     [alertController addAction:cancelAction];
    }

    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)creatHub:(NSString *)text
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!showview) {

        showview =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
        showview.backgroundColor = COLOR_STR1(255, 255, 255, 0);

        showview.alpha = 1.0f;
        showview.layer.cornerRadius = 5.0f;
        showview.layer.masksToBounds = YES;
        [window addSubview:showview];
        _hud = [MBProgressHUD showHUDAddedTo:showview animated:YES];
        _hud.label.text = text;

        _hud.label.textColor = COLOR_STR(0x333333);
        //hud.bezelView.style = MBProgressHUDBackgroundStyleSolidCo;
        _hud.label.font = font(15);
        _hud.userInteractionEnabled= NO;

        _hud.mode = MBProgressHUDModeIndeterminate;
    }
    else
    {

    }
    
}
-(void)getUVJson:(NSString *)titles
{
      NSString *UUIDString = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    if (isNotNull(self.title)) {
        [Network POST:@"api/v1/plogs/" paramenters:@{@"name":titles,@"imei":UUIDString,@"project":@(3)} success:^(id data) {

        } error:^(id data) {

        }];
    }

}
-(void)hiddenHub
{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [_hud hideAnimated:YES afterDelay:0.5];
              [showview removeFromSuperview];
                       _hud = nil;
        });
    

}
- (float)tabBarHeight {
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    if (self.navHeight>64) {
        _tabBarHeight = tabBarVC.tabBar.frame.size.height +34;
    }else {
        _tabBarHeight = tabBarVC.tabBar.frame.size.height;
    }
    return _tabBarHeight;
}
- (float)navHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectNav = self.navigationController.navigationBar.frame;
    _navHeight = rectStatus.size.height + rectNav.size.height;
    return _navHeight;
}
- (float)statusBarHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    _statusBarHeight = rectStatus.size.height;
    return _statusBarHeight;
}
-(void)backItemClick
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
    [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)resetWhiteNavBar {
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
    //forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
          NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
          NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, NAVIGATIONBAR_HEIGHT)];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];


        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
        gradientLayer.locations = @[@(0.0),@(1.0f)];

        gradientLayer.frame = _backView.frame;
        [_backView.layer addSublayer:gradientLayer];

    CGSize s = _backView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [_backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)resetBlackNavBar {
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
    //forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
   
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, NAVIGATIONBAR_HEIGHT)];
    //    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //
    //
    //    gradientLayer.startPoint = CGPointMake(0, 0);
    //    gradientLayer.endPoint = CGPointMake(1, 0);
    //    gradientLayer.colors = @[(__bridge id)AppWhiteColor.CGColor, (__bridge id)AppWhiteColor.CGColor];
    //    gradientLayer.locations = @[@(0.0),@(1.0f)];
    //
    //    gradientLayer.frame = _backView.frame;
    //    [_backView.layer addSublayer:gradientLayer];
    _backView.backgroundColor = COLOR_STR(0xfafafa);
    CGSize s = _backView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [_backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setTitleTextAttributes:@{
          NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
          NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
}
- (void)resetRedNavBar {
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
    //forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setTitleTextAttributes:@{
          NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
          NSForegroundColorAttributeName: COLOR_STR(0xffffff)}];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, NAVIGATIONBAR_HEIGHT)];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];


        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.colors = @[(__bridge id)ThemeRedColor.CGColor, (__bridge id)ThemeRedColor.CGColor];
        gradientLayer.locations = @[@(0.0),@(1.0f)];

        gradientLayer.frame = _backView.frame;
        [_backView.layer addSublayer:gradientLayer];

    CGSize s = _backView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [_backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
        NSForegroundColorAttributeName: COLOR_STR(0xffffff)}];
}
- (void)resetRedsNavBar {
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
    //forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_STR(0xffffff),
                                                                      NSFontAttributeName:font(28)}];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, NAVIGATIONBAR_HEIGHT)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];


    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(__bridge id)COLOR_STR(0xE80C29).CGColor, (__bridge id)COLOR_STR(0xE80C29).CGColor];
    gradientLayer.locations = @[@(0.0),@(1.0f)];

    gradientLayer.frame = _backView.frame;
    [_backView.layer addSublayer:gradientLayer];

    CGSize s = _backView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [_backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_STR(0x333333),
                                                                         NSFontAttributeName:font(28)}];
}
- (void)resetMinesNavBar {
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage xlsn0w_imageWithColor:UIColor.whiteColor]
    //forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, NAVIGATIONBAR_HEIGHT)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];


    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(__bridge id)COLOR_STR(0xFBECE5).CGColor, (__bridge id)COLOR_STR(0xF7D5E3).CGColor];
    gradientLayer.locations = @[@(0.0),@(1.0f)];

    gradientLayer.frame = _backView.frame;
    [_backView.layer addSublayer:gradientLayer];

    CGSize s = _backView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [_backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
      [self.navigationController.navigationBar setTitleTextAttributes:@{
          NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
          NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
}
-(BOOL)isFirstGoods
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"isFirst"];
    if (str.length > 0) {
        return NO;
    }
    return YES;
    
}
-(NSString *)PID
{
    NSString *pid = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_pid"];
    return pid;
    
    
    
}
-(void)FirstEnterGoods
{
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"isFirst"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
