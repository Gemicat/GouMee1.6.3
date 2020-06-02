//
//  GouMee_HomeViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_HomeViewController.h"
#import "YHSegmentView.h"
#import "GouMee_RecommondViewController.h"
#import "GouMee_SearchViewController.h"
#import "GouMee_NavigationViewController.h"
#import "UIView+Gradient.h"
#import "MLMSegmentManager.h"
#import "SquareViewController.h"
#import "GoodsListViewController.h"
#import "GouMee_GoodsListViewController.h"
#import "GouMee_GoodsDetailViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_TabbarViewController.h"
#import "MessageViewController.h"
#import "LCVerticalBadgeBtn.h"
#import "Goumee_OrderViewController.h"
#import "AccountMessageViewController.h"
#import "GouMee_BalanceViewController.h"
#import "ServiceMessageViewController.h"
#import "Goumee_OrderDetailViewController.h"
#import "NullView.h"
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




@interface GouMee_HomeViewController ()<UITextFieldDelegate>
{
 YHSegmentView *segmentView;
    NSMutableArray *dates;
    LCVerticalBadgeBtn *cancelButton;
}

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong)NullView *nullView;
@end

@implementation GouMee_HomeViewController
-(void)viewWillAppear:(BOOL)animated
{
   self.navigationController.navigationBarHidden = NO;
      [self resetRedNavBar];
    [self getMessageNumJson];
}
-(void)getMessageNumJson
{
    
    if (isNotNull([self userId])) {
        [Network GET:@"api/consumer/v1/notice-count/" paramenters:nil success:^(id data) {
            if (isNotNull(data[@"data"])) {
                NSInteger count = [data[@"data"][@"count"] intValue];
                if (count > 99) {
                    cancelButton.badgeString = @"99+";
                }
                else
                {
                    cancelButton.badgeString = [NSString stringWithFormat:@"%ld",count];
                }
                 cancelButton.isMessage = 1;
            }
        } error:^(id data) {
            
        }];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    GouMee_SearchViewController *vc = [[GouMee_SearchViewController alloc]init];

    [self.navigationController pushViewController:vc animated:NO];
    return NO;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)messageAction
{
    if (isNotNull([self userId])) {
        MessageViewController *vc = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}
-(NullView *)nullView
{
    if (!_nullView) {
        _nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-[self tabBarHeight])];
    }
    return _nullView;

}
-(void)getView:(NSInteger)networkCode
{

            [self.view addSubview:self.nullView];
            self.nullView.nullIocn.image = [UIImage imageNamed:@"null_network"];
            self.nullView.nullTitle.text = @"暂时没有网络";
            self.nullView.refreshBtn.hidden = NO;
            self.nullView.click = ^{
                [self getcate];
            };
        }

