//
//  SendSheetView.m
//  GouMee
//
//  Created by 白冰 on 2020/4/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "SendSheetView.h"
#import "UIExPickerView.h"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_/"
@interface SendSheetView ()<pickerDelegate,UITextFieldDelegate>
{
    NSString *expressnames;
    UIView *contextView;
}

@end

@implementation SendSheetView

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SW, SH);
               self.backgroundColor = COLOR_STR1(0, 0, 0, 0.5);
        [self creaView];
        
    }
    return self;
}
-(void)creaView
{
    
    _backView = [UIView new];
    [self addSubview:_backView];
    _backView.layer.cornerRadius = 8;
    _backView.layer.masksToBounds = YES;
    _backView.backgroundColor = [UIColor whiteColor];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-20);
        make.left.mas_equalTo(scale(55));

    }];
    self.titleLab = [UILabel new];
          [_backView addSubview:self.titleLab];
          [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(_backView.mas_top).offset(scale(0));
              make.centerX.mas_equalTo(0);
              make.height.mas_equalTo(scale(44));
          }];
          self.titleLab.textColor = COLOR_STR(0x333333);
          self.titleLab.font = font1(@"PingFangSC-Medium", scale(16));
          self.titleLab.text = @"寄回样品";
       
       _closeBtn = [UIButton new];
          [_backView addSubview:_closeBtn];
          [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.mas_equalTo(self.titleLab.mas_centerY).offset(0);
              make.right.mas_equalTo(-12);
              make.height.width.mas_equalTo(30);
          }];
          [_closeBtn setImage:[UIImage imageNamed:@"sheet_close"] forState:UIControlStateNormal];
          [_closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
          
    UILabel *tips = [UILabel new];
    [_backView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(scale(0));
        make.left.mas_equalTo(scale(15));
    }];
    tips.textColor = COLOR_STR(0x333333);
    tips.text = @"样品寄回地址";
    tips.font = font1(@"PingFangSC-Medium", scale(14));
    
    
    contextView = [UIView new];
    [_backView addSubview:contextView];
    [contextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tips.mas_bottom).offset(scale(8));
        make.left.mas_equalTo(tips.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
    }];
    contextView.backgroundColor = COLOR_STR(0xf9f9f9);
    contextView.layer.cornerRadius = 6;
    contextView.layer.masksToBounds = YES;
    
    self.contextLab = [UILabel new];
    [contextView addSubview:self.contextLab];
    [self.contextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(scale(10));
        make.top.mas_equalTo(scale(5));
    }];

    self.contextLab.numberOfLines = 0;
    self.contextLab.textColor = COLOR_STR(0x333333);
    self.contextLab.font = font(12);
    self.contextLab.text = @"张三  13689345609    \n浙江省杭州市西湖区江干区九堡330号致应中心5楼502";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.contextLab.text];;
           NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
           [paragraphStyle setLineSpacing:5];
           [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.contextLab.text.length)];
           self.contextLab.attributedText = attributedString;
     self.contextLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    UILabel *tipss = [UILabel new];
       [_backView addSubview:tipss];
       [tipss mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(contextView.mas_bottom).offset(scale(15));
           make.left.mas_equalTo(scale(15));
       }];
       tipss.textColor = COLOR_STR(0x333333);
       tipss.text = @"寄回物流信息";
       tipss.font = font1(@"PingFangSC-Medium", scale(14));
    
    
    UIButton *rightBtn = [UIButton new];
    [_backView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipss.mas_bottom).offset(scale(20));
        make.right.mas_equalTo(_backView.mas_right).offset(scale(-15));
        make.height.width.mas_equalTo(scale(17));
    }];
    [rightBtn setImage:[UIImage imageNamed:@"address_down"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(chooseCompany) forControlEvents:UIControlEventTouchUpInside];
    UILabel *tipa = [UILabel new];
    [_backView addSubview:tipa];


    [tipa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipss.mas_bottom).offset(scale(20));
        make.left.mas_equalTo(tipss.mas_left).offset(0);
        make.height.mas_equalTo(rightBtn.mas_height);
    }];
    tipa.textColor = COLOR_STR(0x999999);
    tipa.text = @"物流公司";
    tipa.font = font(12);

    self.expressName = [UILabel new];
    [_backView addSubview:self.expressName];
    [self.expressName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipss.mas_bottom).offset(scale(20));
        make.right.mas_equalTo(rightBtn.mas_left).offset(0);
        make.left.mas_equalTo(tipa.mas_right).offset(scale(10));
        make.height.mas_equalTo(rightBtn.mas_height);
    }];

    self.expressName.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCompany)];
    [self.expressName addGestureRecognizer:tapp];

    self.expressName.textColor = COLOR_STR(0x333333);
    self.expressName.text = @"";
    self.expressName.font = font(12);
    
    UIView *line1 = [UIView new];
    [_backView addSubview:line1];
    line1.backgroundColor = viewColor;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.expressName.mas_bottom).offset(scale(11));
        make.left.mas_equalTo(tipss.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    

    UILabel *tipb = [UILabel new];
    [_backView addSubview:tipb];


    [tipb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(scale(11));

        make.left.mas_equalTo(tipss.mas_left).offset(0);

        make.height.mas_equalTo(rightBtn.mas_height);
    }];
   tipb.textColor = COLOR_STR(0x999999);
    tipb.font = font(12);
     tipb.text = @"物流单号";

    self.expressNo = [UITextField new];
    self.expressNo.delegate = self;
    self.expressNo.textAlignment = NSTextAlignmentLeft;
       [_backView addSubview:self.expressNo];
       [self.expressNo mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(tipb.mas_centerY).offset(0);
           make.left.mas_equalTo(tipb.mas_right).offset(scale(10));
           make.height.mas_equalTo(scale(34));
           make.right.mas_equalTo(rightBtn.mas_right).offset(0);
       }];
    self.expressNo.backgroundColor = [UIColor whiteColor];
       self.expressNo.textColor = COLOR_STR(0x333333);
    self.expressNo.placeholder= @"                     ";
       self.expressNo.font = font(12);
       self.expressNo.keyboardType = UIKeyboardTypeASCIICapable;
       UIView *line2 = [UIView new];
       [_backView addSubview:line2];
       line2.backgroundColor = viewColor;
       [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(tipb.mas_bottom).offset(scale(11));
           make.left.mas_equalTo(tipss.mas_left).offset(0);
           make.centerX.mas_equalTo(0);
           make.height.mas_equalTo(1);
       }];
    
    UIButton *certainBtn = [UIButton new];
    [_backView addSubview:certainBtn];
    [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(scale(15));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(33));
        make.width.mas_equalTo(scale(90));
    }];
    certainBtn.layer.cornerRadius = scale(33)/2.0;
    certainBtn.layer.masksToBounds = YES;
    certainBtn.backgroundColor = ThemeRedColor;
    [certainBtn setTitle:@"提交" forState:UIControlStateNormal];
    [certainBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    certainBtn.titleLabel.font = font(14);
    [certainBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    
    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(certainBtn.mas_bottom).offset(scale(15));
    }];
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {

            make.centerY.mas_equalTo(-100);
    }];
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{

    [_backView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(-20);
    }];
    return YES;
}
-(void)setExzz:(NSString *)exzz
{
    expressnames = exzz;
}
-(void)sure
{

    if (self.click) {
        if (expressnames.length == 0) {
            [Network showMessage:@"请选择物流公司" duration:2.0];
            return;
        }
        if (self.expressNo.text.length == 0) {
            [Network showMessage:@"请填写物流单号" duration:2.0];
            return;
        }
        self.click(expressnames, self.expressNo.text);
        [self disMissView];
    }

}
-(void)chooseCompany
{

NSArray *arr = @[
                 @{@"text": @"韵达快递", @"value": @"yunda"},
                 @{@"text": @"中通快递", @"value": @"zhongtong"},
                 @{@"text": @"圆通速递",  @"value": @"yuantong"},
                 @{@"text": @"申通快递",  @"value": @"shentong"},
                 @{@"text": @"顺丰速运",  @"value": @"shunfeng"},
                 @{@"text": @"EMS",  @"value": @"ems"},
                 @{@"text": @"天天快递",  @"value": @"tiantian"}
    ];


    UIExPickerView *views = [[UIExPickerView alloc]initWithFrame:CGRectMake(0,0, SW, SH) arr:arr];
    views.delegate = self;
    [self addSubview:views];


}
-(void)selectIndex:(NSInteger)index
{
    NSArray *arr = @[
                     @{@"text": @"韵达快递", @"value": @"yunda"},
                     @{@"text": @"中通快递", @"value": @"zhongtong"},
                     @{@"text": @"圆通速递",  @"value": @"yuantong"},
                     @{@"text": @"申通快递",  @"value": @"shentong"},
                     @{@"text": @"顺丰速运",  @"value": @"shunfeng"},
                     @{@"text": @"EMS",  @"value": @"ems"},
                     @{@"text": @"天天快递",  @"value": @"tiantian"}
                     ];

    self.expressName.text = arr[index][@"text"];
    expressnames = arr[index][@"value"];

}
- (void)disMissView {
    
  
                         
                         [self removeFromSuperview];
                         [_backView removeFromSuperview];

    
}
@end
