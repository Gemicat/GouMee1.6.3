//
//  GouMee_RegisterViewController.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GouMee_RegisterViewController.h"
#import "UIView+Gradient.h"

@interface GouMee_RegisterViewController ()<UITextFieldDelegate>
{
    UIView *sheetView;
    UITextField *phoneField;
    UITextField *DYField;
    UIButton *sureBtn;
    UITextField *TBField;
    NSInteger type;
    NSString *dou_phone;
    NSString *dou_ID;
    NSString *tao_phone;
    NSString *tao_name;
    NSString *tao_ID;
    
}

@end

@implementation GouMee_RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"";
    type = 1;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:scale(18)],
           NSForegroundColorAttributeName: COLOR_STR(0x333333)}];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *topLab = [UIImageView new];
    [self.view addSubview:topLab];
    topLab.image = [UIImage imageNamed:@"reg_title"];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(49));
        make.left.mas_equalTo(scale(38));
    }];
        
    UIButton *typeBtn = [UIButton new];
    [self.view addSubview:typeBtn];
    [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLab.mas_bottom).offset(scale(32));
       make.left.mas_equalTo(scale(38));
        make.centerX.mas_equalTo(0);
    }];
    typeBtn.selected = NO;
    typeBtn.adjustsImageWhenHighlighted = NO;
    typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    typeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [typeBtn setImage:[UIImage imageNamed:@"type_n"] forState:UIControlStateNormal];
    [typeBtn setImage:[UIImage imageNamed:@"type_s"] forState:UIControlStateSelected];
    [typeBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    

    UIView *lastLine =nil;
    [self.view addSubview:lastLine];
    for (int i = 0; i < 3; i++) {
        UIView *line = [UIView new];
        line.backgroundColor = COLOR_STR(0xffffff);
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(topLab.mas_left).offset(0);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(1);
            if (lastLine) {
                make.top.mas_equalTo(lastLine.mas_bottom).offset(scale(50));
            }
            else
            {
                make.top.mas_equalTo(typeBtn.mas_bottom).offset(scale(60));
            }
        }];
        lastLine = line;
        UITextField *field = [UITextField new];
        field.font = font1(@"PingFangSC-Medium", scale(14));
        [self.view addSubview:field];
        field.delegate = self;
         AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *placeStr = @"";
        if (i == 0) {
                   placeStr = @"请填写手机号(必填)";
            phoneField = field;
            phoneField.keyboardType = UIKeyboardTypeNumberPad;
               }
               else if(i == 1)
               {
                   if (appDelegate.auditStatus == 0) {
                        placeStr = @"请填写抖音号(必填)";
                   }
                   else
                   {
                       placeStr = @"请填写密码";
                   }
                  
                   DYField = field;
                   DYField.keyboardType =UIKeyboardTypeASCIICapable;
               }
        else
        {
            if (appDelegate.auditStatus == 0) {
                                   placeStr = @"请填写淘宝userID(必填)";
                              }
                              else
                              {
                                  placeStr = @"请填写您的出生日期(必填)";
                              }
           
            TBField = field;
            TBField.hidden = YES;
            DYField.keyboardType =UIKeyboardTypeASCIICapable;
        }
