//
//  GouMee_WithdrawalViewController.m
//  GouMee
//
//  Created by 白冰 on 2020/1/6.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GouMee_WithdrawalViewController.h"
#import "GouMee_WithdrawalRecordViewController.h"
#import <UIButton+WebCache.h>
@interface GouMee_WithdrawalViewController ()<UITextFieldDelegate>
{
    UITextField *moneyText;
    UILabel *tips;
    UIButton  *allBtn;
    UIButton *sureBtn;
}

@end

@implementation GouMee_WithdrawalViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现";
    self.view.backgroundColor = viewColor;
    
    UIView *topView = [UIView new];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(124))
        ;
        
    }];
   
    
    UILabel *tips1 = [UILabel new];
    [topView addSubview:tips1];
    [tips1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).mas_equalTo(scale(16));
        make.left.mas_equalTo(scale(15));
        
    }];
    tips1.text = @"提现金额（元）";
    tips1.textColor = COLOR_STR(0x333333);
    tips1.font = font1(@"PingFangSC-Regular", scale(12));
    
    
    UIView *line = [UIView new];
    [topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(topView.mas_bottom).offset(-scale(38));
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = viewColor;
    
    
    
    UILabel *moneyMark = [UILabel new];
    [topView addSubview:moneyMark];
    [moneyMark mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(line.mas_left).offset(0);
       make.bottom.mas_equalTo(line.mas_top).offset(-8);
        make.width.mas_equalTo(24);
    }];
    moneyMark.text = @"￥";
     moneyMark.font = font1(@"PingFangSC-Regular", scale(19));
    
    moneyText = [UITextField new];
    moneyText.delegate = self;
    moneyText.keyboardType = UIKeyboardTypeDecimalPad;
    [topView addSubview:moneyText];
    [moneyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(moneyMark.mas_right).offset(6);
        make.bottom.mas_equalTo(moneyMark.mas_bottom).offset(0);
        make.right.mas_equalTo(topView.mas_right).offset(0);
        make.height.mas_equalTo(30);
    }];
      [moneyText addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    moneyText.placeholder = @"          ";
    moneyText.font = font1(@"PingFangSC-Regular", scale(19));
    
    
    tips = [UILabel new];
    [topView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(8);
        make.left.mas_equalTo(line.mas_left).offset(0);
    }];
    tips.text = [NSString stringWithFormat:@"余额￥%@",self.model[@"can_use_money"]];
    tips.font = font1(@"PingFangSC-Regular", scale(12));
    tips.textColor = COLOR_STR(0x999999);
    
    allBtn = [UIButton new];
       [topView addSubview:allBtn];
       [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(tips.mas_right).offset(4);
           make.centerY.mas_equalTo(tips.mas_centerY).offset(0);
       }];
       [allBtn setTitle:@"全部提现" forState:UIControlStateNormal];
       [allBtn setTitleColor:COLOR_STR(0x6269F8) forState:UIControlStateNormal];
       allBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(12));
    
    [allBtn addTarget:self action:@selector(all) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(44));
        
    }];
    UILabel *tipss = [UILabel new];
    [bottomView addSubview:tipss];
    [tipss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(tips.mas_left).offset(0);
    }];
    tipss.text = @"收款账户";
    tipss.textColor = COLOR_STR(0x333333);
    tipss.font = font1(@"PingFangSC-Regular", scale(12));
    
    UIButton *bankLog = [UIButton new];
    [bottomView addSubview:bankLog];
    [bankLog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tipss.mas_centerY).offset(0);
        make.right.mas_equalTo(bottomView.mas_right).offset(-20);
        make.top.mas_equalTo(bottomView.mas_top).offset(20);
    }];
   [bankLog setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
    bankLog.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bankLog sd_setImageWithURL:[NSURL URLWithString:self.model[@"bank_logo"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    NSString *bankNo = self.model[@"bank_card_num"];
    if (isNotNull(bankNo)) {
         [bankLog setTitle:[NSString stringWithFormat:@"%@（%@）",self.model[@"bank"],[bankNo substringFromIndex:bankNo.length-4]] forState:UIControlStateNormal];
    }
   
    [bankLog setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    bankLog.titleLabel.font = font(12);
    
    sureBtn = [UIButton new];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_bottom).offset(scale(90));
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(scale(44));
    }];
    sureBtn.alpha = 0.5;
    sureBtn.userInteractionEnabled = NO;
    [sureBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(15));
    [sureBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    sureBtn.layer.cornerRadius = scale(22);
    sureBtn.layer.masksToBounds = YES;
    [sureBtn addTarget:self action:@selector(xxxxx) forControlEvents:UIControlEventTouchUpInside];
    UIButton *recordBtn = [UIButton new];
    [self.view addSubview:recordBtn];
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sureBtn.mas_bottom).offset(scale(20));
        make.centerX.mas_equalTo(0);
    }];
    [recordBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    [recordBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
    recordBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(15));
    [recordBtn addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)all
{
 moneyText.text =[NSString stringWithFormat:@"%@",self.model[@"can_use_money"]];
    sureBtn.alpha = 1.0;
}
-(void)recordAction
{
    GouMee_WithdrawalRecordViewController *vc = [[GouMee_WithdrawalRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)textFieldDidChanged:(UITextField *)textField {
    
    
    if ([textField.text isEqualToString: @"."]) {
           textField.text = @"";
       }
       
       //判断是否有两个小数点
       if (textField.text.length >= 2) {
           NSString *str = [textField.text substringToIndex:textField.text.length-1];
           NSString *strTwo = [textField.text substringFromIndex:textField.text.length-1];
           NSRange range = [str rangeOfString:@"."];
           if (range.location != NSNotFound && [strTwo isEqualToString:@"."]) {
               textField.text = [textField.text substringToIndex:textField.text.length-1];
           }
           
       }
       //小数点后面数字位数控制  （此时为小数点后一位，3改4就是两位    思路：取倒数第X个字符是否为小数点，是小数点的话，就不再允许输入）
       if (textField.text.length > 4) {
           NSString *myStr = [textField.text substringWithRange:NSMakeRange(textField.text.length-4 , 1)];
           if ([myStr isEqualToString:@"."]) {
               textField.text = [textField.text substringToIndex:textField.text.length-1];
           }
       }
    if (textField.text.length > 0 && [textField.text intValue]>0) {
        sureBtn.alpha = 1.0;
        sureBtn.userInteractionEnabled = YES;
    }
    else
    {
        sureBtn.userInteractionEnabled = NO;
        sureBtn.alpha = 0.5;
    }
   

       //最大值控制
       double doubleNum = [textField.text doubleValue]*100;
  
     
       double sum = [self.model[@"can_use_money"] doubleValue]*100;
       if (doubleNum > sum) {
         tips.text = @"超出可提现余额";
           tips.textColor = COLOR_STR(0xED632C);
           allBtn.hidden = YES;
       }
    else
    {
       tips.text = [NSString stringWithFormat:@"余额￥%@",self.model[@"can_use_money"]];
         tips.textColor = COLOR_STR(0x999999);
        allBtn.hidden = NO;
        
    }
    
    
}
-(void)xxxxx
{
    if (moneyText.text.length == 0) {
        [Network showMessage:@"请输入要提现的金额" duration:2.0];
        return;
    }
    [Network POST:@"api/v1/money-records/" paramenters:@{@"money":moneyText.text} success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            [self successView];
        }
        else
        {
            [Network showMessage:data[@"message"] duration:2.0];
        }
       } error:^(id data) {
           
       }];
}
-(void)successView
{

    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
     
    
    UIImageView *successIcon = [UIImageView new];
    [backView addSubview:successIcon];
    [successIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(60));
        make.centerX.mas_equalTo(0);
        make.height.width.mas_equalTo(scale(90));
        
    }];
    successIcon.image = [UIImage imageNamed:@"auth_success"];
    UILabel *moneyNum = [UILabel new];
    [backView addSubview:moneyNum];
    [moneyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(successIcon.mas_bottom).offset(scale(30));
        make.centerX.mas_equalTo(0);
    }];
    moneyNum.textColor = COLOR_STR(0x333333);
    moneyNum.text = [NSString stringWithFormat:@"提现金额：%@元",moneyText.text];
    moneyNum.font = font1(@"PingFangSC-Regular", scale(15));
    
    UILabel *bankNo = [UILabel new];
       [backView addSubview:bankNo];
       [bankNo mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(moneyNum.mas_bottom).offset(scale(15));
           make.centerX.mas_equalTo(0);
       }];
    bankNo.textColor = COLOR_STR(0x333333);
    NSString *bankstr = self.model[@"bank_card_num"];
       
     bankNo.text = [NSString stringWithFormat:@"收款账户：%@（%@）",self.model[@"bank"],[bankstr substringFromIndex:bankstr.length-4]];
       bankNo.font = font1(@"PingFangSC-Regular", scale(15));
    
    UILabel *tips = [UILabel new];
          [backView addSubview:tips];
          [tips mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(bankNo.mas_bottom).offset(scale(30));
              make.centerX.mas_equalTo(0);
          }];
    tips.textColor = COLOR_STR(0x999999);
          tips.text = @"我们会在1-3个工作日内处理您的提现申请";
          tips.font = font1(@"PingFangSC-Regular", scale(15));
    
    UIButton *certainBtn = [UIButton new];
    [backView addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tips.mas_bottom).offset(scale(25));
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(scale(44));
        make.centerX.mas_equalTo(0);
        
    }];
    [certainBtn setTitle:@"完成" forState:UIControlStateNormal];
    [certainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    certainBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(15));
    [certainBtn setGradientBackgroundWithColors:@[COLOR_STR(0x50C76A),COLOR_STR(0x3EB954)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    certainBtn.layer.cornerRadius = scale(22);
    certainBtn.layer.masksToBounds = YES;
    [certainBtn addTarget:self action:@selector(zzzz) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)zzzz
{
    [self.navigationController popViewControllerAnimated:YES];
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
