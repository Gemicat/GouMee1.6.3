//
//  GouMee_PIDViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/18.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_PIDViewController.h"
#import "GouMee_SelVideoViewController.h"
@interface GouMee_PIDViewController ()

@end

@implementation GouMee_PIDViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"淘宝客PID";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tips1 = [UILabel new];
    [self.view addSubview:tips1];
    [tips1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
    }];
    tips1.textColor = COLOR_STR(0x999999);
    tips1.font = font1(@"PingFangSC-Regular", scale(14));
    tips1.text = @"我的淘宝客PID";
    UILabel *PIDLab = [UILabel new];
    [self.view addSubview:PIDLab];
    [PIDLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tips1.mas_bottom).offset(10);
        make.left.mas_equalTo(tips1.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
    }];
    PIDLab.textColor = COLOR_STR(0x333333);
    PIDLab.font = font1(@"PingFangSC-Regular", scale(15));
    PIDLab.text = @"mm_125213253_46668810_109834000498";
    UIView *line1 = [UIView new];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PIDLab.mas_bottom).offset(10);
        make.left.mas_equalTo(PIDLab.mas_left).offset(0);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(0);
    }];
    line1.backgroundColor = COLOR_STR(0xDEDEDE);
    
    
//    UILabel *tips2 = [UILabel new];
//       [self.view addSubview:tips2];
//       [tips2 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.mas_equalTo(line1.mas_bottom).offset(10);
//           make.left.mas_equalTo(15);
//       }];
//       tips2.textColor = COLOR_STR(0x999999);
//       tips2.font = font1(@"PingFangSC-Regular", scale(14));
//       tips2.text = @"对应抖音号";
//       UILabel *DYLab = [UILabel new];
//       [self.view addSubview:DYLab];
//       [DYLab mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.mas_equalTo(tips2.mas_bottom).offset(10);
//           make.left.mas_equalTo(tips2.mas_left).offset(0);
//           make.centerX.mas_equalTo(0);
//       }];
//       DYLab.textColor = COLOR_STR(0x333333);
//       DYLab.font = font1(@"PingFangSC-Regular", scale(15));
//       DYLab.text = @"112334444";
//       UIView *line2 = [UIView new];
//       [self.view addSubview:line2];
//       [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.mas_equalTo(DYLab.mas_bottom).offset(10);
//           make.left.mas_equalTo(DYLab.mas_left).offset(0);
//           make.height.mas_equalTo(1);
//           make.centerX.mas_equalTo(0);
//       }];
//       line2.backgroundColor = COLOR_STR(0xDEDEDE);
//
//    UILabel *noticeLab = [UILabel new];
//    [self.view addSubview:noticeLab];
//    [noticeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(line2.mas_bottom).offset(5);
//        make.left.mas_equalTo(line2.mas_left).offset(0);
//    }];
//    noticeLab.numberOfLines = 0;
//    noticeLab.textColor = COLOR_STR(0x333333);
//          noticeLab.font = font1(@"PingFangSC-Regular", scale(12));
//          noticeLab.text = @"抖音登录对应账号并在商品橱窗中绑定该淘宝客\nPID，即可正确计算分佣";
    UIButton *copyBtn = [UIButton new];
    [self.view addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(scale(82));
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(73);
        make.height.mas_equalTo(38);
    }];
    [copyBtn setTitle:@"复制PID" forState:UIControlStateNormal];
    [copyBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    copyBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(12));
    [copyBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    copyBtn.layer.cornerRadius = 19;
    copyBtn.layer.masksToBounds = YES;
    [copyBtn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *askBtn = [UIButton new];
    [self.view addSubview:askBtn];
    [askBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(copyBtn.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
    }];
    askBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(12));
    [askBtn setTitleColor:COLOR_STR(0x576DFE) forState:UIControlStateNormal];
    [askBtn setTitle:@"如何在抖音绑定PID？" forState:UIControlStateNormal];
    [askBtn addTarget:self action:@selector(ask) forControlEvents:UIControlEventTouchUpInside];
    if (isNotNull(_userInfo[@"pid"])) {
        PIDLab.text = _userInfo[@"pid"];
    }
    else
    {
        PIDLab.text = @"未设置PID";
        PIDLab.textColor = COLOR_STR(0x999999);
        
    }
    
}
-(void)ask
{
    GouMee_SelVideoViewController *vc = [[GouMee_SelVideoViewController alloc]init];
    vc.urlString = @"https://kuran-s2b.oss-cn-hangzhou.aliyuncs.com/taobao-pid.mp4";
           [self.navigationController pushViewController:vc animated:YES];
}
-(void)copyClick
{
    if (isNotNull(_userInfo[@"pid"])) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
           pasteboard.string = _userInfo[@"pid"];
        [Network showMessage:@"淘宝PID已复制成功" duration:2.0];
    }
    else
    {
         [Network showMessage:@"未设置淘宝PID" duration:2.0];
    }
    
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
