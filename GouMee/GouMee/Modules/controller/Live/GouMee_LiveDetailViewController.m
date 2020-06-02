//
//  GouMee_LiveDetailViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_LiveDetailViewController.h"
#import "LiveViewCell.h"
#import "LoopGoodsImgView.h"
#import "Live_TitleViewCell.h"
#import "LiveStoreViewCell.h"
#import "GoodsDetailViewCell.h"
#import "GouMee_AddressViewController.h"
#import "GouMee_StoreViewController.h"
#import "TaobaoViewController.h"
#import "GouMee_LoginViewController.h"
#import "Goumee_AddAreaViewController.h"
#import "OtherschedulingViewCell.h"
#import "ScheluTimeViewCell.h"
#import "CommodityTrendViewCell.h"
#import "SellingpointViewCell.h"
#import "LCVerticalBadgeBtn.h"
#import "JoinMessageView.h"
#import "IntroduceWebView.h"
#import "Kuran_FuliViewCell.h"
#import "FuliListViewCell.h"
#import "GouMee_MyLiveViewController.h"
@interface GouMee_LiveDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    LoopGoodsImgView *_ad;
    UIView *topNaviView;
    UIView *bomNaviView;
    UILabel *timeLab;//直播排期时间
    UILabel *dayLabel;
    UILabel *hourLabel;
    UILabel *minuteLabel;
    UILabel *secondLabel;
     dispatch_source_t _timer;
    UIView *sheetView;
    NSDictionary *addressModel;
    NSMutableDictionary *dates;
    UIButton *rightBtn;
    UILabel *address_name;
    UILabel *address_area;
    CGFloat titleHeight;
    CGFloat storeHeight;
    CGFloat webHeight;
    UIButton *address_leftBtn;
    UILabel *tips;
    UILabel *choose_tip;
    BOOL cellCount;
    NSMutableArray *timeArr;
    LCVerticalBadgeBtn *liveBtn;
    LCVerticalBadgeBtn *liveBtn1;
    NSString *gooodsId;
    NSInteger zxxx;
    NSMutableArray *pictureArr;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GouMee_LiveDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self getliveNumJson];
      self.navigationController.navigationBarHidden = YES;
}
-(void)getGoodsUrl
{
    [self getliveNumJson];
    [self showHub];
[self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES]; 
    [Network GET:[NSString stringWithFormat:@"api/v1/live-groups/%@/",self.ID] paramenters:nil success:^(id data) {
        if ([data[@"success"] integerValue] == 1) {
 pictureArr = [NSMutableArray array];
            if (zxxx == 1) {
                  dates = [NSMutableDictionary dictionaryWithDictionary:data[@"data"]];
            }
            else
            {
                NSInteger  status = [data[@"data"][@"get_status"] intValue] ;
                if (status == 3 || status == 5 || status == 6) {
                    [Network showMessage:@"该场次已报名截止" duration:2.0];
                }
                else if (status == 7)
                {

                    [Network showMessage:@"该场次已暂停" duration:2.0];
                }
                else if (status == 4)
                {
                    [Network showMessage:@"该场次已终止" duration:2.0];
                }
                else
                {
                  dates = [NSMutableDictionary dictionaryWithDictionary:data[@"data"]];
                }
            }
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, SW)];
               self.tableView.tableHeaderView = headView;

            pictureArr = [NSMutableArray arrayWithArray:dates[@"good"][@"small_images_list"]];
            [pictureArr insertObject:dates[@"good"][@"pict_url"] atIndex:0];
               _ad = [[LoopGoodsImgView alloc] initWithFrame:CGRectMake(0, 0, SW,SW) imageUrls:pictureArr placeholderimage:[UIImage imageNamed:@"goods_bg"]];
               [headView addSubview:_ad];
               timeLab = [UILabel new];
               [headView addSubview:timeLab];
               [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.bottom.left.right.mas_equalTo(0);
                   make.height.mas_equalTo(scale(30));
               }];
               timeLab.backgroundColor = COLOR_STR1(0, 0, 0, 0.5);
               timeLab.textAlignment = NSTextAlignmentCenter;
               timeLab.font = font(14);
               timeLab.textColor = COLOR_STR(0xffffff);
              
                _ad.pageContolStyle = PlanPageContolStyleNone;
               _ad.delegate = self;

         
             NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:dates[@"live_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"yyyy.MM.dd HH:mm"];
             timeLab.text = [NSString stringWithFormat:@"直播排期: %@",time];
   NSInteger  status = [dates[@"get_status"] intValue] ;
                [self changeBtn:status];
            _timer = nil;
            [self getTime:status];
            gooodsId =dates[@"good"][@"id"];
            [self getTimeListJson:dates[@"good"][@"id"] withgroupId:dates[@"id"]];
            [self.tableView reloadData];


            if (isNotNull(self.postStr)) {
                  [[NSNotificationCenter defaultCenter] postNotificationName:self.postStr object:dates];
            }
        }
       else if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
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
        [self hiddenHub];
    } error:^(id data) {
         [self hiddenHub];
    }];
    
}
-(void)getTimeListJson:(NSString *)goodsId withgroupId:(NSString *)groupID
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:@(10) forKey:@"page_size"];
    [parm setObject:goodsId forKey:@"good"];
    [parm setObject:groupID forKey:@"group_id"];
    [Network GET:@"api/consumer/v1/good-live/" paramenters:parm success:^(id data) {
        [timeArr removeAllObjects];
        if ([data[@"success"] intValue] == 1) {
            timeArr = [NSMutableArray arrayWithArray:data[@"data"][@"results"]];
            [self.tableView reloadData];
        }
         [self hiddenHub];
       
    } error:^(id data) {
        [self hiddenHub];
    }];
    
    
}

