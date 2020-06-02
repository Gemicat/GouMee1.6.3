//
//  GouMee_BalanceViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/1/6.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_BalanceViewController.h"
#import "GouMee_WithdrawalViewController.h"
#import "GouMee_BalanceRecordViewController.h"
#import "GouMee_LoginViewController.h"
#import "GouMee_AuthenticationViewController.h"
#import "GouMee_CertificationStatusViewController.h"
@interface GouMee_BalanceViewController ()
{
    
    UILabel *balanceNum;
    NSDictionary *userInfo;
}

@end

@implementation GouMee_BalanceViewController

-(void)viewWillAppear:(BOOL)animated
{
    
     NSDictionary *loginModel = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    
    [Network GET:[NSString stringWithFormat:@"api/v1/users/%@/",loginModel[@"id"]] paramenters:nil success:^(id data) {
                              if ([data[@"success"] intValue] == 1) {
                                  userInfo = [NSDictionary dictionaryWithDictionary:data[@"data"]];
                                  balanceNum.text = [NSString stringWithFormat:@"%@",userInfo[@"can_use_money"]];
                                                          }
                      else
                      {
                          if ([data[@"error_code"] intValue] == 3001 || [data[@"error_code"] intValue] == 3300) {
                              [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"isLogin"];
                              [[NSUserDefaults standardUserDefaults]synchronize];
                              [Network showMessage:data[@"message"] duration:2.0];
                              GouMee_LoginViewController *vc = [[GouMee_LoginViewController alloc]init];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"余额";
    self.view.backgroundColor = viewColor;
    UIView *topView = [UIView new];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(scale(108));
    }];
    [topView setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xD72E51)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    UILabel *topLab = [UILabel new];
    [topView addSubview:topLab];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(23));
        make.centerX.mas_equalTo(0);
    }];
    topLab.text = @"可用余额（元）";
    topLab.textColor = COLOR_STR1(255, 255, 255, 1.0);
    topLab.font = font1(@"PingFangSC-Regular",scale(12));
    
    balanceNum = [UILabel new];
    [topView addSubview:balanceNum];
    [balanceNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(topLab.mas_bottom).offset(0);
        make.bottom.mas_equalTo(topView.mas_bottom).offset(-scale(10));
        
    }];
       balanceNum.textColor = [UIColor whiteColor];
       balanceNum.font = font1(@"PingFangSC-Medium",scale(30));
    
    UIView *lastView = nil;
    [self.view addSubview:lastView];
    for (int i = 0; i < 2; i++) {
        UIView *views = [UIView new];
        [self.view addSubview:views];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(scale(44));
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(0);
            }
            else
            {
                make.top.mas_equalTo(topView.mas_bottom).offset(0);
            }
        }];
        views.backgroundColor = [UIColor whiteColor];
        
        UIImageView *leftIcon = [UIImageView new];
               [views addSubview:leftIcon];
        [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.height.width.mas_equalTo(20);
            
        }];
        leftIcon.backgroundColor = [UIColor whiteColor];
        UILabel *markLab = [UILabel new];
        [views addSubview:markLab];
        [markLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(leftIcon.mas_right).offset(10);
        }];
        markLab.textColor = COLOR_STR(0x333333);
        markLab.font = font1(@"PingFangSC-Regular", scale(12));
        
        UIImageView *rightIcon = [UIImageView new];
                      [views addSubview:rightIcon];
               [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.centerY.mas_equalTo(0);
                   make.right.mas_equalTo(-15);
                   make.height.width.mas_equalTo(20);
                   
               }];
        rightIcon.image = [UIImage imageNamed:@"next_icon"];
        
        
        lastView = views;
        if (i == 0) {
            UIView *line = [UIView new];
            [self.view addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(lastView.mas_bottom).offset(-0.5);
                make.height.mas_equalTo(1);
                make.right.mas_equalTo(0);
                make.left.mas_equalTo(self.view.mas_left).offset(scale(44));
            }];
            line.backgroundColor = COLOR_STR(0xf2f2f2);
             markLab.text = @"提现";
            leftIcon.image = [UIImage imageNamed:@"tixian_icon"];
            UITapGestureRecognizer *tip = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1)];
            [views addGestureRecognizer:tip];
        }
        else
        {
          markLab.text = @"余额明细";
            leftIcon.image = [UIImage imageNamed:@"mingxi_icon"];
            UITapGestureRecognizer *tips = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2)];
                       [views addGestureRecognizer:tips];
        }
       
        
        
    }

    


}
-(void)tap1
{
    
    NSInteger status = [userInfo[@"identity_status"] intValue];
    if (status == 0) {
        GouMee_AuthenticationViewController *vc = [[GouMee_AuthenticationViewController alloc]init];
           [self.navigationController pushViewController:vc animated:YES];
    }
    if (status == 1) {
        GouMee_CertificationStatusViewController  *vc = [[GouMee_CertificationStatusViewController alloc]init];
        vc.model = userInfo;
                  [self.navigationController pushViewController:vc animated:YES];
    }
    if (status == 2) {
       GouMee_CertificationStatusViewController  *vc = [[GouMee_CertificationStatusViewController alloc]init];
        vc.model = userInfo;
       [self.navigationController pushViewController:vc animated:YES];
    }
    if ( status == 3) {
        GouMee_WithdrawalViewController *vc = [[GouMee_WithdrawalViewController alloc]init];
        vc.model = userInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
}
-(void)tap2
{
    GouMee_BalanceRecordViewController *vc = [[GouMee_BalanceRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