-(void)netWorkView
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 监听网络状态
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");

                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"暂无网络");
                [self getView:0];


                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"4G");


                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");

                break;

            default:
                break;
        }

    }];

    // 开启监测
    [manager startMonitoring];
}
-(void)searchNavigationBar
{
     self.navigationItem.leftBarButtonItem = nil;
    
    UITextField *_textSearch = [[UITextField alloc]initWithFrame:CGRectMake(0, 4, SW, 35)];

    _textSearch.backgroundColor = COLOR_STR1(255, 255, 255, 0.26);
    
    _textSearch.layer.cornerRadius = 17.5;
    _textSearch.delegate = self;
    _textSearch.font = font(13);
  
     _textSearch.tintColor = [UIColor whiteColor];
//    _textSearch.layer.shadowColor = COLOR_STR1(0, 4, 9, 0.1).CGColor;
//    //    阴影偏移量
//    _textSearch.layer.shadowOffset = CGSizeMake(0, 0);
//    //    阴影透明度
//    _textSearch.layer.shadowOpacity = 1;
//    //    阴影半径
//    _textSearch.layer.shadowRadius = 5;
    self.navigationItem.titleView = _textSearch;
    NSString *textString = @"  搜索商品";
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:textString];
    // 插入图片附件
    NSTextAttachment *imageAtta = [[NSTextAttachment alloc] init];
    imageAtta.bounds = CGRectMake(0, 0, 16, 16);
    imageAtta.image = [UIImage imageNamed:@"search_aa"];
    NSAttributedString *attach = [NSAttributedString attributedStringWithAttachment:imageAtta];
    [attributeString insertAttributedString:attach atIndex:0];

    // 段落样式
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    ///计算placeHolder文字宽度
    CGSize textSize = [textString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 34) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;

    // 缩进以实现居中展示(解决问题a)
    [style setFirstLineHeadIndent:10];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributeString.length)];

    [attributeString addAttribute:NSFontAttributeName value:font(13) range:NSMakeRange(1, attributeString.length - 1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(1, attributeString.length - 1)];
    ///解决问题b
    [attributeString addAttribute:NSBaselineOffsetAttributeName value:@(0.2 *15) range:NSMakeRange(1, attributeString.length - 1)];
    _textSearch.attributedPlaceholder = attributeString;
    
   
    [self netWorkView];
      cancelButton = [[LCVerticalBadgeBtn alloc]initWithFrame:CGRectMake(0,0, 30, 30)];
                 //设置UIButton的图像
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
       cancelButton.badgeString = @"0";
    cancelButton.isMessage = 1;
    cancelButton.adjustsImageWhenHighlighted=NO;
     cancelButton.messageStr = @"直播消息";
          [cancelButton setImage:[UIImage imageNamed:@"message_icon"] forState:UIControlStateNormal];
                 //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
                 [cancelButton addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
         [self initBarItem:cancelButton withType:1];
}
-(void)push:(NSNotification*)notification{
    NSDictionary *nameDictionary = [notification object];
    NSInteger type = [nameDictionary[@"type"] intValue];
    if (type == 1) {
        AccountMessageViewController *vc = [[AccountMessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (type == 2) {
        GouMee_BalanceViewController *vc = [[GouMee_BalanceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (type == 3) {

    }
    if (type == 4) {
        Goumee_OrderDetailViewController *vc = [[Goumee_OrderDetailViewController alloc]init];
        vc.ID = [NSString stringWithFormat:@"%@",nameDictionary[@"resource_id"]];
        [self.navigationController pushViewController:vc animated:YES];
    } if (type == 5) {
        ServiceMessageViewController *vc = [[ServiceMessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}
-(void)changessGoodsNotifications:(NSNotification *)n
{
    NSDictionary *model = [n object];
    if ([model[@"haha"] integerValue] == 1) {

            [UIView animateWithDuration:0.1f
                                  animations:^{
                                          [_segHead setFrame:CGRectMake(0, -44, SW, 44)];
                 [ _segScroll setFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, self.view.frame.size.height-CGRectGetMaxY(_segHead.frame))];
                                      }
                                  completion:^(BOOL finished){
                                      }];

    }
    else
    {
          [UIView animateWithDuration:0.1f
                                animations:^{
                                        [_segHead setFrame:CGRectMake(0, 0, SW, 44)];
               [ _segScroll setFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, self.view.frame.size.height-CGRectGetMaxY(_segHead.frame))];
                                    }
                                completion:^(BOOL finished){
                                    }];


    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"pushNoti" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changessGoodsNotifications:) name:@"hiddenHeadViews" object:nil];
 NSDictionary *isLogin = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];

                        
        [Network GET:@"api/v1/system-config/ios_examine_v163/" paramenters:nil success:^(id data) {
                if (isNotNull(data)) {
                    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                     appDelegate.auditStatus = [data[@"data"][@"int_value"] integerValue];
                
                    if ([data[@"data"][@"int_value"] intValue] == 1) {
                       
                    }
                    else
                    {
                        if (isLogin) {
                            
                        }
                        else
                        {
                            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                            if (app.loginStatus == 0) {
                                app.loginStatus = 1;
                                GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                                [self.navigationController pushViewController:vc animated:YES];

                            }

                        }
                        
                    }
                    }
                } error:^(id data) {
                                                    }];
    
     [self getVersion];
    
    
    [self searchNavigationBar];
//    NSMutableArray *titleArray = [NSMutableArray array];
//    NSMutableArray * controllers = [NSMutableArray array];
//    NSMutableArray *IDArray = [NSMutableArray array];
//
//    titleArray = [NSMutableArray arrayWithObjects:@"广场",@"美妆",@"个护",@"家居",@"食品",nil];
//    IDArray = [NSMutableArray arrayWithObjects:@"",@"30,50011699,50008165,16,50010404",@"50002766,50026316,50050359,50008141",@"50010788,1801",@"35,50014812,50022517,50014512",@"50008090,124242008",@"50007218,50002768,50020579,21,50016349,50016348,50008163,2813,127876007,124458005",nil];
//
//    for (int i = 0; i < titleArray.count; i++) {
//        GouMee_RecommondViewController *recommond = [[GouMee_RecommondViewController alloc]init];
//            recommond.title = titleArray[i];
//             recommond.type = i;
//            [controllers addObject:recommond];
//    }
//
//    segmentView = [[YHSegmentView alloc] initWithFrame:CGRectMake(0,0, SW,  self.view.bounds.size.height) ViewControllersArr:[controllers copy] TitleArr:[titleArray copy] TitleNormalSize:14 TitleSelectedSize:16 SegmentStyle:YHSegementStyleIndicate ParentViewController:self ReturnIndexBlock:^(NSInteger index) {
//    }];
//
//    segmentView.yh_resultBlock = ^(NSInteger index) {
//
//    };
//    [self.view addSubview:segmentView];

    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.height.mas_equalTo(scale(44));
    }];
    [bottomView setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
   
    [self getcate];



}
-(void)getcate
{

    [Network GET:@"api/v1/groups/categorys/" paramenters:@{@"channel":@(1)} success:^(id data) {
        if (isNotNull(data[@"data"])) {
            if ([data[@"error_code"] intValue] == 3001) {
                AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                if (appDelegate.auditStatus == 1) {

                }
                else
                {
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [Network showMessage:@"登录超时，请重新登录" duration:2.0];
                    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                    if (app.loginStatus == 0) {
                        app.loginStatus = 1;
                        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];

                    }

                }
            }
            else
            {
                if ([data[@"success"] intValue] == 1) {
                    dates = [NSMutableArray arrayWithArray:data[@"data"]];
                    [self segmentStyle];
                }

            }

        }
    } error:^(id data) {

    }];
}
#pragma mark - 均分下划线
- (void)segmentStyle{
    NSMutableArray *arr = [NSMutableArray array];
       for (NSDictionary *dic in dates) {
           if ([dic[@"name"] isEqualToString:@"热门"]) {
               [arr addObject:@"广场"];
           }
           else
           {
           [arr addObject:dic[@"name"]];
           }
       }
       
       self.list = arr;
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, scale(0), SCREEN_WIDTH, scale(44)) titles:self.list headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutDefault];
    //    _segHead.fontScale = 1.05;
    _segHead.fontSize = (16);
    /**
     *  导航条的背景颜色
     */
    _segHead.headColor = ThemeRedColor;

    /*------------滑块风格------------*/
    /**
     *  滑块的颜色
     */
    _segHead.slideColor = [UIColor whiteColor];

    /*------------下划线风格------------*/
    /**
     *  下划线的颜色
     */
    //    _segHead.lineColor = [UIColor redColor];
    /**
     *  选中颜色
     */
    _segHead.selectColor =ThemeRedColor;
    /**
     *  未选中颜色
     */
    _segHead.deSelectColor = [UIColor whiteColor];
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

    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, self.view.frame.size.height-CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:self.list.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    @weakify(self)
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        @strongify(self)
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    } selectEnd:^(NSInteger index) {
        AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.freeStatus = 99;
        if (index == 2) {

        }else{

        }
    }];
}

- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
   
    for (int i = 1; i < 5; i++) {
       

    }

       for (int i = 0; i < dates.count; i++) {
           NSString *name = self.list[i];
           if ([name isEqualToString:@"广场"]) {
                SquareViewController *vc = [[SquareViewController alloc]init];
               //    vc.type = 0;
               //    vc.title = @"广场";

                   [arr addObject:vc];
           }
           else
           {
           GouMee_RecommondViewController *vc = [[GouMee_RecommondViewController alloc]init];
            vc.type = [dates[i][@"id"] intValue];
            vc.title = self.list[i];
            [arr addObject:vc];
           }
       }
    

    return arr;
}



@end