-(void)getliveNumJson
{
    [Network GET:@"api/consumer/v1/my-group-count/" paramenters:nil success:^(id data) {
        if (isNotNull(data[@"data"])) {
            if (isNotNull(data[@"data"][@"count"])) {
                 liveBtn.badgeString = [NSString stringWithFormat:@"%@",data[@"data"][@"count"]];
                 liveBtn1.badgeString = [NSString stringWithFormat:@"%@",data[@"data"][@"count"]];
            }
            else
            {
                liveBtn.badgeString = @"0";
                 liveBtn1.badgeString = @"0";
            }
           
              liveBtn.messageStr = @"直播消息";
              liveBtn.isMessage = 3;
            liveBtn1.messageStr = @"直播消息";
                         liveBtn1.isMessage = 3;
        }
         [self hiddenHub];
    } error:^(id data) {
         [self hiddenHub];
    }];
}

- (void)showItemInTaobao4iOS:(NSString *)itemId
{
    // 构建淘宝客户端协议的 URL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"taobao:%@", itemId]];
      
    // 判断当前系统是否有安装淘宝客户端
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        // 如果已经安装淘宝客户端，就使用客户端打开链接
        [[UIApplication sharedApplication] openURL:url];
          
    } else {
    
        TaobaoViewController *vc = [[TaobaoViewController alloc]init];
        vc.url = [NSString stringWithFormat:@"http:%@", itemId];
        [self.navigationController pushViewController:vc animated:YES];
    }
      
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    cellCount = NO;
    zxxx = 1;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(-[UIApplication sharedApplication].statusBarFrame.size.height);
        if (@available(iOS 11.0, *)) {
                  make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-49);
                  } else {
                  make.bottom.equalTo(self.view.mas_bottom).offset(-49);
                  }
    }];
    titleHeight = 1;
    storeHeight = 1;
    webHeight = 1;
    [self getGoodsUrl];
     self.automaticallyAdjustsScrollViewInsets = NO;
    topNaviView = [UIView new];
          [self.view addSubview:topNaviView];
          [topNaviView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.left.right.mas_equalTo(0);
              make.height.equalTo(@([self navHeight]));
          }];
          topNaviView.backgroundColor = [UIColor clearColor];
          UIButton *backBtn = [UIButton new];
          [topNaviView addSubview:backBtn];
          [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo([self statusBarHeight]+4);
              make.left.mas_equalTo(scale(15));
              make.bottom.mas_equalTo(-10);
              make.width.mas_equalTo(backBtn.mas_height);
          }];
          backBtn.backgroundColor =COLOR_STR1(0, 0, 0, 0.3);
          backBtn.layer.cornerRadius = ([self navHeight] -[self statusBarHeight]-14)/2;
          backBtn.layer.masksToBounds = YES;
          [backBtn addTarget:self action:@selector(backA) forControlEvents:UIControlEventTouchUpInside];
          [backBtn setImage:[UIImage imageNamed:@"back_new"] forState:UIControlStateNormal];
    
           UIView *rightView  = [UIView new];
                   [topNaviView addSubview:rightView];
                   [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
                       make.top.mas_equalTo([self statusBarHeight]+4);
                       make.right.mas_equalTo(scale(-15));
                       make.bottom.mas_equalTo(-10);
                       make.width.mas_equalTo(backBtn.mas_height);
                   }];
             
                   rightView.backgroundColor =COLOR_STR1(0, 0, 0, 0.3);
                   rightView.layer.cornerRadius = ([self navHeight] -[self statusBarHeight]-14)/2;
                   rightView.layer.masksToBounds = YES;
    
         liveBtn = [LCVerticalBadgeBtn new];
         [topNaviView addSubview:liveBtn];
         [liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.mas_equalTo([self statusBarHeight]+4);
             make.right.mas_equalTo(scale(-15));
             make.bottom.mas_equalTo(-10);
             make.width.mas_equalTo(backBtn.mas_height);
         }];
    liveBtn.badgeString = @"";
         [liveBtn addTarget:self action:@selector(liveAction) forControlEvents:UIControlEventTouchUpInside];
         [liveBtn setImage:[UIImage imageNamed:@"live_white"] forState:UIControlStateNormal];
             
             bomNaviView = [UIView new];
             [self.view addSubview:bomNaviView];
             [bomNaviView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.left.right.mas_equalTo(0);
                 make.height.equalTo(@([self navHeight]));
             }];
             bomNaviView.backgroundColor = [UIColor whiteColor];
             bomNaviView.alpha = 0;
          
          UIButton *backBtn1 = [UIButton new];
             [bomNaviView addSubview:backBtn1];
             [backBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo([self statusBarHeight]+4);
                 make.left.mas_equalTo(scale(15));
                 make.bottom.mas_equalTo(-10);
                 make.width.mas_equalTo(backBtn.mas_height);
             }];
             [backBtn1 addTarget:self action:@selector(backA) forControlEvents:UIControlEventTouchUpInside];
             [backBtn1 setImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
    
    
    
    liveBtn1 = [LCVerticalBadgeBtn new];
           [bomNaviView addSubview:liveBtn1];
           [liveBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo([self statusBarHeight]+4);
               make.right.mas_equalTo(scale(-15));
               make.bottom.mas_equalTo(-10);
               make.width.mas_equalTo(backBtn.mas_height);
           }];
    liveBtn1.badgeString = @"0";
    liveBtn1.messageStr = @"直播消息";
    liveBtn1.isMessage = 3;
    liveBtn.messageStr = @"直播消息";
    liveBtn.isMessage = 3;
           [liveBtn1 addTarget:self action:@selector(liveAction) forControlEvents:UIControlEventTouchUpInside];
           [liveBtn1 setImage:[UIImage imageNamed:@"mylive_icon"] forState:UIControlStateNormal];
            
          
          UILabel *titleLab = [UILabel new];
          [bomNaviView addSubview:titleLab];
          [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(bomNaviView.mas_centerX).offset(0);
              make.centerY.mas_equalTo(backBtn1.mas_centerY).offset(0);
          }];
          titleLab.text = @"拼播详情";
          titleLab.textColor = COLOR_STR(0x333333);
          titleLab.font = font1(@"PingFangSC-Medium", scale(17));
    [self creatBottomView];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressNotification:) name:@"delAddress" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressNotification:) name:@"delAddresss" object:nil];
   
    
}
-(void)liveAction
{
    if (isNotNull([self userId])) {
         GouMee_MyLiveViewController *vc = [[GouMee_MyLiveViewController alloc]init];
           [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    }
   
}
-(void)addressNotification:(NSNotification *)n
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
          [parm setObject:[self userId] forKey:@"user"];
             [parm setObject:@(1) forKey:@"page"];
             [parm setObject:@(10) forKey:@"page_size"];
   [Network GET:@"api/v1/addresses/" paramenters:parm success:^(id data) {
                if (isNotNull(data[@"data"])) {
                    if (isNotNull(data[@"data"][@"results"])) {
                          NSDictionary *model = data[@"data"][@"results"][0];
                                        addressModel = model;
                       address_name.text  = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
                       address_area.text  =  [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
                    }
                    else
                    {
                        addressModel = nil;
                        address_name.text = @"组团成功后我们会给您寄送样品，请先添加收货地址";
                        address_area.text = @"";
                        [address_leftBtn setTitle:@"添加地址" forState:UIControlStateNormal];
                    }
                  
                    
                }
                else
                {
                   
                    [self addressSheetView:nil];
                    
                }
            } error:^(id data) {
                
            }];
    
}
-(void)changeBtn:(NSInteger)type
{
    if (type == 2) {
        rightBtn.backgroundColor = ThemeRedColor;
        [rightBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
             [rightBtn setTitle:@"加入拼播" forState:UIControlStateNormal];

      }
      if (type == 8) {
          rightBtn.backgroundColor = COLOR_STR1(102, 102, 102, 0.16);
                 [rightBtn setTitleColor:COLOR_STR1(102, 102, 102, 0.5) forState:UIControlStateNormal];
          [rightBtn setTitle:@"已报名" forState:UIControlStateNormal];

      }
      if (type == 9) {
             rightBtn.backgroundColor = COLOR_STR1(102, 102, 102, 0.16);
                             [rightBtn setTitleColor:COLOR_STR1(102, 102, 102, 0.5) forState:UIControlStateNormal];
                       [rightBtn setTitle:@"已满员" forState:UIControlStateNormal];

         }
      if (type == 1) {
              rightBtn.backgroundColor = ThemeGreenColor;
                   [rightBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
                       [rightBtn setTitle:@"即将开始" forState:UIControlStateNormal];

          tips.text = @"距报名开始还剩";
         }

    if (type != 1) {
 timeLab.backgroundColor = ThemeRedColor;
    }
    else
    {
 timeLab.backgroundColor = ThemeGreenColor;
    }
    if (type == 3 || type == 5|| type == 6) {
        [rightBtn setTitle:@"报名截止" forState:UIControlStateNormal];
      rightBtn.backgroundColor = COLOR_STR1(102, 102, 102, 0.16);
    [rightBtn setTitleColor:COLOR_STR1(102, 102, 102, 0.5) forState:UIControlStateNormal];
        
    }


    
    
}
-(void)creatBottomView
{
    UIView *bottomView = [UIView new];
       [self.view addSubview:bottomView];
       bottomView.backgroundColor = COLOR_STR(0xffffff);
       [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
           if (@available(iOS 11.0, *)) {
           make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
           } else {
           make.bottom.equalTo(self.view.mas_bottom).offset(0);
           }
           make.left.right.mas_equalTo(0);
           make.height.mas_equalTo(49);
       }];
    
    rightBtn = [UIButton new];
    [bottomView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY).offset(0);
        make.right.mas_equalTo(bottomView.mas_right).offset(scale(0));
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(scale(108));
    }];
  
  
    [rightBtn addTarget:self action:@selector(PushJoinSheet:) forControlEvents:UIControlEventTouchUpInside];
     rightBtn.titleLabel.font = font1(@"PingFangSC-Semibold", scale(16));
    [rightBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    
    UIButton *centerBtn = [UIButton new];
    [bottomView addSubview:centerBtn];
    [centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY).offset(0);
        make.right.mas_equalTo(rightBtn.mas_left).offset(scale(0));
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(scale(108));
    }];
    centerBtn.backgroundColor = COLOR_STR(0xF27B16);
    [centerBtn setTitle:@"商品详情" forState:UIControlStateNormal];
    centerBtn.titleLabel.font = font1(@"PingFangSC-Semibold", scale(16));
    [centerBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
  
    [centerBtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    tips = [UILabel new];
    [bottomView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomView.mas_centerY).offset(-scale(3));
        make.left.mas_equalTo(bottomView.mas_left).offset(scale(10));
    }];
    tips.textAlignment = NSTextAlignmentCenter;
    tips.text = @"距报名截止还剩";
    tips.textColor = ThemeRedColor;
    tips.font = font(12);
    
    dayLabel = [UILabel new];
       [bottomView addSubview:dayLabel];
       [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(tips.mas_left).offset(0);
           make.top.mas_equalTo(tips.mas_bottom).offset(scale(6));
           make.height.width.mas_equalTo(scale(16));
       }];
       dayLabel.textAlignment = NSTextAlignmentCenter;
       dayLabel.textColor = COLOR_STR(0xffffff);
       dayLabel.backgroundColor = ThemeRedColor;
       dayLabel.font = font(12);
       dayLabel.layer.cornerRadius = 5;
       dayLabel.layer.masksToBounds = YES;
       dayLabel.text = @"00";
    UILabel *tipssss = [UILabel new];
         [bottomView addSubview:tipssss];
         [tipssss mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerY.mas_equalTo(dayLabel.mas_centerY).offset(0);
             make.left.mas_equalTo(dayLabel.mas_right).offset(scale(5));
         }];
         tipssss.text = @"天";
         tipssss.font = font(12);
         tipssss.textColor = ThemeRedColor;
    

    hourLabel = [UILabel new];
    [bottomView addSubview:hourLabel];
    [hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(dayLabel.mas_centerY).offset(scale(0));
        make.left.mas_equalTo(tipssss.mas_right).offset(scale(5));
        make.height.width.mas_equalTo(scale(16));
    }];
    hourLabel.textColor = COLOR_STR(0xffffff);
    hourLabel.backgroundColor = ThemeRedColor;
    hourLabel.font = font(12);
    hourLabel.layer.cornerRadius = 5;
    hourLabel.layer.masksToBounds = YES;
    hourLabel.text = @"00";
    hourLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *tipss = [UILabel new];
    [bottomView addSubview:tipss];
    [tipss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hourLabel.mas_centerY).offset(0);
        make.left.mas_equalTo(hourLabel.mas_right).offset(scale(3));
    }];
    tipss.text = @":";
    tipss.font = font(12);
    tipss.textColor = ThemeRedColor;
    
    minuteLabel = [UILabel new];
    [bottomView addSubview:minuteLabel];
    [minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(hourLabel.mas_centerY).offset(0);
        make.left.mas_equalTo(tipss.mas_right).offset(scale(3));
        make.height.width.mas_equalTo(scale(16));
    }];
    minuteLabel.textColor = COLOR_STR(0xffffff);
    minuteLabel.backgroundColor = ThemeRedColor;
    minuteLabel.font = font(12);
    minuteLabel.textAlignment = NSTextAlignmentCenter;
    minuteLabel.layer.cornerRadius = 5;
    minuteLabel.layer.masksToBounds = YES;
    minuteLabel.text = @"00";
    UILabel *tipsss = [UILabel new];
    [bottomView addSubview:tipsss];
    [tipsss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(minuteLabel.mas_centerY).offset(0);
        make.left.mas_equalTo(minuteLabel.mas_right).offset(scale(3));
    }];
    tipsss.text = @":";
    tipsss.font = font(12);
    tipsss.textColor = ThemeRedColor;
    
    secondLabel = [UILabel new];
    secondLabel.textAlignment = NSTextAlignmentCenter;
       [bottomView addSubview:secondLabel];
       [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(hourLabel.mas_centerY).offset(0);
           make.left.mas_equalTo(tipsss.mas_right).offset(scale(3));
           make.height.width.mas_equalTo(scale(16));
       }];
       secondLabel.textColor = COLOR_STR(0xffffff);
       secondLabel.backgroundColor = ThemeRedColor;
       secondLabel.font = font(12);
       secondLabel.layer.cornerRadius = 5;
       secondLabel.layer.masksToBounds = YES;
       secondLabel.text = @"00";
    
  
    
   
    
}
-(void)buy
{
    if (isNotNull([self userId])) {
[self showItemInTaobao4iOS:dates[@"good"][@"url"]];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }

}
-(void)getTime:(NSInteger)status
{

       
       if (_timer==nil) {
           __block int timeout;
           
           if (status != 1) {
             timeout   = [dates[@"end_time_countdown"] intValue]; //倒计时时间
           }
           else
           {
                timeout   = [dates[@"start_time_countdown"] intValue]; //倒计时时间
           }
          
           
           if (timeout!=0) {
               dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
               _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
               dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
               dispatch_source_set_event_handler(_timer, ^{
                   if(timeout<=0){ //倒计时结束，关闭
                       dispatch_source_cancel(_timer);
                       _timer = nil;
                       dispatch_async(dispatch_get_main_queue(), ^{
                           dayLabel.text = @"0";
                           hourLabel.text = @"00";
                           minuteLabel.text = @"00";
                           secondLabel.text = @"00";
                       });

                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           [self getGoodsUrl];
                       });



                       
                       
                   }else{
                       int days = (int)(timeout/(3600*24));
                    
                       int hours = (int)((timeout-days*24*3600)/3600);
                       int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                       int second = timeout-days*24*3600-hours*3600-minute*60;
                       dispatch_async(dispatch_get_main_queue(), ^{
                           if (days==0) {
                               dayLabel.text = @"0";
                           }else{
                               dayLabel.text = [NSString stringWithFormat:@"%d",days];
                           }
                           if (hours<10) {
                               hourLabel.text = [NSString stringWithFormat:@"0%d",hours];
                           }else{
                               hourLabel.text = [NSString stringWithFormat:@"%d",hours];
                           }
                           if (minute<10) {
                               minuteLabel.text = [NSString stringWithFormat:@"0%d",minute];
                           }else{
                               minuteLabel.text = [NSString stringWithFormat:@"%d",minute];
                           }
                           if (second<10) {
                               secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                           }else{
                               secondLabel.text = [NSString stringWithFormat:@"%d",second];
                           }
                           
                       });
                       timeout--;
                   }
               });
               dispatch_resume(_timer);
           }
       }


    
}

