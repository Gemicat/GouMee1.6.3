//
//  GouMee_GoodsDetailViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_GoodsDetailViewController.h"
#import "GoodsWebbViewCell.h"
#import "LoopCollectionReusableView.h"
#import "CouspondViewCell.h"
#import "LiveSaleViewCell.h"
#import "StoreDetailViewCell.h"
#import "GouMee_StoreViewController.h"
#import "PID_SheetView.h"
#import "CommnditCollectViewCell.h"
#import "DY_SheetView.h"
#import "TaobaoViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_SelVideoViewController.h"
#import "FreeGoodView.h"
#import "IntroduceWebView.h"
#import "JoinMessageView.h"
#import "GoodsPutongViewCell.h"
#import "GoodsFuliListViewCell.h"
#import "SellPointViewCells.h"
#import "Goumee_AddAreaViewController.h"
#import "GouMee_AddressViewController.h"
@interface GouMee_GoodsDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
 
     NSInteger webCount;
    LoopCollectionReusableView *headerView;
    UIView *topNaviView;
        UIView *bomNaviView;
    UIButton *collectBtn;
    WKWebView *webView;
    NSDictionary *addressModel;
    NSString *taoBaoID;
    NSMutableArray *pictureArr;
}
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, assign) CGFloat couponHeight;
@property (nonatomic, assign) CGFloat LiveHeight;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *datas;
@property (nonatomic, strong)FreeGoodView *freeView;



@end

@implementation GouMee_GoodsDetailViewController

-(NSMutableDictionary *)datas
{
    if (!_datas) {
        _datas =[NSMutableDictionary dictionary];
    }
   return  _datas;
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden = YES;
      [self getGoodDetailUrl];
    
}
-(void)viewDidDisappear:(BOOL)animated
{

    [webView stopLoading];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品详情";
    self.view.backgroundColor = viewColor;
 
      _webHeight = 1;
    _couponHeight = 1;
    _LiveHeight = 1;
      self.automaticallyAdjustsScrollViewInsets = NO;
    [self addCollectionView];
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
    
    UILabel *titleLab = [UILabel new];
    [bomNaviView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bomNaviView.mas_centerX).offset(0);
        make.centerY.mas_equalTo(backBtn1.mas_centerY).offset(0);
    }];
    titleLab.text = @"商品详情";
    titleLab.textColor = COLOR_STR(0x333333);
    titleLab.font = font1(@"PingFangSC-Medium", scale(18));



     
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressNotification:) name:@"delAddress" object:nil];
    }
