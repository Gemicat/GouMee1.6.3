//
//  GouMee_TabbarViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_TabbarViewController.h"
#import "GouMee_HomeViewController.h"
#import "GouMee_MineViewController.h"
#import "GouMee_LiveViewController.h"
#import "GouMee_NavigationViewController.h"
@interface GouMee_TabbarViewController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) NSMutableArray *vcArray;//tabbar root VC

@end

@implementation GouMee_TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self addTabBarChildViewController];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTranslucent:NO];///解决升级iOS 12.1后UITabBar从二级页面返回主页导致 图标上下跳动
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance]setBackgroundImage:[UIImage new]];
    UIImage *whiteImage = [self imageWithColor:[UIColor whiteColor]];
    if (@available(iOS 13.0, *)) {
        // 手动放一张白色底图遮住系统tabbar的顶部线条
        // blankView颜色必须设置
        UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, UIScreen.mainScreen.bounds.size.width, 0.5)];
        blankView.backgroundColor = COLOR_STR(0xebebeb);
        [self.tabBar addSubview:blankView];
    } else {

    }
}

    // 通过颜色生成图片
- (UIImage *)imageWithColor:(UIColor *)color {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }

- (void)turnToTabVCAtIndex:(NSUInteger)index {
    if ([self.selectedViewController isKindOfClass:[GouMee_NavigationViewController class]]) {
        [self.selectedViewController  popToRootViewControllerAnimated:NO];
    }

    if (index != self.selectedIndex) {
        self.selectedIndex = index;
    }
}

#pragma mark - add TabBar VC

- (void)addTabBarChildViewController {
    self.vcArray = [[NSMutableArray array] mutableCopy];

    GouMee_HomeViewController  *home = [[GouMee_HomeViewController alloc]init];
    GouMee_MineViewController *mine = [[GouMee_MineViewController alloc]init];
    GouMee_LiveViewController *live = [[GouMee_LiveViewController alloc]init];
    

    [self setupChildViewController:home title:@"选品广场" imageName:@"square_n" seleceImageName:@"square_s"];
    [self setupChildViewController:live title:@"百人拼播" imageName:@"live_n" seleceImageName:@"live_s"];
    [self setupChildViewController:mine title:@"个人中心" imageName:@"mine_n" seleceImageName:@"mine_s"];





    self.viewControllers = self.vcArray;
}

- (void)setupChildViewController:(UIViewController*)controller
                           title:(NSString *)title
                       imageName:(NSString *)imageName
                 seleceImageName:(NSString *)selectImageName {
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:COLOR_STR(0x999999),
                                                    NSFontAttributeName:font1(@"PingFangSC-Regular", scale(11))} forState:UIControlStateNormal];

    //选中字体颜色



    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeRedColor,
                                                    NSFontAttributeName:font1(@"PingFangSC-Regular", scale(11))} forState:UIControlStateSelected];



    for (UIBarItem *item in self.tabBar.items) {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"Helvetica" size:14.0], NSFontAttributeName, nil]
                            forState:UIControlStateSelected];

    }
    //包装导航控制器
    GouMee_NavigationViewController *nav = [[GouMee_NavigationViewController alloc] initWithRootViewController:controller];
    [self.vcArray addObject:nav];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    return YES;
}

@end