-(void)backA
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView { // 判断webView所在的cell是否可见，如果可见就layout
//    NSArray *cells = self.collectionView.visibleCells;
//    for (UICollectionViewCell *cell in cells) {
//        if ([cell isKindOfClass:[GoodsWebbViewCell class]]) {
//            GoodsWebbViewCell *webCell = (GoodsWebbViewCell *)cell;
//            [webCell.webView setNeedsLayout];
//        }
//    }
    topNaviView.alpha =1-scrollView.contentOffset.y/[self navHeight];
    bomNaviView.alpha =scrollView.contentOffset.y/[self navHeight];

}
- (void)PlanADScrollViewdidSelectAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld图片", index);
    
  
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = COLOR_STR(0xf5f5f5);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
      
    }
    
    return _tableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row > 0) {
         
        self.ID = timeArr[indexPath.row-1][@"id"];
        zxxx = 2;
        [self getGoodsUrl];
       
    }
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.devices.count;
    if (section == 3) {
        return [pictureArr count];
    }
    else if (section == 1)
    {
     
        if (timeArr.count < 4) {
            return timeArr.count+1;
        }
        else if(timeArr.count < 11)
        {
            if (cellCount == NO) {
                       return 4;
                   }
                   return timeArr.count+1;
            
        }
        else
        {
            if (cellCount == NO) {
                                  return 4;
                              }
                              return 11;
        }
       
    }
    else if (section == 2)
    {
        
        return 3;
    }
    return 9;

}
-(void)rule
{
    IntroduceWebView *view = [[IntroduceWebView alloc]init];
    view.titleLab.text = @"库然专享福利";
    view.url = @"https://kuran.goumee.com/h5/welfare.html";
    [view showInView:self.view];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"Live_TitleViewCell";
            Live_TitleViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell1 == nil) {
                cell1 = [[Live_TitleViewCell alloc]
                         initWithStyle:UITableViewCellStyleValue1
                         reuseIdentifier:CellIdentifier];
            }
            if (isNotNull(dates)) {
                [cell1 addModel:dates];
                cell1.frame = CGRectMake(0, 0, SW, [cell1 getHeight]);
            }
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell1;
        }
        else if(indexPath.row == 1)
        {
            static NSString *CellIdentifier = @"Kuran_FuliViewCell";
            Kuran_FuliViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell1 == nil) {
                cell1 = [[Kuran_FuliViewCell alloc]
                         initWithStyle:UITableViewCellStyleValue1
                         reuseIdentifier:CellIdentifier];
            }
            [cell1.ruleBtn addTarget:self action:@selector(rule) forControlEvents:UIControlEventTouchUpInside];
            if (isNotNull(dates)) {
                [cell1 addModel:dates];
                cell1.frame = CGRectMake(0, 0, SW, [cell1 getHeight]);
            }


            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell1;
        }
        else
        {
            static NSString *CellIdentifier = @"FuliListViewCell";
            FuliListViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell1 == nil) {
                cell1 = [[FuliListViewCell alloc]
                         initWithStyle:UITableViewCellStyleValue1
                         reuseIdentifier:CellIdentifier];
            }
            if (isNotNull(dates)) {
                [cell1 addModel:dates index:indexPath.row];
                cell1.frame = CGRectMake(0, 0, SW, [cell1 getHeight]);
            }


            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell1;

        }

    }
    else if(indexPath.section == 1)
       {
           if (indexPath.row ==0) {
                  static NSString *CellIdentifier = @"OtherschedulingViewCell";
                             OtherschedulingViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                                if (cell1 == nil) {
                                    cell1 = [[OtherschedulingViewCell alloc]
                                             initWithStyle:UITableViewCellStyleValue1
                                             reuseIdentifier:CellIdentifier];
                                }
                              cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                       if (isNotNull(dates)) {
                           if (timeArr.count < 4) {
                               cell1.moreBtn.hidden = YES;
                           }
                           else
                           {
                               cell1.moreBtn.hidden = NO;
                           }

                               [cell1 addModel1:timeArr addModel2:dates];
                               cell1.frame = CGRectMake(0, 0, SW, [cell1 height]);

                                           }

               
               [cell1.moreBtn addTarget:self action:@selector(moreAA:) forControlEvents:UIControlEventTouchUpInside];
                      
                              return cell1;
           }
           else
           {
               static NSString *CellIdentifier = @"ScheluTimeViewCell";
                             ScheluTimeViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                                if (cell1 == nil) {
                                    cell1 = [[ScheluTimeViewCell alloc]
                                             initWithStyle:UITableViewCellStyleValue1
                                             reuseIdentifier:CellIdentifier];
                                }
                              cell1.selectionStyle = UITableViewCellSelectionStyleNone;
               if (isNotNull(timeArr)) {
                   cell1.timeLab.text = timeArr[indexPath.row-1][@"live_time"];
               }
                              return cell1;
               
           }
        
           
       }
    else if(indexPath.section == 2)
    {
        if (indexPath.row == 0) {
     
        static NSString *CellIdentifier = @"LiveStoreViewCell";
              LiveStoreViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                 if (cell1 == nil) {
                     cell1 = [[LiveStoreViewCell alloc]
                              initWithStyle:UITableViewCellStyleValue1
                              reuseIdentifier:CellIdentifier];
                 }
               cell1.selectionStyle = UITableViewCellSelectionStyleNone;
              if (isNotNull(dates)) {
                         [cell1 addModel:dates];
                     }
        [cell1.storeView.enterStore addTarget:self action:@selector(enterX) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakSelf = self;
            
        cell1.click = ^(CGFloat h) {
            __strong typeof(self) strongSelf = weakSelf;
             if (self->storeHeight < h) {//当
                    storeHeight = h;
             }
        };
            cell1.clickAction = ^(CGFloat h) {
              //跳转到流程规则页面
                
                IntroduceWebView *view = [[IntroduceWebView alloc]init];
                [view showInView:self.view];
            };
              
               return cell1;
        }else if(indexPath.row == 1)
        {
            static NSString *CellIdentifier = @"CommodityTrendViewCell";
                         CommodityTrendViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                            if (cell1 == nil) {
                                cell1 = [[CommodityTrendViewCell alloc]
                                         initWithStyle:UITableViewCellStyleValue1
                                         reuseIdentifier:CellIdentifier];
                            }
                          cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            if (isNotNull(dates)) {
                cell1.model = dates;
            }
                          return cell1;
            
        }
        else
        {
            static NSString *CellIdentifier = @"SellingpointViewCell";
            SellingpointViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
               if (cell1 == nil) {
                   cell1 = [[SellingpointViewCell alloc]
                            initWithStyle:UITableViewCellStyleValue1
                            reuseIdentifier:CellIdentifier];
               }
             cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            if (isNotNull(dates)) {
                [cell1 addModel:dates];
                cell1.frame = CGRectMake(0, 0, SW, [cell1 height]);
            }

             return cell1;
        }
        
    }
    else
    {
       static NSString *CellIdentifier = @"GoodsDetailViewCell";
            GoodsDetailViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (cell1 == nil) {
                                  cell1 = [[GoodsDetailViewCell alloc]
                                           initWithStyle:UITableViewCellStyleValue1
                                           reuseIdentifier:CellIdentifier];
                              }
            if (pictureArr.count > 0) {
                [cell1.backImg sd_setImageWithURL:[NSURL URLWithString:pictureArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
//                 cell1.url = [NSString stringWithFormat:@"https://h5.m.taobao.com/app/detail/desc.html?_isH5Des=false#!id=%@&type=0",dates[@"good"][@"item_id"]];
            }
                 
//            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
//             __weak typeof(self) weakSelf = self;
//        cell1.webHeightChangedCallback = ^(CGFloat h) {
//             if (self->webHeight < h) {//当
//              webHeight = h;
//              [self.tableView reloadData];
//             }
//        };
          

                  return cell1;
   
    }
   
   

}
-(void)moreAA:(UIButton *)sender
{
    sender.selected = !sender.selected;
    cellCount = !cellCount;;
        [self.tableView reloadData];
}
-(void)enterX
{

    GouMee_StoreViewController *vc = [[GouMee_StoreViewController alloc]init];
    vc.storeId =[NSString stringWithFormat:@"%@",dates[@"good"][@"seller_id"]] ;
    vc.shopInfo = dates[@"good"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Live_TitleViewCell *cell = (Live_TitleViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.height;
        }
        else if (indexPath.row == 1)
        {
        Kuran_FuliViewCell *cell = (Kuran_FuliViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.height;
        }

        FuliListViewCell *cell = (FuliListViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"----------inderex____%ld+++++++++++++++++%f",indexPath.row,cell.height);
        return cell.height;


    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
             return storeHeight;
        }
        else if (indexPath.row == 2)
        {
            SellingpointViewCell *cell = (SellingpointViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
                                 return cell.height;
            
        }
        return scale(270);
       
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            OtherschedulingViewCell *cell = (OtherschedulingViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
                      return cell.height;
        }
        return scale(54);
       
       }
    if (indexPath.section == 3) {
        if (pictureArr.count > 0) {
               UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: pictureArr[indexPath.row]];
                    
                  // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了，除了高度不固定的文字部分。
                  if (!image) {
                      image = [UIImage imageNamed:@"goods_bg"];
                  }
                  //手动计算cell
                  CGFloat imgHeight = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
                  return  imgHeight;
           }
           return 0;
    }
    return scale(0);
}


-(void)getUserInfo
{
    [Network GET:[NSString stringWithFormat:@"api/v1/users/%@/",[self userId]] paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {

                BOOL status = [data[@"data"][@"allow_group"] boolValue];
                if (status == YES) {
                    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
                    [parm setObject:[self userId] forKey:@"user"];
                    [parm setObject:@(1) forKey:@"page"];
                    [parm setObject:@(10) forKey:@"page_size"];

                    [Network GET:@"api/v1/addresses/" paramenters:parm success:^(id data) {
                        if (isNotNull(data[@"data"])) {
                            if (isNotNull(data[@"data"][@"results"])) {
                                NSDictionary *model = data[@"data"][@"results"][0];
                                addressModel = model;
                                [self addressSheetView:model];
                            }
                            else
                            {
                                [self addressSheetView:nil];

                            }


                        }
                        else
                        {

                            [self addressSheetView:nil];

                        }

                    } error:^(id data) {

                    }];
                }
                else
                {
                    JoinMessageView *view = [[JoinMessageView alloc]init];
                    view.titleLabs.text = @"报名失败";
                    view.contextLabs.text = @"您当前暂不符合报名条件，如您有疑问请联系您的对接人";
                    [self.view addSubview:view];

                }
        }
        else
        {
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
                [Network showMessage:data[@"message"] duration:2.0];
            }
        }
    } error:^(id data) {}];

}