//        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:placeStr attributes:@{NSForegroundColorAttributeName : COLOR_STR(0x999999),NSFontAttributeName : font(14)}];
        field.placeholder = placeStr;
        [field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(line.mas_top).offset(0);
            make.left.mas_equalTo(line.mas_left).offset(10);
            make.height.mas_equalTo(40);
            make.centerX.mas_equalTo(0);
        }];

        UIView *line1 = [UIView new];
        [field addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(field.mas_bottom).offset(0);
            make.left.mas_equalTo(field.mas_left).offset(0);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        line1.backgroundColor = COLOR_STR(0xf8f8f8);
    }

    
    sureBtn = [UIButton new];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastLine.mas_bottom).offset(scale(45));
        make.left.mas_equalTo(lastLine.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    sureBtn.layer.cornerRadius = 22.5;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitle:@"提交申请" forState:UIControlStateNormal];

    sureBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:scale(14)];
    [self isSureChange];
    [sureBtn addTarget:self action:@selector(requstLoginUrl) forControlEvents:UIControlEventTouchUpInside];
      [phoneField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
      [DYField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
     [TBField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}
-(void)choose:(UIButton *)sender
{
    [TBField resignFirstResponder];
    [DYField resignFirstResponder];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (sender.selected == NO) {
        if (appDelegate.auditStatus == 0) {
                               DYField.placeholder = @"请填写主播昵称(必填)";
                          }
                          else
                          {
                              DYField.placeholder = @"请填写密码";
                          }
       
        TBField.hidden = NO;
        TBField.keyboardType =UIKeyboardTypeASCIICapable;
        DYField.keyboardType = UIKeyboardTypeDefault;
        dou_phone = phoneField.text;
        dou_ID = DYField.text;
        TBField.text = tao_ID;
        DYField.text = tao_name;
        phoneField.text = tao_phone;
        type = 2;
    }
    else
    {
        if (appDelegate.auditStatus == 0) {
                                     DYField.placeholder = @"请填写抖音号(必填)";
                                 }
                                 else
                                 {
                                     DYField.placeholder = @"请填写密码";
                                 }
       
         DYField.keyboardType =UIKeyboardTypeASCIICapable;
        TBField.hidden = YES;
        tao_ID= TBField.text;
        tao_name = DYField.text;
        tao_phone = phoneField.text;
        phoneField.text = dou_phone;
        DYField.text = dou_ID;
        type = 1;
    }
    
    sender.selected = !sender.selected;
    [self isSureChange];
    
}
- (void)textFieldDidChanged:(UITextField *)textField {
 // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
 UITextRange *selectedRange = textField.markedTextRange;
 UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
 if (position) {
 return;
 }
 // 判断是否超过最大字数限制，如果超过就截断
    if (textField == phoneField) {

        if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
        }
    }
    [self isSureChange];
 // 剩余字数显示 UI 更新
}
-(void)isSureChange
{
    if (type == 2) {
        if (phoneField.text.length == 11 && DYField.text.length > 0 && TBField.text.length > 0) {
            [sureBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
            [sureBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        }
        else
        {
            [sureBtn setTitleColor:COLOR_STR(0x9B9B9B) forState:UIControlStateNormal];
            [sureBtn setGradientBackgroundWithColors:@[COLOR_STR(0xEBEBEB),COLOR_STR(0xEBEBEB)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        }
    }
    else
    {
    if (phoneField.text.length == 11 && DYField.text.length > 0) {
        [sureBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
        [sureBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    }
    else
    {
        [sureBtn setTitleColor:COLOR_STR(0x9B9B9B) forState:UIControlStateNormal];
        [sureBtn setGradientBackgroundWithColors:@[COLOR_STR(0xEBEBEB),COLOR_STR(0xEBEBEB)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    }
    }

}
-(void)requstLoginUrl
{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (phoneField.text.length == 0) {
           [Network showMessage:@"请输入手机号" duration:2.0];
           return;
       }
       if (![Network checkTelephoneNumber:phoneField.text]) {
           [Network showMessage:@"手机号格式不正确，请重新输入" duration:2.0];
           return;
       }
    if (type == 2) {
        if (DYField.text.length == 0) {
            if (appDelegate.auditStatus == 0) {
                 [Network showMessage:@"请填写主播昵称" duration:2.0];
            }
            else
            {
              [Network showMessage:@"请填写密码" duration:2.0];
            }
               
                      return;
           }
        if (TBField.text.length == 0) {
            if (appDelegate.auditStatus == 0) {
                           [Network showMessage:@"请填写淘宝userID" duration:2.0];
                      }
                      else
                      {
                        [Network showMessage:@"请填写出生日期" duration:2.0];
                      }
                      
                            return;
                 }
    }
    else
    {
    if (DYField.text.length == 0) {
        if (appDelegate.auditStatus == 0) {
                      [Network showMessage:@"请输入抖音号" duration:2.0];
                  }
                  else
                  {
                    [Network showMessage:@"请填写密码" duration:2.0];
                  }
        
               return;
    }
    }
    NSMutableDictionary *parm = [NSMutableDictionary dictionary];
    [parm setValue:phoneField.text forKey:@"mobile"];
    if (type == 2) {
         [parm setObject:DYField.text forKey:@"anchor_name"];
         [parm setObject:TBField.text forKey:@"taobao_user_id"];
         [parm setObject:@(2) forKey:@"channel"];
    }
    else
    {
    [parm setObject:DYField.text forKey:@"douyin_account"];
         [parm setObject:@(1) forKey:@"channel"];
    }
   
    [Network POST:@"api/v1/audits/" paramenters:parm success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            [self creatSheetView];
        }
        else
        {
            [Network showMessage:data[@"message"] duration:2.0];
        }
    } error:^(id data) {
        
    }];
}
-(void)creatSheetView
{
    sheetView = [UIView new];
    [[UIApplication sharedApplication].delegate.window addSubview:sheetView];
    [sheetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    sheetView.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
    UIView *backView = [UIView new];
    [sheetView addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneField.mas_top).offset(-20);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(scale(233));
        make.height.mas_equalTo(scale(192));
    }];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
     
    UIImageView *topIcon = [UIImageView new];
    [sheetView addSubview:topIcon];
    [topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView.mas_top).offset(0);
        make.centerX.mas_equalTo(backView.mas_centerX).offset(0);
        make.height.width.mas_equalTo(scale(82));
    }];
    topIcon.image = [UIImage imageNamed:@"success_top"];
    
    UIImageView *successLab = [UIImageView new];
    [backView addSubview:successLab];
    [successLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(55));
        make.centerX.mas_equalTo(0);
        
    }];
    successLab.image = [UIImage imageNamed:@"success_icon"];
    UILabel *label = [UILabel new];
    [backView addSubview:label];
    label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:scale(12)];
    label.textColor = COLOR_STR(0x333333);
    label.text = @"我们会尽快为您审核";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(successLab.mas_bottom).offset(scale(17));
        make.centerX.mas_equalTo(0);
    }];
    
    UIButton *closeBtn = [UIButton new];
    [backView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(scale(-22));
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(scale(30));
        make.height.mas_equalTo(scale(27));
    }];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    closeBtn.titleLabel.font =[UIFont fontWithName:@"PingFangSC-Semibold" size:scale(12)];
    closeBtn.layer.cornerRadius = scale(27)/2.0;
    closeBtn.layer.masksToBounds = YES;
    closeBtn.backgroundColor = COLOR_STR(0xD72E51);
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)close
{
    [sheetView removeFromSuperview];
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