-(void)addressNotification:(NSNotification *)n
    {
        addressModel = nil;
        [self getAddress];
    }
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(void)getGoodDetailUrl
{
    [self showHub];
    [Network GET:[NSString stringWithFormat:@"api/v1/goods/%@/",self.goodId] paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            taoBaoID = data[@"data"][@"item_id"];
            pictureArr = [NSMutableArray array];
            self->_datas = [NSMutableDictionary dictionaryWithDictionary:data[@"data"]];
            pictureArr = [NSMutableArray arrayWithArray:data[@"data"][@"small_images_list"]];
            [pictureArr insertObject:data[@"data"][@"pict_url"] atIndex:0];


            self->headerView.imageUrls = pictureArr;

           
            self->headerView.goodsDTO = data[@"data"];
            if ([self->_datas[@"is_favorite"] intValue] == 0) {
                self->collectBtn.selected = NO;
            }
            else
            {
                self->collectBtn.selected = YES;
            }
            [self crearBottomView:[data[@"data"][@"kurangoods"][@"is_on_sale"] integerValue]];
            [self->_collectionView reloadData];
        }
        else
        {
            if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [Network showMessage:data[@"message"] duration:2.0];
                GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                vc.pushType = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
         else
         {
         [Network showMessage:data[@"message"] duration:2.0];
         }
        }
        [self hiddenHub];
    } error:^(id data) {
        [self hiddenHub];
    }];
}
-(void)crearBottomView:(NSInteger)stutus
{
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = viewColor;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        } else {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        }
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(49));
    }];
    if (stutus == 1) {

    UIButton *copyBtn = [UIButton new];
    [bottomView addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(scale(122));
        make.centerY.mas_equalTo(bottomView.mas_centerY).offset(0);
        make.top.mas_offset(0);

    }];
   
    [copyBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    copyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:scale(16)];
      [copyBtn setGradientBackgroundWithColors:@[ThemeRedColor,ThemeRedColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
   
     
    UIButton *buyBtn = [UIButton new];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(copyBtn.mas_left).offset(0);
        make.width.mas_equalTo(scale(122));
        make.top.mas_offset(0);
        make.centerY.mas_equalTo(bottomView.mas_centerY).offset(0);
    }];
   
    
    [buyBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:scale(16)];
    [buyBtn setGradientBackgroundWithColors:@[COLOR_STR(0xF27B16),COLOR_STR(0xF27B16)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];

    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

   if (self.isFree == 1) {
       if (appDelegate.auditStatus == 0) {
           [buyBtn setTitle:@"上架到抖音" forState:UIControlStateNormal];
       }
       else
       {
           buyBtn.hidden = YES;
       }
            
        [copyBtn setTitle:@"申请寄样" forState:UIControlStateNormal];
       [buyBtn addTarget:self action:@selector(uptoDY) forControlEvents:UIControlEventTouchUpInside];
       [copyBtn addTarget:self action:@selector(applyGoods:) forControlEvents:UIControlEventTouchUpInside];
         }
         else
         {
             [buyBtn setTitle:@"购买样品" forState:UIControlStateNormal];
              if (appDelegate.auditStatus == 0) {
                        [copyBtn setTitle:@"上架到抖音" forState:UIControlStateNormal];
                    }
             else
             {
                 copyBtn.hidden = YES;
             }
              [buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
              [copyBtn addTarget:self action:@selector(uptoDY) forControlEvents:UIControlEventTouchUpInside];
         }
   
    collectBtn = [UIButton new];
       [bottomView addSubview:collectBtn];
       [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(bottomView.mas_left).offset(10);
           make.height.mas_equalTo(scale(40));
           make.width.mas_equalTo(scale(56));
           make.centerY.mas_equalTo(buyBtn.mas_centerY).offset(0);
       }];
    [collectBtn setImage:[UIImage imageNamed:@"collect_normal"] forState:UIControlStateNormal];
     [collectBtn setImage:[UIImage imageNamed:@"collect_select"] forState:UIControlStateSelected];
       [collectBtn setTitle:@" 收藏 " forState:UIControlStateNormal];

    [collectBtn setTitle:@"已收藏" forState:UIControlStateSelected];
       [collectBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
       collectBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(10)];
     [collectBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:scale(5)];
    [collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
   UIButton *helptBtn = [UIButton new];
          [bottomView addSubview:helptBtn];
          [helptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(collectBtn.mas_right).offset(5);
              make.height.mas_equalTo(scale(40));
              make.right.mas_equalTo(buyBtn.mas_left).offset(-5);
              make.centerY.mas_equalTo(buyBtn.mas_centerY).offset(0);
          }];
       helptBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
       [helptBtn setImage:[UIImage imageNamed:@"help_good"] forState:UIControlStateNormal];
          [helptBtn setTitle:@"上架帮助" forState:UIControlStateNormal];
    [helptBtn addTarget:self action:@selector(helpAction) forControlEvents:UIControlEventTouchUpInside];
          [helptBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
          helptBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(10)];
        [helptBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:4];
    if (appDelegate.auditStatus == 0) {
        helptBtn.hidden = NO;
    }
    else
    {
        helptBtn.hidden = YES;
    }
    }
    else
    {
        UIButton *helptBtn = [UIButton new];
        [bottomView addSubview:helptBtn];
        [helptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(bottomView.mas_left).offset(0);
            make.height.mas_equalTo(scale(49));
            make.centerX.mas_equalTo(bottomView.mas_centerX).offset(0);
            make.top.mas_equalTo(bottomView.mas_top).offset(0);
        }];
        [helptBtn setTitle:@"已下架" forState:UIControlStateNormal];
        helptBtn.backgroundColor = COLOR_STR(0xC0C0C0);
        [helptBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
        helptBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:scale(16)];


    }
}
-(void)applyGoods:(UIButton *)sender
{

    [self getUserInfo:sender];

   
}
-(void)oooo
{

    if (isNotNull([self userId])) {

        [self getAddress];
        _freeView = [[FreeGoodView alloc]init];
        [self.view addSubview:_freeView];
        _freeView.addBlock = ^{

            Goumee_AddAreaViewController *vc = [[Goumee_AddAreaViewController alloc]init];
            vc.click = ^(NSDictionary * _Nonnull model) {
                addressModel = model;
                _freeView.address_name.text  = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
                _freeView.address_context.text  =  [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
                [_freeView.leftBtn setTitle:@"更换地址" forState:UIControlStateNormal];
                 _freeView.tipLab.hidden = YES;
            };
            [self.navigationController pushViewController:vc animated:YES];




        };
        _freeView.changeBlock = ^{

            GouMee_AddressViewController *vc = [[GouMee_AddressViewController alloc]init];
            vc.addressModel = addressModel;
            vc.click = ^(NSDictionary * _Nonnull model) {
                addressModel = model;
                  _freeView.tipLab.hidden = YES;
                _freeView.address_name.text  = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
                _freeView.address_context.text  =  [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
                [_freeView.leftBtn setTitle:@"更换地址" forState:UIControlStateNormal];
            };
            [self.navigationController pushViewController:vc animated:YES];


        };
        _freeView.applyBlock = ^{
            [self getApplyJson];
        };
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)getUserInfo:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    [Network GET:[NSString stringWithFormat:@"api/v1/users/%@/",[self userId]] paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {

            BOOL status = [data[@"data"][@"allow_sample"] boolValue];
            if (status == YES) {
                [self oooo];
            }
            else
            {
                JoinMessageView *view = [[JoinMessageView alloc]init];
                view.titleLabs.text = @"申请失败";
                view.contextLabs.text = @"您当前暂不符合申请条件，如您有疑问请联系您的对接人";
                [self.view addSubview:view];

            }
        }
        else
        {
            if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [Network showMessage:data[@"message"] duration:2.0];
                GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                vc.pushType = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                [Network showMessage:data[@"message"] duration:2.0];
            }
        }
        sender.userInteractionEnabled = YES;
    } error:^(id data) {
 sender.userInteractionEnabled = YES;
    }];

}
//提交申请
-(void)getApplyJson
{
    if (isNotNull([self userId])) {
    if (!isNotNull(addressModel)) {
       _freeView.tipLab.hidden = NO;
        _freeView.tipLab.text = @"请填写寄样地址";
        return;
    }
    if ([_freeView.timeBtn.titleLabel.text isEqualToString:@"选择直播排期"]) {
        _freeView.tipLab.hidden = NO;
        _freeView.tipLab.text = @"请选择预估直播排期时间";
         return; 
    }
         [_freeView removeFromSuperview];
     NSString *ss = [Network timestampSwitchTime:[Network timeSwitchTimestamp: _freeView.timeBtn.titleLabel.text andFormatter:@"YYY.MM.dd HH:mm"] andFormatter:@"YYY-MM-dd HH:mm"];
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setObject:self.goodId forKey:@"good"];
    [parm setObject:addressModel[@"id"] forKey:@"address_key"];
    [parm setObject:ss forKey:@"start_time"];
    [Network POST:@"api/v1/samples/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {

            [Network showMessage:@"申请成功" duration:2.0];
        }
        else
        {
            if ([data[@"error_code"] intValue] == 1110) {
                                JoinMessageView *view = [[JoinMessageView alloc]init];
                                view.titleLabs.text = @"申请失败";
                                view.contextLabs.text = data[@"message"];
                                [self.view addSubview:view];
                            }
                           else
                           {
                           [Network showMessage:data[@"message"] duration:2.0];
                               
                           }
        }
    } error:^(id data) {
        
    }];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)getAddress
{
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
          [parm setObject:[self userId] forKey:@"user"];
             [parm setObject:@(1) forKey:@"page"];
             [parm setObject:@(1) forKey:@"page_size"];
             
             [Network GET:@"api/v1/addresses/" paramenters:parm success:^(id data) {
                 if (isNotNull(data[@"data"])) {
                     if (isNotNull(data[@"data"][@"results"])) {
                           NSDictionary *model = data[@"data"][@"results"][0];
                         addressModel = model;
                          _freeView.address_name.text  = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
                               _freeView.address_context.text  =  [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
                         _freeView.choose_tip.hidden = YES;
                                    [_freeView.leftBtn setTitle:@"更换地址" forState:UIControlStateNormal];
                           
                     }
                     else
                     {
                         _freeView.address_context.text = @"";
                         _freeView.address_name.text = @"组团成功后我们会给您寄送样品，请先添加收货地址";
                         _freeView.choose_tip.hidden = NO;
                           [_freeView.leftBtn setTitle:@"添加地址" forState:UIControlStateNormal];
                     }
                   
                     
                 }
             } error:^(id data) {
                 
             }];
    
}
-(void)helpAction
{
    DY_SheetView *vc = [[DY_SheetView alloc]init];
                                       [self.view addSubview:vc];
                             
                              vc.taobaoclick = ^{
                                   [self pushwebView:@"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/shangjia-douyin.mp4"];
                              };
                              vc.pidclick = ^{
                                 
                                  [self pushwebView:@"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/taobao-pid.mp4"];
                              };
                                    [self FirstEnterGoods];
                                
}
-(void)uptoDY
{
//    if (isNotNull([self PID])) {
    if (isNotNull([self userId])) {

        NSString *str = @"1";
               if (isNotNull(_datas[@"coupon_share_url"])) {
                   str = @"2";
                        }
                        else
                        {
                            str = @"1";
                        }
               
               [Network GET:@"api/v1/taokouling_create/" paramenters:@{@"item_id":taoBaoID,@"choice":str} success:^(id data) {
                   if ([data[@"success"] intValue] == 1) {
                       UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                       pasteboard.string=data[@"data"][@"taokouling"];
                       
                       if ([self isFirstGoods] == YES) {
                                 DY_SheetView *vc = [[DY_SheetView alloc]init];
                                    [self.view addSubview:vc];
                           vc.click = ^{
                               [self copyTKL];
                           };
                           vc.taobaoclick = ^{
                                [self pushwebView:@"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/shangjia-douyin.mp4"];
                           };
                           vc.pidclick = ^{
                              
                               [self pushwebView:@"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/taobao-pid.mp4"];
                           };
                                 [self FirstEnterGoods];
                             }
                          else
                          {
                              [self copyTKL];
                          }
                   }
                   else
                   {
                       if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                           [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                           [[NSUserDefaults standardUserDefaults]synchronize];
                           [Network showMessage:data[@"message"] duration:2.0];
                           GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                           vc.pushType = 1;
                           [self.navigationController pushViewController:vc animated:YES];
                       }
                       else
                       {
                       [Network showMessage:data[@"message"] duration:2.0];
                       }
                   }
               } error:^(id data) {
                   
               }];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
//    }
//    else
//    {
//        PID_SheetView *vc = [[PID_SheetView alloc]init];
//        vc.context = @"您尚未分配淘宝PID，无法\n正常计算返利，请联系下方\n微信获取。";
//        [self.view addSubview:vc];
//
//    }
    
}
-(void)pushwebView:(NSString *)url
{
    GouMee_SelVideoViewController *vc = [[GouMee_SelVideoViewController alloc]init];
    vc.urlString = url;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)copyTKL
{
    if (isNotNull([self userId])) {

    PID_SheetView *vc = [[PID_SheetView alloc]init];
    vc.context = @"\n淘口令已复制成功\n";
    [self.view addSubview:vc];
    vc.click = ^{
        [self pushDY];
    };
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)pushDY
{
        NSURL *url = [NSURL URLWithString:@"snssdk1128://"];
    
           // 判断当前系统是否有安装淘宝客户端
           if ([[UIApplication sharedApplication] canOpenURL:url]) {
               // 如果已经安装淘宝客户端，就使用客户端打开链接
               [[UIApplication sharedApplication] openURL:url];
    
           } else {
    
               [Network showMessage:@"您的手机还没有安装抖音" duration:2.0];
           }
        
}
-(void)buyClick
{
//   if (isNotNull([self PID])) {
    if (isNotNull([self userId])) {

       if (isNotNull(_datas[@"coupon_share_url"])) {
           if ([_datas[@"is_invalid_coupon"] boolValue] == 1) {
                [self showItemInTaobao4iOS:_datas[@"url"]];
           }
           else
           {
                 [self showItemInTaobao4iOS:_datas[@"coupon_share_url"]];
           }
              
          }
          else
          {
            [self showItemInTaobao4iOS:_datas[@"url"]];
          }
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
//       }
//    else
//    {
//   PID_SheetView *vc = [[PID_SheetView alloc]init];
//         vc.context = @"您尚未分配淘宝PID，无法\n正常计算返利，请联系下方\n微信获取。";
//                [self.view addSubview:vc];
//            
//    }
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
-(void)collectClick:(UIButton *)sender
{
   
    if (isNotNull([self userId])) {

    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
   [parm setObject:self.goodId forKey:@"good"];
    [parm setObject:@(!sender.selected) forKey:@"is_active"];
    
    [Network POST:@"api/v1/favorites/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            if (sender.selected == YES) {
                [Network showMessage:@"取消收藏成功" duration:2.0];
            }
            else
            {
             [Network showMessage:@"收藏成功" duration:2.0];
            }
            sender.selected = !sender.selected;;
        }
        else
        {
            if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [Network showMessage:data[@"message"] duration:2.0];
                GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
                vc.pushType = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
            [Network showMessage:data[@"message"] duration:2.0];
            }
        }
       
    } error:^(id data) {
        
    }];
    }
    else
    {
        GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
        vc.pushType = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)copyClick
{
    if ([self isFirstGoods] == YES) {
        DY_SheetView *vc = [[DY_SheetView alloc]init];
           [self.view addSubview:vc];
        vc.click = ^{
                                      [self copyTKL];
                                  };
                                  vc.taobaoclick = ^{
                                       [self pushwebView:@"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/shangjia-douyin.mp4"];
                                  };
                                  vc.pidclick = ^{
                                     
                                      [self pushwebView:@"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/taobao-pid.mp4"];
                                  };
        [self FirstEnterGoods];
    }
   
}
-(void)backA
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView { // 判断webView所在的cell是否可见，如果可见就layout
    NSArray *cells = self.collectionView.visibleCells;
    for (UICollectionViewCell *cell in cells) {
        if ([cell isKindOfClass:[GoodsWebbViewCell class]]) {
            GoodsWebbViewCell *webCell = (GoodsWebbViewCell *)cell;
            [webCell.webView setNeedsLayout];
        }
    }
    topNaviView.alpha =1-scrollView.contentOffset.y/[self navHeight];
    bomNaviView.alpha =scrollView.contentOffset.y/[self navHeight];

}

- (void)addCollectionView {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = COLOR_STR(0xf0f0f0);
    layout.estimatedItemSize = CGSizeZero;
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
      [_collectionView registerClass:[GoodsWebbViewCell class] forCellWithReuseIdentifier:@"GoodsWebbViewCell"];
     [_collectionView registerClass:[CouspondViewCell class] forCellWithReuseIdentifier:@"CouspondViewCell"];
     [_collectionView registerClass:[LiveSaleViewCell class] forCellWithReuseIdentifier:@"LiveSaleViewCell"];
     [_collectionView registerClass:[CommnditCollectViewCell class] forCellWithReuseIdentifier:@"CommnditCollectViewCell"];
     [_collectionView registerClass:[StoreDetailViewCell class] forCellWithReuseIdentifier:@"StoreDetailViewCell"];
     [_collectionView registerClass:[SellPointViewCells class] forCellWithReuseIdentifier:@"SellPointViewCells"];
     [_collectionView registerClass:[GoodsFuliListViewCell class] forCellWithReuseIdentifier:@"GoodsFuliListViewCell"];

    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_collectionView registerClass:[LoopCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LoopCollectionReusableView"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-[self statusBarHeight]);
        make.right.left.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
                          make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-49);
                      } else {
                          make.bottom.equalTo(self.view.mas_bottom).offset(-49);
                      }
    }];

}



