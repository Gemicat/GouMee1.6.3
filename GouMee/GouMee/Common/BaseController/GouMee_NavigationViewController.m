//
//  GouMee_NavigationViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_NavigationViewController.h"

@interface GouMee_NavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GouMee_NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.interactivePopGestureRecognizer.delegate = self;

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    //    [[UIBarButtonItem appearance]setTintColor:[UIColor clearColor]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
     [self.navigationController.navigationBar setTitleTextAttributes:@{
          NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(17)],
          NSForegroundColorAttributeName: COLOR_STR(0x333333)}];

    
   
    //返回按钮颜色
    // 统一设置状态栏样式
    self.navigationBar.barTintColor =  COLOR_STR(0xffffff);
    self.navigationBar.tintColor = [UIColor redColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.hidden = NO;
}
#pragma mark - property
- (void)setIsPanBackGestureEnable:(BOOL)isPanBackGestureEnable {
    _isPanBackGestureEnable = isPanBackGestureEnable;
    self.interactivePopGestureRecognizer.enabled = _isPanBackGestureEnable;
}

#pragma mark - UIGestureRecognizerDelegate
// 手势的代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    BOOL isShould = NO;
    if ( (self.childViewControllers.count<=1) ) {
        isShould = NO;
    }else {
        isShould = YES;
    }
    return isShould;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
