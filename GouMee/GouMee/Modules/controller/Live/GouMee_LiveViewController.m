//
//  GouMee_LiveViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/6.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_LiveViewController.h"
#import "YHSegmentView.h"
#import "MLMSegmentManager.h"
#import "LiveListViewController.h"
#import "Goumee_TimeView.h"
#import "GouMee_SearchViewController.h"
#import "GouMee_LoginViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "GouMee_MyLiveViewController.h"
#import "Goumee_FreeListViewController.h"
#import "LCVerticalBadgeBtn.h"
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
@interface GouMee_LiveViewController ()
{
    NSInteger type;
    NSMutableArray *dates;
    NSString *lowStr;
    NSString *highStr;
    NSString *dateStr;
    UIButton *leftBtn;
    UIButton *rightBtn;
    UIView *lineView;
    LCVerticalBadgeBtn *chooseBtn;
    LCVerticalBadgeBtn *LiveBtn;
}
@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property (nonatomic, strong) NSArray *list;
@end

@implementation GouMee_LiveViewController
-(void)viewWillAppear:(BOOL)animated
{
   
    [self getliveNumJson];
}
-(void)mylive
{
    if (isNotNull([self userId])) {
         GouMee_MyLiveViewController *vc = [[GouMee_MyLiveViewController alloc]init];
           [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }
   
}
-(void)getliveNumJson
{
    [Network GET:@"api/consumer/v1/my-group-count/" paramenters:nil success:^(id data) {
        if (isNotNull(data[@"data"])) {
            if (isNotNull(data[@"data"][@"count"])) {
                 LiveBtn.badgeString = [NSString stringWithFormat:@"%@",data[@"data"][@"count"]];
            }
            else
            {
                LiveBtn.badgeString = @"0";
            }
           
              LiveBtn.messageStr = @"直播消息";
              LiveBtn.isMessage = 3;
        }
    } error:^(id data) {
        
    }];
}
-(void)creatNavigationButton
{
    if (self.moduleType != 1) {
        
    LiveBtn = [[LCVerticalBadgeBtn alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
                    //设置UIButton的图像
        
        [LiveBtn setImage:[UIImage imageNamed:@"live_icon"] forState:UIControlStateNormal];
                    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [LiveBtn addTarget:self action:@selector(mylive) forControlEvents:UIControlEventTouchUpInside];
    LiveBtn.titleLabel.font = font(10);
        LiveBtn.messageStr = @"直播消息";
        LiveBtn.isMessage = 3;
       [LiveBtn setTitle:@"我的拼播" forState:UIControlStateNormal];
       [LiveBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];

        [LiveBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:0];

//              //设置UIButton的图
//              UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:LiveBtn];
//              //覆盖返回按键
//              self.navigationItem.rightBarButtonItem = backItem;
        [self initBarItem:LiveBtn withType:1];
    
    
    
    chooseBtn = [[LCVerticalBadgeBtn alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
                    //设置UIButton的图像
                    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    chooseBtn.titleLabel.font = font(10);
     [chooseBtn setImage:[UIImage imageNamed:@"live_shai"] forState:UIControlStateNormal];
       [chooseBtn setTitle:@"筛选" forState:UIControlStateNormal];
       [chooseBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
     [chooseBtn addTarget:self action:@selector(shai) forControlEvents:UIControlEventTouchUpInside];
    [chooseBtn setImage:[UIImage imageNamed:@"live_shai_s"] forState:UIControlStateSelected];
          [chooseBtn setTitleColor:ThemeRedColor forState:UIControlStateSelected];
        [chooseBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:0];
        chooseBtn.messageStr = @"直播消息";
                     chooseBtn.isMessage = 2;
              //设置UIButton的图
              UIBarButtonItem *backItems = [[UIBarButtonItem alloc]initWithCustomView:chooseBtn];
              //覆盖返回按键
              self.navigationItem.leftBarButtonItem = backItems;
    
    }
    else
    {
 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"m_search"] style:UIBarButtonItemStyleDone target:self action:@selector(setsearch)];;

    }
    
}
-(void)setsearch
{
    GouMee_SearchViewController *vc = [[GouMee_SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)shai
{
    Goumee_TimeView *vc = [[Goumee_TimeView alloc]initWithFrame:CGRectMake(0, 0, SW, SH)];
    vc.click = ^(NSString * _Nonnull date, NSString * _Nonnull low, NSString * _Nonnull high) {
       
        if (isNotNull(date)||low.length >0) {
            chooseBtn.selected = YES;
        }
        else
        {
            chooseBtn.selected = NO;
        }
        
        NSDictionary *dic =@{@"time":date,@"low":low,@"high":high};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"timePost" object:dic];
    };
    [self.view.window addSubview:vc];
   
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"timePost" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"test1" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavigationButton];
    self.view.backgroundColor = [UIColor whiteColor];
   UIView *line = [UIView new];
      [self.view addSubview:line];
      [line mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.left.right.mas_equalTo(0);
          make.height.mas_equalTo(1);
      }];
      line.backgroundColor = COLOR_STR1(0, 0, 0, 0.08);
    if (self.moduleType != 1) {
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"shuai_day"];
        NSString *str1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"shuai_time"];
        if (isNotNull(str) || isNotNull(str1)) {
            chooseBtn.selected = YES;
        }
        else
        {
            chooseBtn.selected = NO;
        }

 
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, scale(150), 34)];
    titleView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleView;
        
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleView addSubview:leftBtn];
    leftBtn.frame = CGRectMake(0, 0, scale(75), 34);
        leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn setTitle:@"进行中" forState:UIControlStateNormal];
    [leftBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    [leftBtn setTitleColor:ThemeRedColor forState:UIControlStateSelected];
    leftBtn.titleLabel.font = font1(@"PingFangSC-Medium", scale(14));
        leftBtn.selected = YES;
        
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleView addSubview:rightBtn];
    rightBtn.frame = CGRectMake(scale(75), 0, scale(75), 34);
        rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitle:@"即将开始" forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
        [rightBtn setTitleColor:ThemeRedColor forState:UIControlStateSelected];
    rightBtn.titleLabel.font = font1(@"PingFangSC-Medium", scale(14));
        rightBtn.selected = NO;
        [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
     [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
        lineView = [[UIView alloc]initWithFrame:CGRectMake(scale(37.5)-scale(9), 32, scale(18), 1)];
          [titleView addSubview:lineView];
          lineView.backgroundColor = ThemeRedColor;
//    [self setBorderWithView:rightBtn top:YES left:NO bottom:YES right:YES borderColor:COLOR_STR(0xD7D7D7) borderWidth:0.5];
        [self showHub];
   [Network GET:@"api/v1/groups/categorys/" paramenters:@{@"channel":@(4)} success:^(id data) {
         if (isNotNull(data[@"data"])) {
             if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                 [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [Network showMessage:data[@"message"] duration:2.0];
                 AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                 if (app.loginStatus == 0) {
                     app.loginStatus = 1;
                     GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                     vc.pushType = 1;
                     [self.navigationController pushViewController:vc animated:YES];

                 }
             }
             else
             {
                 if (isNotNull(data[@"data"])) {
                     dates = [NSMutableArray arrayWithArray:data[@"data"]];
                                 [self segmentStyle];
                 }
           
             }
             
         }
       [self hiddenHub];
      } error:^(id data) {
         
      }];
    }
    else
    {
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changessGoodsNotification:) name:@"hiddenHeadView" object:nil];
      self.navigationItem.title = @"免费寄样";
        [Network GET:@"api/v1/groups/categorys/" paramenters:@{@"channel":@(2)} success:^(id data) {
              if (isNotNull(data[@"data"])) {
                  if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                      [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                      [[NSUserDefaults standardUserDefaults]synchronize];
                      [Network showMessage:data[@"message"] duration:2.0];
                      AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                      if (app.loginStatus == 0) {
                          app.loginStatus = 1;
                          GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                          [self.navigationController pushViewController:vc animated:YES];

                      }
                  }

                  else
                  {
                  dates = [NSMutableArray arrayWithArray:data[@"data"]];
                   [self segmentStyle];
                  }
                  
              }
            [self hiddenHub];
           } error:^(id data) {
               [self hiddenHub];
           }];
    }
    
  
  
    
    
    
    
   
}
-(void)changessGoodsNotification:(NSNotification *)n
{
    NSDictionary *model = [n object];
    if ([model[@"haha"] integerValue] == 1) {

        [UIView animateWithDuration:0.1f
                              animations:^{
                                      [_segHead setFrame:CGRectMake(0, -44, SW, 44)];
            [ _segScroll setFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame))];
                                  }
                              completion:^(BOOL finished){
                                  }];

    }
    else
    {
          [UIView animateWithDuration:0.1f
                                animations:^{
                                        [_segHead setFrame:CGRectMake(0, 0, SW, 44)];
 [ _segScroll setFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame))];
                                    }
                                completion:^(BOOL finished){
                                    }];


    }


}
-(void)rightAction
{
    rightBtn.userInteractionEnabled = NO;
    leftBtn.userInteractionEnabled = NO;


    [self showHub];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.zxcs = 2;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test1" object:@"2"];
    [Network GET:@"api/v1/groups/categorys/" paramenters:@{@"channel":@(3)} success:^(id data) {
        leftBtn.selected = NO;
        rightBtn.selected = YES;
        [_segHead removeFromSuperview];
        [_segScroll removeFromSuperview];

        lineView.frame = CGRectMake(scale(37.5)*3-scale(9), 32, scale(18), 1);
        type = 2;
       if (isNotNull(data[@"data"])) {
           if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
               [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
               [[NSUserDefaults standardUserDefaults]synchronize];
               [Network showMessage:data[@"message"] duration:2.0];
               AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
               if (app.loginStatus == 0) {
                   app.loginStatus = 1;
                   GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:YES];

               }
           }
           else
           {
               if (isNotNull(data[@"data"])) {
                   dates = [NSMutableArray arrayWithArray:data[@"data"]];
                               [self segmentStyle];
               }
         
           }
           
       }
        rightBtn.userInteractionEnabled = YES;
           leftBtn.userInteractionEnabled = YES;
        [self hiddenHub];
    } error:^(id data) {
        [self hiddenHub];
        rightBtn.userInteractionEnabled = YES;
           leftBtn.userInteractionEnabled = YES;
    }];
    
}
-(void)leftAction
{


    rightBtn.userInteractionEnabled = NO;
       leftBtn.userInteractionEnabled = NO;

  
    [self showHub];
    [Network GET:@"api/v1/groups/categorys/" paramenters:@{@"channel":@(4)} success:^(id data) {
        rightBtn.selected = NO;
        leftBtn.selected = YES;
        type = 1;
        [_segHead removeFromSuperview];
        [_segScroll removeFromSuperview];
        lineView.frame = CGRectMake(scale(37.5)-scale(9), 32, scale(18), 1);
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.zxcs = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"test1" object:@"1"];
       if (isNotNull(data[@"data"])) {
           if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
               [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
               [[NSUserDefaults standardUserDefaults]synchronize];
               [Network showMessage:data[@"message"] duration:2.0];
               AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
               if (app.loginStatus == 0) {
                   app.loginStatus = 1;
                   GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                   [self.navigationController pushViewController:vc animated:YES];

               }
           }
           else
           {
               if (isNotNull(data[@"data"])) {
                   dates = [NSMutableArray arrayWithArray:data[@"data"]];
                               [self segmentStyle];
               }
         
           }
           
       }
        [self hiddenHub];
        rightBtn.userInteractionEnabled = YES;
                  leftBtn.userInteractionEnabled = YES;
    } error:^(id data) {
        [self hiddenHub];
        rightBtn.userInteractionEnabled = YES;
                  leftBtn.userInteractionEnabled = YES;
    }];
    
}
#pragma mark - 均分下划线
- (void)segmentStyle{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in dates) {
        [arr addObject:dic[@"name"]];
    }
    
    self.list = arr;
    
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0,1, SCREEN_WIDTH, scale(44)) titles:self.list headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutDefault];
    //    _segHead.fontScale = 1.05;
    _segHead.fontSize = (14);
    /**
     *  导航条的背景颜色
     */
    _segHead.headColor = [UIColor clearColor];

    /*------------滑块风格------------*/
    /**
     *  滑块的颜色
     */
    _segHead.slideColor = COLOR_STR(0xD72E51);

    /*------------下划线风格------------*/
    /**
     *  下划线的颜色
     */
    //    _segHead.lineColor = [UIColor redColor];
    /**
     *  选中颜色
     */
    _segHead.selectColor =[UIColor whiteColor];
    /**
     *  未选中颜色
     */
    _segHead.deSelectColor = COLOR_STR(0x333333);
    /**
     *  下划线高度
     */
    //    _segHead.lineHeight = 2;
    /**
     *  下划线相对于正常状态下的百分比，默认为1
     */
    //    _segHead.lineScale = 0.8;

    /**
     *  顶部导航栏下方的边线
     */
    _segHead.bottomLineHeight = 0.0f;
    _segHead.bottomLineColor = [UIColor clearColor];
    /**
     *  设置当前屏幕最多显示的按钮数,只有在默认布局样式 - MLMSegmentLayoutDefault 下使用
     */
    //_segHead.maxTitles = 5;
    if (_moduleType != 1) {
         _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)-[self tabBarHeight]-[self navHeight]) vcOrViews:[self vcArr:self.list.count]];
    }
    else
    {
      _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:self.list.count]];
    }
    

    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    @weakify(self)
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        @strongify(self)
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    } selectEnd:^(NSInteger index) {
    }];
}

- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];

    for (int i = 0; i < dates.count; i++) {
        if (self.moduleType == 1) {
            Goumee_FreeListViewController *vc = [[Goumee_FreeListViewController alloc]init];
                  vc.cateID = [dates[i][@"id"] intValue];
                [arr addObject:vc];
        }
        else
        {
        LiveListViewController *vc = [[LiveListViewController alloc]init];
        vc.moduleType = self.moduleType;
        vc.cateID = [dates[i][@"id"] intValue];
        vc.type = 1;
        [arr addObject:vc];
        }

    }

    return arr;
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