#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 9;
    }
    else if (section == 1)
    {

        return 2;
    }
    if (self.datas > 0) {
        return [pictureArr count];
    }
        return 0;
        

}
-(void)rule
{
    IntroduceWebView *view = [[IntroduceWebView alloc]init];
    view.titleLab.text = @"库然专享福利";
    view.url = @"https://kuran.goumee.com/h5/welfare.html";
    [view showInView:self.view];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
             CouspondViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CouspondViewCell" forIndexPath:indexPath];
            if (isNotNull(_datas)) {
                   cell.model = _datas;
               
            }
            [cell.ruleBtn addTarget:self action:@selector(rule) forControlEvents:UIControlEventTouchUpInside];
                   return cell;
        }
        else if (indexPath.row < 8)
        {
            GoodsFuliListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsFuliListViewCell" forIndexPath:indexPath];
            if (isNotNull(_datas)) {
                NSDictionary *fuli = self.datas[@"kurangoods"];

                    if ([fuli[@"data_source"] integerValue] == 2) {
                [cell addModel:_datas index:indexPath.row+1];
                    }
                else
                {

                    [cell addModels:_datas indexs:indexPath.row+1];
                }

            }

            return cell;


        }
        else
        {
             StoreDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreDetailViewCell" forIndexPath:indexPath];
           
            [cell.storeView.enterStore addTarget:self action:@selector(enterX) forControlEvents:UIControlEventTouchUpInside];
            if (_datas) {
                [cell addModel:_datas];
            }
            
            return cell;
        }

    }
    else if (indexPath.section == 1)
    {

        if (indexPath.row == 0) {

        CommnditCollectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommnditCollectViewCell" forIndexPath:indexPath];
        if (isNotNull(self.datas)) {
            cell.model = self.datas;
        }
             return cell;
        }
        else
        {
            SellPointViewCells *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SellPointViewCells" forIndexPath:indexPath];
            if (isNotNull(self.datas)) {
                [cell addModel:self.datas];

            }
 return cell;
        }



    }

  else {
       
            GoodsWebbViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsWebbViewCell" forIndexPath:indexPath];
      if (_datas) {
         NSString *url = pictureArr[indexPath.row];
           [cell.backImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
      }

            return cell;
    }
}
-(void)enterX
{
    GouMee_StoreViewController *vc = [[GouMee_StoreViewController alloc]init];
    vc.storeId =[NSString stringWithFormat:@"%@",_datas[@"seller_id"]] ;
    vc.shopInfo = _datas;
    [self.navigationController pushViewController:vc animated:YES];
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

        CGSize baseSize = CGSizeMake(SW-scale(89), CGFLOAT_MAX);
        if (isNotNull(_datas)) {
 NSDictionary *fuli = self.datas[@"kurangoods"];
        if (indexPath.row == 0) {
             if ([fuli[@"data_source"] integerValue] == 2) {
            CouspondViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
             CGSize labelsize = [cell.titleLab sizeThatFits:baseSize];
            return CGSizeMake(SW, labelsize.height+scale(13));
             }
            else
            {
              return CGSizeMake(SW, 0);

            }
        }
        else if (indexPath.row < 8)
        {
             GoodsFuliListViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
            if ([fuli[@"data_source"] integerValue] == 2) {

            CGSize labelsize = [cell.titleLab sizeThatFits:baseSize];
            if (labelsize.height > 0.0) {
                 return CGSizeMake(SW, labelsize.height+scale(13));
            }
            else
            {
             return CGSizeMake(SW, 0);
            }
            }
            else
            {

                CGSize labelsize = [cell.contexts sizeThatFits:baseSize];
                if (labelsize.height > 0.0) {
                    return CGSizeMake(SW, labelsize.height+scale(13));
                }
                else
                {
                    return CGSizeMake(SW, 0);
                }

            }
        }
            else
            {
               return CGSizeMake(SW, scale(88));
            }


        }

        return CGSizeMake(SW, 0);
       
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
return CGSizeMake(SW, scale(270));
        }
        else
        {
 if (isNotNull(self.datas)) {

   if (isNotNull(self.datas[@"sell_point"])) {
    return CGSizeMake(SW, scale(58)+[self sizeWithFont:font(14) maxSize:CGSizeMake(SW-scale(24), 1000) string:self.datas[@"sell_point"]]);
   }
            else
            {
return CGSizeMake(SW, 0);

            }

 }
            else
            {
return CGSizeMake(SW, 0);

            }
        }


    }
    if (self.datas.count > 0) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey: pictureArr[indexPath.row]];
             
           // 没有找到已下载的图片就使用默认的占位图，当然高度也是默认的高度了，除了高度不固定的文字部分。
           if (!image) {
               image = [UIImage imageNamed:@"goods_bg"];
           }
           //手动计算cell
           CGFloat imgHeight = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
           return CGSizeMake(SW, imgHeight);
    }
    return CGSizeMake((SW), 0);

}
-(CGFloat)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string{

    NSDictionary *attrs = @{NSFontAttributeName:font};

    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;

}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
         CGSize baseSize = CGSizeMake(SW-scale(24), CGFLOAT_MAX);
        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(scale(12), 0, SW-scale(24), 100)];
        labe.numberOfLines = 2;
       UIFont *fond1= [UIFont fontWithName:@"PingFangSC-Medium" size:scale(16)];
        labe.text =[NSString stringWithFormat:@"       %@",self.datas[@"title"]];
        labe.font = fond1;
//       CGFloat stringSize =  [self sizeWithFont:fond1 maxSize:CGSizeMake(SW-scale(24), 1000) string:[NSString stringWithFormat:@"       %@",self.datas[@"title"]]];
      CGSize hh =   [labe sizeThatFits:baseSize];
        CGFloat stringSize1 =  [self sizeWithFont:fond1 maxSize:CGSizeMake(SW-scale(24), 1000) string:@"券后价"];
           return CGSizeMake(SW, SW+38+hh.height+stringSize1);
    }
    return CGSizeMake(SW, 0);
}

- (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font
{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
         return rect.size.height;

    

}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section != 2) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section != 2) {
        return 0;
    } else {
        return 10;
    }
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LoopCollectionReusableView" forIndexPath:indexPath];
            return headerView;
    
        }
    return nil;
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
