//
//  Goumee_OrderDetailViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_OrderDetailViewController.h"
#import "FreeGoodView.h"
#import "SendSheetView.h"
#import "GouMee_LoginViewController.h"
#import "ExpressDetailViewController.h"
@interface Goumee_OrderDetailViewController ()
{
    UILabel *statusLab;
    NSInteger buttonType;
    UIView *statusView;//订单状态view
    UIView *sendView;//
    UIView *orderView;
    UIView *changeView;
    UIView *addressView;
    UIView *goodView;
    UIView *timeView;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat contentY;
@property (nonatomic, strong)NSMutableDictionary *datas;
@property (nonatomic, strong)NSMutableArray *expresssources;
@end

@implementation Goumee_OrderDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self resetWhiteNavBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.view.backgroundColor = viewColor;

    buttonType = 0;
    self.contentY = 0;
    [self.view addSubview:self.scrollView];
    [self json];
    
}
-(void)json
{
 self.contentY = 0;
    [Network GET:[NSString stringWithFormat:@"api/v1/samples/%@/",self.ID] paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {

            _datas = [NSMutableDictionary dictionaryWithDictionary:data[@"data"]];
              if (buttonType == 0) {
                  
            if (isNotNull(_datas[@"send_express"])) {
              
                     [self getExpressJson:_datas[@"send_express"][@"id"]];
    
            }
            else
            {
                        [self creatStatusView];
                  [self creatSendView];
                         [self creatChangeBtnView];
                        [self creatOrderView];
                        [self creatAddressView];
                        [self creatGoodsView];
                        [self creatOrderTimeView];
                        [self creatBottomView];
                        [self updateScrollViewContentSize];
            }
              }
            else
            {
                   
                        if (isNotNull(_datas[@"sendback_express"])) {
                          
                                 [self getExpressJson:_datas[@"sendback_express"][@"id"]];
                
                        }
                        else
                        {
                                            [self creatStatusView];
                              [self creatSendView];
                                     [self creatChangeBtnView];
                                            [self creatOrderView];
                                            [self creatAddressView];
                                            [self creatGoodsView];
                                            [self creatOrderTimeView];
                                            [self creatBottomView];
                                            [self updateScrollViewContentSize];
                        }
                
            }
           
            
            
        }
       else if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [Network showMessage:data[@"message"] duration:2.0];
            GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } error:^(id data) {
        
    }];
}
-(void)getExpressJson:(NSString *)string
{
    [Network GET:[NSString stringWithFormat:@"api/v1/express/%@/",string] paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            
            _expresssources = [NSMutableArray arrayWithArray:data[@"data"][@"data"]];
        }
        else if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [Network showMessage:data[@"message"] duration:2.0];
            GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
   

        [self creatStatusView];
        [self creatSendView];
        [self creatChangeBtnView];
        [self creatOrderView];
        [self creatAddressView];
        [self creatGoodsView];
        [self creatOrderTimeView];
        [self creatBottomView];
        [self updateScrollViewContentSize];
    } error:^(id data) {
        
    }];
    
}
-(void)creatBottomView
{
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
                  make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
                  } else {
                  make.bottom.equalTo(self.view.mas_bottom).offset(0);
                  }
                  make.left.right.mas_equalTo(0);
                  make.height.mas_equalTo(scale(49));
    }];
    UILabel *topLab = [UILabel new];
    [backView addSubview:topLab];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.bottom.mas_equalTo(backView.mas_centerY).offset(0);
        make.left.mas_equalTo(backView.mas_left).offset(scale(15));
    }];
    topLab.font = font(12);
    topLab.textColor = COLOR_STR(0x333333);
    topLab.text = @"直播排期";

    UILabel *timeLab = [UILabel new];
    [backView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {

       make.left.mas_equalTo(backView.mas_left).offset(scale(15));
        make.top.mas_equalTo(backView.mas_centerY).offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(-3);
        
    }];
    timeLab.font = font(12);
    timeLab.textColor = COLOR_STR(0x333333);
    timeLab.text =[NSString stringWithFormat:@"%@",[Network timestampSwitchTime:[Network timeSwitchTimestamp:self.datas[@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"yyyy.MM.dd HH:mm"]];
    
    UIButton *certainBtn = [UIButton new];
    [backView addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(backView.mas_right).offset(scale(-15));
        make.height.mas_equalTo(scale(30));
        make.width.mas_equalTo(scale(90));
    }];
    certainBtn.layer.cornerRadius = scale(15);
    certainBtn.layer.masksToBounds = YES;
    certainBtn.titleLabel.font = font(12);
    NSInteger status = [self.datas[@"status"] intValue];
    NSInteger haha =  [self.datas[@"live_type"] intValue];
     NSInteger type = [self.datas[@"change_count"] intValue];
    if (status == 2) {
         [certainBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        if (haha != 1) {

        UIButton *changeBtn = [UIButton new];
        [backView addSubview:changeBtn];
        [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(certainBtn.mas_left).offset(scale(-10));
            make.height.mas_equalTo(scale(30));
            make.width.mas_equalTo(scale(90));
        }];
        changeBtn.layer.cornerRadius = scale(15);
        changeBtn.layer.masksToBounds = YES;
        changeBtn.titleLabel.font = font(12);
        [changeBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
        [changeBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        [changeBtn addTarget:self action:@selector(aaaaa:) forControlEvents:UIControlEventTouchUpInside];
            if (type == 0) {

            if ([self date:[self dateFromString:self.datas[@"start_time"]] isBetweenDate:[self getNowTimeTimestamp3]]) {
                changeBtn.hidden = NO;
            }
            else
            {
                changeBtn.hidden = YES;

            }
            }
            else
            {
                changeBtn.hidden = YES;
            }
         [changeBtn setTitle:@"修改直播排期" forState:UIControlStateNormal];
        }

    }
    else if (status == 1)
    {
          if (haha == 1) {
              certainBtn.hidden = YES;
          }
        else
        {
            if (type == 0) {
            if ([self date:[self dateFromString:self.datas[@"start_time"]] isBetweenDate:[self getNowTimeTimestamp3]]) {
                certainBtn.hidden = NO;
            }
            else
            {
                certainBtn.hidden = YES;

            }
            }
            else
            {
 certainBtn.hidden = YES;

            }
[certainBtn setTitle:@"修改直播排期" forState:UIControlStateNormal];
        }

    }
   else if (status == 3) {


       if (haha != 1) {
   
       if (type == 0) {


           if ([self date:[self dateFromString:self.datas[@"start_time"]] isBetweenDate:[self getNowTimeTimestamp3]]) {
              certainBtn.hidden = NO;
           }
           else
           {
 certainBtn.hidden = YES;

           }

       }
       else
       {
           certainBtn.hidden = YES;
       }
         [certainBtn setTitle:@"修改直播排期" forState:UIControlStateNormal];
       }
       else
       {
           certainBtn.hidden = YES;
       }
    }
    else if(status == 6)
    {
        certainBtn.hidden = NO;
         [certainBtn setTitle:@"寄回样品" forState:UIControlStateNormal];
    }
    else if(status == 7)
       {
           certainBtn.hidden = NO;
            [certainBtn setTitle:@"修改寄回物流" forState:UIControlStateNormal];
       }
    else
    {
         certainBtn.hidden = YES;
    }
   
    [certainBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    [certainBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [certainBtn addTarget:self action:@selector(aaaaa:) forControlEvents:UIControlEventTouchUpInside];
}

-(NSDate *)dateFromString:(NSString *)datestring



{

        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

        NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;

        NSDateFormatter *format=[[NSDateFormatter alloc] init];

        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        NSDate *fromdate=[format dateFromString:datestring];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: fromdate];
    NSDate *localeDate = [fromdate  dateByAddingTimeInterval: interval];


        return localeDate;



}
-(NSDate *)getNowTimeTimestamp3{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;


    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//
//    [formatter setTimeZone:timeZone];

    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];



    return localeDate;

}
- (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate

{

        if ([date compare:beginDate] == NSOrderedAscending)
    {

                return NO;

    }



        return YES;

}


-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"shouhuo" object:nil];
   
}
-(void)aaaaa:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"确认收货"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认收货" message:@"确认已收到货品?" preferredStyle:UIAlertControllerStyleAlert];
              
              UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
              UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  NSMutableDictionary *parm = [NSMutableDictionary dictionary];
                  [parm setObject:self.datas[@"id"] forKey:@"id"];
                  [parm setObject:@(3) forKey:@"status"];
                  [Network POST:@"api/consumer/v1/sample-apply-change/" paramenters:parm success:^(id data) {
                      if ([data[@"success"] intValue] == 1) {
                          [[NSNotificationCenter defaultCenter] postNotificationName:@"shouhuo" object:@"1"];
                          [self json];
                      }
                      else
                                     {
                                         [Network showMessage:data[@"message"] duration:2.0];
                                     }
                  } error:^(id data) {
                      
                  }];
              }];
              
              [alertController addAction:cancelAction];
              [alertController addAction:okAction];
              [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([sender.titleLabel.text isEqualToString:@"寄回样品"])
    {
        SendSheetView *view = [[SendSheetView alloc]init];
        view.titleLab.text = @"寄回样品";
        NSString *str =self.datas[@"delivery_address"];
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
      view.contextLab.text = [NSString stringWithFormat:@"%@ %@\n%@",self.datas[@"receiver"],self.datas[@"receiver_mobile"],str];
        view.click = ^(NSString *expressname, NSString *expressno) {
            NSMutableDictionary *parm = [NSMutableDictionary dictionary];
            [parm setObject:expressname forKey:@"com"];
            [parm setObject:expressno forKey:@"nu"];
            [parm setObject:self.datas[@"id"] forKey:@"id"];
            [Network POST:@"/api/consumer/v1/sample-express/" paramenters:parm success:^(id data) {
                if ([data[@"success"] intValue] == 1) {
                    [self json];
                     [Network showMessage:data[@"message"] duration:2.0];
                }
                else
                {
                    [Network showMessage:data[@"message"] duration:2.0];

                }
            } error:^(id data) {

            }];
        };

         [self.view.window addSubview:view];
    }
    else if ([sender.titleLabel.text isEqualToString:@"修改寄回物流"])
    {
        SendSheetView *view = [[SendSheetView alloc]init];
         view.titleLab.text = @"修改寄回物流";
        view.exzz = self.datas[@"sendback_express"][@"com"];
        NSString *str =self.datas[@"delivery_address"];
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        view.contextLab.text = [NSString stringWithFormat:@"%@ %@\n%@",self.datas[@"receiver"],self.datas[@"receiver_mobile"],str];
        view.expressNo.text = self.datas[@"sendback_express"][@"nu"];
        view.expressName.text = self.datas[@"sendback_express"][@"com_name"];
        view.click = ^(NSString *expressname, NSString *expressno) {
            NSMutableDictionary *parm = [NSMutableDictionary dictionary];
            [parm setObject:expressname forKey:@"com"];
            [parm setObject:expressno forKey:@"nu"];
            [parm setObject:self.datas[@"id"] forKey:@"id"];
            [Network POST:@"/api/consumer/v1/sample-express/" paramenters:parm success:^(id data) {
                if ([data[@"success"] intValue] == 1) {
                    [self json];
                    [Network showMessage:data[@"message"] duration:2.0];
                }
                else
                {
                    [Network showMessage:data[@"message"] duration:2.0];

                }
            } error:^(id data) {

            }];
        };

        [self.view.window addSubview:view];
    }
    else
    {
        FreeGoodView *views = [[FreeGoodView alloc]init];
        views.tip.text = @"修改直播排期";
        views.tipss.hidden = YES;
        views.address_name.hidden = YES;
        views.tipLab.hidden = YES;
        views.centerBtn.hidden = NO;
       
         NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp: self.datas[@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
        [views.timeBtn setTitle:time forState:UIControlStateNormal];
        [views.timeBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
        views.leftBtn.hidden = YES;
        views.rightBtn.hidden = YES;
        views.choose_tip.hidden = YES;
        views.address_context.text = @"直播排期只能修改一次，我们会根据实际播出进行信用评估，请谨慎操作";
        views.shenqing = @"12";
        views.address_context.numberOfLines = 0;
        views.applyBlock = ^{
            [views removeFromSuperview];
            NSString *ss = [Network timestampSwitchTime:[Network timeSwitchTimestamp: views.timeBtn.titleLabel.text andFormatter:@"YYY.MM.dd HH:mm"] andFormatter:@"YYY-MM-dd HH:mm"];
            NSMutableDictionary *parm = [NSMutableDictionary dictionary];
            [parm setObject:self.datas[@"id"] forKey:@"id"];
            [parm setObject:ss forKey:@"start_time"];
            [Network POST:@"api/consumer/v1/sample-apply-change/" paramenters:parm success:^(id data) {
                if ([data[@"success"] intValue] == 1) {
                    sender.hidden = YES;
                    [Network showMessage:@"直播排期修改成功" duration:2.0];
                    [self json];
                }
                else
                {
                    [Network showMessage:data[@"message"] duration:2.0];
                }
            } error:^(id data) {
                
            }];
            
        };
        [self.view.window addSubview:views];
    }
    
}

-(void)creatStatusView
{
    self.contentY = scale(1);
    if (statusView) {
        [statusView removeFromSuperview];
    }
    statusView= [[UIView alloc]initWithFrame:CGRectMake(0, self.contentY, SW, scale(44))];
    statusView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:statusView];
    UILabel *tip = [UILabel new];
    [statusView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(statusView.mas_left).offset(scale(15));
    }];
    tip.textColor = COLOR_STR(0x333333);
    tip.font = font(12);
    tip.text = @"订单状态:";
    statusLab = [UILabel new];
    [statusView addSubview:statusLab];
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(tip.mas_right).offset(scale(10));
    }];
    statusLab.textColor = ThemeRedColor;
    statusLab.font = font1(@"PingFangSC-Medium", scale(14));

    self.contentY += scale(54);
    if (isNotNull(self.datas)) {
        NSInteger status = [self.datas[@"status"] intValue];
        switch (status) {
                   case 0:
                          {
                              statusLab.text = @"待审核";
                            
                          }
                    break;
               case 1:
               {
                   statusLab.text = @"待发货";
                  
               }
                   break;
                   case 2:
                          {
                              statusLab.text = @"已发货";
                             
                          }
                              break;
                   case 3:
                          {
                              statusLab.text = @"已收货";
                         
                          }
                              break;
                   case 4:
                          {
                              statusLab.text = @"已取消";
                             
                          }
                              break;
                   case 5:
                          {
                              statusLab.text = @"未通过";
                            
                          }
                              break;
                case 6:
                                         {
                                             statusLab.text = @"样品待寄回";
                                           
                                         }
                                             break;
                case 7:
                                         {
                                             statusLab.text = @"寄回待确认";
                                           
                                         }
                                             break;
                case 8:
                                         {
                                             statusLab.text = @"样品已回收";
                                           
                                         }
                                             break;
                   
               default:
                   break;
           }
    }
    
}
-(void)creatSendView
{
    if (sendView) {
        [sendView removeFromSuperview];
    }
   sendView= [[UIView alloc]initWithFrame:CGRectMake(0, self.contentY, SW, scale(113))];
    [self.scrollView addSubview:sendView];
    sendView.backgroundColor = [UIColor whiteColor];

    UILabel *tips = [UILabel new];
    [sendView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(scale(15));
        make.height.mas_equalTo(scale(44));
    }];
    tips.font = font1(@"PingFangSC-Medium", scale(14));
    tips.textColor = COLOR_STR(0x333333);
    
    
    UILabel *CourierLab = [UILabel new];
       [sendView addSubview:CourierLab];
       [CourierLab mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(tips.mas_bottom).offset(0);
        make.left.mas_equalTo(scale(47));
        make.bottom.mas_equalTo(scale(-5));
        make.right.mas_equalTo(scale(-15));
       }];
       CourierLab.text = @"";
       CourierLab.textColor = COLOR_STR(0x333333);
       CourierLab.font = font(12);
    CourierLab.numberOfLines = 0;
    UIImageView *CourierIcon = [UIImageView new];
    [sendView addSubview:CourierIcon];
    [CourierIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(CourierLab.mas_centerY).offset(0);
        make.left.mas_equalTo(scale(15));
        make.height.width.mas_equalTo(scale(22));
    }];
   
     NSInteger status = [self.datas[@"status"] intValue];
    NSInteger typ= [self.datas[@"is_recycle"] integerValue];
    if (typ == 1) {

    if (status< 7) {
         tips.text = @"直播结束后请将样品寄回到以下地址：";
         CourierIcon.image = [UIImage imageNamed:@"shop_send"];
        NSString *str =self.datas[@"delivery_address"];
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];

        CourierLab.text = [NSString stringWithFormat:@"%@ %@\n%@",self.datas[@"receiver"],self.datas[@"receiver_mobile"],str];
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:CourierLab.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, CourierLab.text.length)];
        CourierLab.attributedText = attributedString;

        CourierLab.lineBreakMode = NSLineBreakByTruncatingTail;

        CGSize baseSize = CGSizeMake(SW-scale(62), CGFLOAT_MAX);
        CGSize labelsize = [CourierLab sizeThatFits:baseSize];
         sendView.frame = CGRectMake(0, self.contentY, SW, scale(49)+labelsize.height);
        self.contentY += scale(59)+labelsize.height;


    }
    }

}
-(void)creatOrderView
{
    if (orderView) {
        [orderView removeFromSuperview];
    }
   orderView = [[UIView alloc]init];
    [self.scrollView addSubview:orderView];
    orderView.backgroundColor = [UIColor whiteColor];

        if (_expresssources.count > 0) {
        orderView.frame = CGRectMake(0, self.contentY, SW, scale(82));
        }
        else
        {
             orderView.frame = CGRectMake(0, self.contentY, SW, scale(42));
        }

    
    UIView *line = [UIView new];
    [orderView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(scale(1));
    }];
    line.backgroundColor = viewColor;
    
    UIImageView *CourierIcon = [UIImageView new];
    [orderView addSubview:CourierIcon];
    [CourierIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(scale(15));
        make.width.height.mas_equalTo(scale(22));
    }];
    if (buttonType == 1) {
CourierIcon.image = [UIImage imageNamed:@"express_icon1"];
    }
    else
    {
    CourierIcon.image = [UIImage imageNamed:@"express_icon"];
    }
    
    UIImageView *rightIcon = [UIImageView new];
       [orderView addSubview:rightIcon];
    rightIcon.backgroundColor = [UIColor whiteColor];
       [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(0);
           make.right.mas_equalTo(scale(-15));
           make.width.height.mas_equalTo(scale(16));
       }];

    UILabel *CourierLab = [UILabel new];
    [orderView addSubview:CourierLab];
    CourierLab.text = @"中通快递 165256433563";
    CourierLab.textColor = COLOR_STR(0x333333);
    CourierLab.font = font(12);
    
    UILabel *routeLab = [UILabel new];
    [orderView addSubview:routeLab];
    routeLab.text = @"【杭州市】浙江省杭州市江干区九堡一公司派件员:王dhdhhd";
    routeLab.textColor = COLOR_STR(0x333333);
    routeLab.font = font(12);
    
    UILabel *timeLab = [UILabel new];
    [orderView addSubview:timeLab];
    timeLab.text = @"2020.03.29  10:34:07";
    timeLab.textColor = COLOR_STR(0x999999);
    timeLab.font = font(12);
      
    
    if (_expresssources.count == 0) {
         [CourierLab mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.centerY.mas_equalTo(CourierIcon.mas_centerY).offset(0);
                  make.left.mas_equalTo(CourierIcon.mas_right).offset(scale(10));
              }];
        if (isNotNull(_datas)) {
            if (buttonType == 0) {
                CourierLab.text = [NSString stringWithFormat:@"%@ %@",self.datas[@"express_company"],self.datas[@"express_no"]];
            }
            else
            {
                CourierLab.text = [NSString stringWithFormat:@"%@ %@",self.datas[@"sendback_express"][@"com_name"],self.datas[@"sendback_express"][@"nu"]];
            }
                          if (isNotNull(self.datas[@"express_company"])) {
                               self.contentY += scale(43);
                          }
            else
            {
                 self.contentY += scale(0);
            }
        }
       
    }
    else
    {
        [routeLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerY.mas_equalTo(0);
               make.left.mas_equalTo(CourierIcon.mas_right).offset(scale(10));
               make.right.mas_equalTo(rightIcon.mas_left).offset(scale(-7));
           }];
        
         [CourierLab mas_makeConstraints:^(MASConstraintMaker *make) {
                          make.bottom.mas_equalTo(routeLab.mas_top).offset(scale(-5));
                          make.left.mas_equalTo(CourierIcon.mas_right).offset(scale(10));
         }];
        
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(routeLab.mas_bottom).offset(scale(5));
        make.left.mas_equalTo(CourierIcon.mas_right).offset(scale(10));
                }];
        NSDictionary *model = _expresssources[0];
        routeLab.text = model[@"context"];
        timeLab.text = model[@"ftime"];
        if (buttonType == 0) {
  CourierLab.text = [NSString stringWithFormat:@"%@ %@",self.datas[@"express_company"],self.datas[@"express_no"]];
        }
        else
        {
 CourierLab.text = [NSString stringWithFormat:@"%@ %@",self.datas[@"sendback_express"][@"com_name"],self.datas[@"sendback_express"][@"nu"]];
        }

           self.contentY += scale(82);
        orderView.userInteractionEnabled = YES;

        
    }

        rightIcon.image = [UIImage imageNamed:@"next_ss"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kuaidi)];
        [orderView addGestureRecognizer:tap];
}
-(void)kuaidi
{
    ExpressDetailViewController *vc = [[ExpressDetailViewController alloc]init];

    if (buttonType == 0) {
        if (isNotNull(self.datas[@"send_express"])) {
              vc.ID = [NSString stringWithFormat:@"%@",self.datas[@"send_express"][@"id"]];
        }

    }
    else
    {
         if (isNotNull(self.datas[@"sendback_express"])) {

          vc.ID = [NSString stringWithFormat:@"%@",self.datas[@"sendback_express"][@"id"]];
         }
    }

    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)creatChangeBtnView
{
    if (changeView) {
        [changeView removeFromSuperview];
    }
    changeView = [[UIView alloc]init];
       [self.scrollView addSubview:changeView];
       changeView.backgroundColor = [UIColor whiteColor];
       changeView.frame = CGRectMake(0, self.contentY, SW, scale(42));
    
    UIButton *lastBtn =nil;
    [changeView addSubview:lastBtn];
    NSArray *arr = @[@"发货物流",@"寄回物流"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton new];
        [changeView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            if (lastBtn) {
                make.centerX.mas_equalTo(changeView.mas_centerX).offset(SW/4.0);
            }
            else
            {
                make.centerX.mas_equalTo(changeView.mas_centerX).offset(-SW/4.0);
            }
          
        }];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
        [button setTitleColor:ThemeRedColor forState:UIControlStateSelected];
        button.titleLabel.font = font(14);
        button.tag = 5000+i;
        lastBtn = button;
        
        UIView *line = [UIView new];
        [changeView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(button.mas_centerX).offset(0);
            make.top.mas_equalTo(button.mas_bottom).offset(scale(0));
            make.left.mas_equalTo(button.mas_left).offset(scale(-5));
            make.height.mas_equalTo(scale(2));
        }];
        line.tag = i+4000;
        line.backgroundColor = ThemeRedColor;
        if (i == buttonType) {
            line.hidden = NO;
            button.selected = YES;
        }
        else
        {
            line.hidden = YES;
        }
        [button addTarget:self action:@selector(changeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSInteger status = [self.datas[@"status"] intValue];
      if (status> 6) {
               self.contentY += scale(42);
      }
 
      
}
-(void)changeButton:(UIButton *)sender
{
   
    for (int i = 0; i<2; i++) {
        UIView *line = [self.view viewWithTag:4000+i];
        UIButton *button = [self.view viewWithTag:5000+i];
        button.selected = NO;
        line.hidden = YES;
    }
     sender.selected = YES;
    UIView *lines = [self.view viewWithTag:sender.tag-1000];
    lines.hidden = NO;
    self.contentY = 0;
    buttonType = sender.tag -5000;
    [self json];
    
}
-(void)creatAddressView
{
    if (addressView) {
        [addressView removeFromSuperview];
    }
    addressView = [[UIView alloc]init];
    addressView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:addressView];
    addressView.frame = CGRectMake(0, self.contentY, SW, scale(67));
    
    UIImageView *Icon = [UIImageView new];
    [addressView addSubview:Icon];
    [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addressView.mas_centerY).offset(0);
        make.left.mas_equalTo(scale(15));
        make.height.width.mas_equalTo(scale(22));
    }];
    Icon.image = [UIImage imageNamed:@"address_icons"];
    
    UILabel *address_text = [UILabel new];
    [addressView addSubview:address_text];
    [address_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addressView.mas_centerY).offset(scale(0));
        make.left.mas_equalTo(Icon.mas_right).offset(scale(10));
        make.right.mas_equalTo(addressView.mas_right).offset(scale(-15));
    }];
    address_text.numberOfLines = 0;
    address_text.font = font(12);
    address_text.textColor = COLOR_STR(0x333333);
   
    
    if (isNotNull(self.datas)) {
//        address_name.text = [NSString stringWithFormat:@"%@  %@",self.datas[@"realname"],self.datas[@"mobile"]];

        NSString *str =self.datas[@"address"];
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        address_text.text = [NSString stringWithFormat:@"%@ %@ \n%@%@%@%@",self.datas[@"realname"],self.datas[@"mobile"],self.datas[@"province"],self.datas[@"city"],self.datas[@"area"],str];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:address_text.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.0; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentJustified; //设置两端对齐显示
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
        
   
    address_text.attributedText = attributedStr;

        address_text.lineBreakMode = NSLineBreakByTruncatingTail;


        CGSize baseSize = CGSizeMake(SW-scale(62), CGFLOAT_MAX);
        CGSize labelsize = [address_text sizeThatFits:baseSize];
       addressView.frame = CGRectMake(0, self.contentY, SW, scale(16)+labelsize.height);
        self.contentY += scale(26)+labelsize.height;
    }
  

    
}
-(void)creatGoodsView
{
    if (goodView) {
        [goodView removeFromSuperview];
    }
    goodView= [[UIView alloc]init];
       [self.scrollView addSubview:goodView];
       goodView.backgroundColor = [UIColor whiteColor];
      goodView.frame = CGRectMake(0, self.contentY, SW, scale(98));
    
    UIImageView *goodIcon = [UIImageView new];
    [goodView addSubview:goodIcon];
    [goodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(goodView.mas_left).offset(scale(15));
        make.top.mas_equalTo(goodView.mas_top).offset(scale(10));
        make.width.mas_equalTo(goodIcon.mas_height);
    }];
    goodIcon.image = [UIImage imageNamed:@"goods_bg"];
    
    UILabel *goodsName = [UILabel new];
    [goodView addSubview:goodsName];
    [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(goodIcon.mas_top).offset(0);
        make.left.mas_equalTo(goodIcon.mas_right).offset(scale(10));
        make.right.mas_equalTo(goodView.mas_right).offset(scale(-15));
        
    }];
    goodsName.numberOfLines = 2;
    goodsName.font = font(13);
    goodsName.textColor = COLOR_STR(0x333333);
    goodsName.text = @"萨博黄金时代回家时剧场 v 说就是 v 纯净水 v还是 v 会出局";
       
       self.contentY += scale(108);
    if (isNotNull(self.datas)) {
        if (isNotNull(self.datas[@"good"][@"white_image"])) {
 [goodIcon sd_setImageWithURL:[NSURL URLWithString:self.datas[@"good"][@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
        }
        else
        {
        [goodIcon sd_setImageWithURL:[NSURL URLWithString:self.datas[@"good_pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
        }
        goodsName.text = self.datas[@"good_title"];
    }
}
-(void)creatOrderTimeView
{
    
    if (isNotNull(self.datas)) {
        NSInteger status = [self.datas[@"status"] intValue];
       
        NSMutableArray *arr = [NSMutableArray array];;
        if (isNotNull(self.datas[@"no"])) {
            [arr addObject:[NSString stringWithFormat:@"订单编号：%@",self.datas[@"no"]]];
        }
        if (isNotNull(self.datas[@"apply_time"])) {
            [arr addObject:[NSString stringWithFormat:@"申请时间：%@",self.datas[@"apply_time"]]];
        }
        if (isNotNull(self.datas[@"delivery_time"])) {
                   [arr addObject:[NSString stringWithFormat:@"发货时间：%@",self.datas[@"delivery_time"]]];
               }
        if (isNotNull(self.datas[@"arrival_time"])) {
                   [arr addObject:[NSString stringWithFormat:@"收货时间：%@",self.datas[@"arrival_time"]]];
               }
        if (isNotNull(self.datas[@"cancel_time"])) {
                          [arr addObject:[NSString stringWithFormat:@"取消时间：%@",self.datas[@"cancel_time"]]];
                      }
        if (isNotNull(self.datas[@"user_delivery_time"])) {
                                 [arr addObject:[NSString stringWithFormat:@"寄回时间：%@",self.datas[@"user_delivery_time"]]];
                             }
        if (isNotNull(self.datas[@"back_arrival_time"])) {
                                 [arr addObject:[NSString stringWithFormat:@"样品回收：%@",self.datas[@"back_arrival_time"]]];
                             }
        
        
        
        if (timeView) {
            [timeView removeFromSuperview];
        }
    timeView = [UIView new];
    [self.scrollView addSubview:timeView];
    timeView.backgroundColor = [UIColor whiteColor];
         timeView.frame = CGRectMake(0, self.contentY, SW, scale(24*arr.count)+scale(44));

        
    UILabel *tips = [UILabel new];
       [timeView addSubview:tips];
       [tips mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(0);
           make.left.mas_equalTo(scale(15));
           make.height.mas_equalTo(scale(34));
       }];
       tips.text = @"订单信息";
       tips.font = font1(@"PingFangSC-Medium", scale(14));
       tips.textColor = COLOR_STR(0x333333);
    UILabel *lastLab = nil;
    [timeView addSubview:lastLab];
       
    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [UILabel new];
        [timeView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(scale(15));
            make.right.mas_equalTo(scale(-15));
            make.height.mas_equalTo(scale(24));
            if (lastLab) {
                make.top.mas_equalTo(lastLab.mas_bottom).offset(0);
            }
            else
            {
                make.top.mas_equalTo(tips.mas_bottom).offset(0);
            }
            }];
        lastLab = label;
        label.textColor = COLOR_STR(0x999999);
        label.font = font(12);
        label.text = arr[i];
    }
    
    self.contentY += scale(24*arr.count)+scale(44);
    }
    
}
-(void)creatSendBackSheetView
{
 
    
    
}
- (void)updateScrollViewContentSize {
    
    if (self.contentY <= self.scrollView.frame.size.height) {
        
        self.contentY = self.scrollView.frame.size.height + 1;
    }
    
    self.scrollView.contentSize = CGSizeMake(SW, self.contentY);
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SW, self.view.frame.size.height-scale(46))];
        _scrollView.backgroundColor = viewColor;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.contentSize = CGSizeMake(SW, SH+ 1);
        _scrollView.userInteractionEnabled = YES;
//        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    return _scrollView;
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