-(void)PushJoinSheet:(UIButton *)sener
{
    if (isNotNull([self userId])) {
    if ([sener.titleLabel.text isEqualToString:@"加入拼播"]) {
        
        [self getUserInfo];
    }
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    

}
-(void)addressSheetView:(NSDictionary *)model
{
    [sheetView removeFromSuperview];
    sheetView = [UIView new];
          [self.view addSubview:sheetView];
          [sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.left.right.bottom.mas_equalTo(0);
          }];
          sheetView.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
          UIView *backView = [UIView new];
          [sheetView addSubview:backView];
          backView.backgroundColor = [UIColor whiteColor];
          [backView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.mas_equalTo(self.view.mas_centerY).offset(0);
              make.centerX.mas_equalTo(0);
              make.left.mas_equalTo(scale(50));
              make.height.mas_equalTo(scale(253));
          }];
          backView.layer.cornerRadius = 10;
          backView.layer.masksToBounds = YES;
       
       UILabel *tip = [UILabel new];
       [backView addSubview:tip];
       [tip mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(0);
           make.top.mas_equalTo(scale(16));
           
       }];
       tip.text = @"拼播报名";
       tip.textColor = COLOR_STR(0x333333);
       tip.font = font1(@"PingFangSC-Semibold", scale(16));
       
        UIButton *closeBtn = [UIButton new];
           [backView addSubview:closeBtn];
           [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(scale(0));
               make.right.mas_equalTo(scale(0));
               make.height.width.mas_equalTo(scale(40));
               
           }];
       [closeBtn setImage:[UIImage imageNamed:@"sheet_close"] forState:UIControlStateNormal];
           [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
       
       UILabel *LiveTime = [UILabel new];
       [backView addSubview:LiveTime];
       [LiveTime mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(backView.mas_left).offset(scale(20));
           make.top.mas_equalTo(tip.mas_bottom).offset(scale(20));
       }];
    NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:dates[@"live_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"yyyy.MM.dd HH:mm"];
                LiveTime.text = [NSString stringWithFormat:@"直播排期: %@",time];
       LiveTime.textColor = ThemeRedColor;
       LiveTime.font = font1(@"PingFangSC-Regular", scale(14));
    UIView *lines = [UIView new];
    [backView addSubview:lines];
    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    lines.backgroundColor = COLOR_STR(0xEBEBEB);
       UILabel *tips = [UILabel new];
       [backView addSubview:tips];
       [tips mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(LiveTime.mas_left).offset(0);
           make.top.mas_equalTo(LiveTime.mas_bottom).offset(scale(15));
           make.width.mas_equalTo(scale(100));
       }];
       tips.text = @"寄样地址";
       tips.textColor = COLOR_STR(0x333333);
       tips.font = font1(@"PingFangSC-Semibold", scale(14));
    
    
       address_name = [UILabel new];
       [backView addSubview:address_name];
       [address_name mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(tips.mas_bottom).offset(scale(5));
           make.left.mas_equalTo(tips.mas_left).offset(0);
           make.right.mas_equalTo(backView.mas_right).offset(scale(-10));
       }];
       address_name.textColor = COLOR_STR(0x333333);
       address_name.font = font(14);
    address_name.numberOfLines = 2;
      
       
       address_area = [UILabel new];
       [backView addSubview:address_area];
       [address_area mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(address_name.mas_bottom).offset(scale(5));
           make.left.mas_equalTo(tips.mas_left).offset(0);
           make.centerX.mas_equalTo(0);
       }];
       address_area.numberOfLines = 2;
       address_area.font =font(14);
       address_area.textColor = COLOR_STR(0x333333);
       
       
       address_leftBtn = [UIButton new];
       [backView addSubview:address_leftBtn];
       [address_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(backView.mas_bottom).offset(scale(-16));
           make.left.mas_equalTo(backView.mas_left).offset(scale(20));
           make.right.mas_equalTo(backView.mas_centerX).offset(scale(-6));
           make.height.mas_equalTo(scale(30));
       }];

    
       address_leftBtn.layer.borderWidth = 1;
    
    choose_tip = [UILabel new];
       [backView addSubview:choose_tip];
       [choose_tip mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(address_leftBtn.mas_top).offset(scale(-10));
           make.centerX.mas_equalTo(backView.mas_centerX).offset(0);
           make.right.mas_equalTo(backView.mas_right).offset(scale(-10));
       }];
    choose_tip.textAlignment = NSTextAlignmentCenter;
       choose_tip.text = @"请添加寄样地址";
       choose_tip.textColor = ThemeRedColor;
       choose_tip.font = font(14);
       choose_tip.hidden = YES;
    
       if (model) {
         address_name.text  = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
       address_area.text  =  [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
            [address_leftBtn setTitle:@"更换地址" forState:UIControlStateNormal];
        }
        else
        {
             address_name.text = @"组团成功后我们会给您寄送样品，请先添加收货地址";
             [address_leftBtn setTitle:@"添加地址" forState:UIControlStateNormal];
        }
    
      
       [address_leftBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
       [address_leftBtn addTarget:self action:@selector(leftA:) forControlEvents:UIControlEventTouchUpInside];
       UIButton *address_rightBtn = [UIButton new];
       [backView addSubview:address_rightBtn];
        address_leftBtn.titleLabel.font = font(14);
       [address_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(backView.mas_bottom).offset(scale(-16));
           make.right.mas_equalTo(backView.mas_right).offset(scale(-20));
           make.left.mas_equalTo(backView.mas_centerX).offset(scale(6));
           make.height.mas_equalTo(scale(30));
       }];
    address_leftBtn.layer.borderWidth = 0.5;
    address_leftBtn.layer.borderColor = ThemeRedColor.CGColor;
       [address_rightBtn setTitle:@"提交报名" forState:UIControlStateNormal];
       [address_leftBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
       address_leftBtn.backgroundColor = COLOR_STR(0xffffff);
    [address_rightBtn addTarget:self action:@selector(rightB:) forControlEvents:UIControlEventTouchUpInside];
    address_leftBtn.layer.masksToBounds = YES;
    address_leftBtn.layer.cornerRadius = scale(15);
    address_rightBtn.titleLabel.font = font(14);
    address_rightBtn.layer.cornerRadius = scale(15);
    address_rightBtn.layer.masksToBounds = YES;
    address_rightBtn.layer.borderColor = ThemeRedColor.CGColor;
    address_rightBtn.backgroundColor = ThemeRedColor;
    
}
-(void)rightB:(UIButton *)sender
{
    if (isNotNull([self userId])) {

    NSString *live_id = dates[@"id"];
    if (isNotNull(addressModel)) {
         sender.userInteractionEnabled = NO;
        NSString *address_id = addressModel[@"id"];
        NSMutableDictionary *parm = [NSMutableDictionary dictionary];
        [parm setObject:live_id forKey:@"live_group"];
        [parm setObject:address_id forKey:@"address_key"];
        [Network POST:@"api/v1/group-records/" paramenters:parm success:^(id data) {
            if ([data[@"success"] intValue] == 1) {
                  [self getGoodsUrl];
            }
            else
            {
                 if ([data[@"error_code"] intValue] == 1111) {
                     JoinMessageView *view = [[JoinMessageView alloc]init];
                     view.titleLabs.text = @"报名失败";
                     view.contextLabs.text = data[@"message"];
                     [self.view addSubview:view];
                 }
                else
                {
                [Network showMessage:data[@"message"] duration:2.0];
                    
                }

            }
              

            
           
            [sheetView removeFromSuperview];
            sender.userInteractionEnabled = YES;
        } error:^(id data) {
            sender.userInteractionEnabled = YES;
        }];
    }
    else
    {
        
        choose_tip.hidden = NO;
    }
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    if (isNotNull(self.postStr)) {
          [[NSNotificationCenter defaultCenter] removeObserver:self name:self.postStr object:nil];
    }
  
   
}
-(void)leftA:(UIButton *)sender
{
    if (isNotNull([self userId])) {

    if ([sender.titleLabel.text isEqualToString:@"更换地址"]) {
        
    
    
    GouMee_AddressViewController *vc = [[GouMee_AddressViewController alloc]init];
    vc.addressModel = addressModel;
    vc.click = ^(NSDictionary * _Nonnull model) {
        addressModel = model;
        address_name.text  = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
              address_area.text  =  [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
        choose_tip.hidden = YES;
    };
    [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        Goumee_AddAreaViewController *vc = [[Goumee_AddAreaViewController alloc]init];
               vc.click = ^(NSDictionary * _Nonnull model) {
                   addressModel = model;
                 address_name.text  = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
                   address_area.text  =  [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
                   choose_tip.hidden = YES;
                   [sender setTitle:@"更改地址" forState:UIControlStateNormal];
                  
               };
               [self.navigationController pushViewController:vc animated:YES];
        
    }
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
}
-(void)close
    {
        [sheetView removeFromSuperview];
       
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
