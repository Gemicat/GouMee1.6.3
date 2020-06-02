//
//  FreeGoodView.m
//  GouMee
//
//  Created by 白冰 on 2020/3/13.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "FreeGoodView.h"
#import "DatePickerAlertView.h"
@implementation FreeGoodView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SW, SH);
               self.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
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
        make.centerY.mas_equalTo(self.mas_centerY).offset(scaleH(-20));
          make.height.mas_equalTo(scale(250));
               make.left.mas_equalTo(scale(50));
               make.centerX.mas_equalTo(0);
    }];
    
    UIButton *closeBtn = [UIButton new];
           [_backView addSubview:closeBtn];
           [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(8);
               make.right.mas_equalTo(-3);
               make.height.width.mas_equalTo(30);
           }];
           [closeBtn setImage:[UIImage imageNamed:@"sheet_close"] forState:UIControlStateNormal];
           [closeBtn addTarget:self action:@selector(closeclick) forControlEvents:UIControlEventTouchUpInside];

    _tip = [UILabel new];
    [_backView addSubview:_tip];
    [_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_top).offset(scale(16));
        make.centerX.mas_equalTo(0);
    }];
    _tip.textColor = COLOR_STR(0x333333);
    _tip.font = font1(@"PingFangSC-Semibold", scale(16));
    _tip.text = @"申请寄样";
    
   UILabel *_tips = [UILabel new];
    [_backView addSubview:_tips];
    [_tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tip.mas_bottom).offset(scale(30));
        make.left.mas_equalTo(_backView.mas_left).offset(scale(20));
        make.width.mas_equalTo(scale(65));
        
    }];
    _tips.text = @"直播排期:";
    _tips.font = font(14);
    _tips.textColor = ThemeRedColor;
    
    UIView *centerView = [UIView new];
    [_backView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tips.mas_right).offset(scale(10));
        make.centerY.mas_equalTo(_tips.mas_centerY).offset(0);
        make.height.mas_equalTo(scale(35));
        make.right.mas_equalTo(_backView.mas_right).offset(scale(-20));
    }];
    centerView.layer.cornerRadius = scale(17.5);
    centerView.layer.masksToBounds = YES;
    centerView.backgroundColor = COLOR_STR1(0, 0, 0, 0.1);
    UIImageView *nextIcon = [UIImageView new];
    [centerView addSubview:nextIcon];
    [nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(centerView.mas_centerY).offset(0);
        make.right.mas_equalTo(centerView.mas_right).offset(scale(-12));
    }];
    nextIcon.image = [UIImage imageNamed:@"next_ss"];
    self.timeBtn = [UIButton new];
    [centerView addSubview:self.timeBtn];
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(centerView.mas_left).offset(scale(12));
        make.centerY.mas_equalTo(centerView.mas_centerY).offset(0);
        make.height.mas_equalTo(scale(35));
        make.right.mas_equalTo(centerView.mas_right).offset(scale(-20));
    }];
    self.timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.timeBtn setTitle:@"选择直播排期" forState:UIControlStateNormal];
    self.timeBtn.titleLabel.font = font(14);
    [self.timeBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
    [self.timeBtn addTarget:self action:@selector(times:) forControlEvents:UIControlEventTouchUpInside];
    
    _tipss = [UILabel new];
    [_backView addSubview:_tipss];
    [_tipss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tips.mas_bottom).offset(scale(14));
        make.left.mas_equalTo(_tips.mas_left).offset(0);
        make.width.mas_equalTo(_tips.mas_width);
        
    }];
    _tipss.text = @"寄样地址";
       _tipss.font = font1(@"PingFangSC-Medium", scale(14));
       _tipss.textColor = COLOR_STR(0x333333);
    
    self.choose_tip = [UILabel new];
    [_backView addSubview:self.choose_tip];
    [self.choose_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tipss.mas_right).offset(scale(5));
        make.right.mas_equalTo(_backView.mas_right).offset(-scale(5));
        make.centerY.mas_equalTo(_tipss.mas_centerY).offset(0);
    }];
    self.choose_tip.text = @"";
    self.choose_tip.font = font(14);
    self.choose_tip.textColor = COLOR_STR(0x333333);
    
    
    self.address_name = [UILabel new];
    [_backView addSubview:self.address_name];
    [self.address_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tipss.mas_left).offset(scale(0));
        make.right.mas_equalTo(_backView.mas_right).offset(-scale(15));
        make.top.mas_equalTo(_tipss.mas_bottom).offset(scale(5));
    }];
    self.address_name.text = @" ";
    self.address_name.font = font(14);
    self.address_name.textColor = COLOR_STR(0x333333);
    self.address_name.numberOfLines = 2;
    
    
    self.address_context = [UILabel new];
    [_backView addSubview:self.address_context];
    [self.address_context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tipss.mas_left).offset(scale(0));
        make.right.mas_equalTo(_backView.mas_right).offset(-scale(15));
        make.top.mas_equalTo(_address_name.mas_bottom).offset(scale(5));
    }];
    self.address_context.text = @"";
    self.address_context.font = font(14);
    self.address_context.textColor = COLOR_STR(0x333333);
    self.address_context.numberOfLines = 2;
    
    
    self.leftBtn = [UIButton new];
    [_backView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_backView.mas_bottom).offset(scale(-16));
        make.left.mas_equalTo(_tipss.mas_left).offset(0);
        make.right.mas_equalTo(_backView.mas_centerX).offset(scale(-5));
        make.height.mas_equalTo(scale(30));
    }];
    self.leftBtn.layer.cornerRadius = scale(15);
    self.leftBtn.layer.masksToBounds = YES;
    self.leftBtn.layer.borderWidth = 0.5;
    self.leftBtn.layer.borderColor = ThemeRedColor.CGColor;
    [self.leftBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = font(14);
    
    
    self.rightBtn = [UIButton new];
       [_backView addSubview:self.rightBtn];
       [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(_backView.mas_bottom).offset(scale(-16));
           make.left.mas_equalTo(_backView.mas_centerX).offset(scale(5));
           make.right.mas_equalTo(_backView.mas_right).offset(scale(-20));
           make.height.mas_equalTo(scale(30));
       }];
       self.rightBtn.layer.cornerRadius = scale(15);
       self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.backgroundColor = ThemeRedColor;
       [self.rightBtn setTitle:@"提交报名" forState:UIControlStateNormal];
       [self.rightBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
       self.rightBtn.titleLabel.font = font(14);
    
    
    
    self.centerBtn = [UIButton new];
       [_backView addSubview:self.centerBtn];
       [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(_backView.mas_bottom).offset(scale(-16));
           make.centerX.mas_equalTo(_backView.mas_centerX).offset(scale(0));
           make.right.mas_equalTo(_backView.mas_right).offset(scale(-20));
           make.height.mas_equalTo(scale(30));
       }];
       self.centerBtn.layer.cornerRadius = scale(15);
       self.centerBtn.layer.masksToBounds = YES;
    self.centerBtn.backgroundColor =ThemeRedColor ;
       [self.centerBtn setTitle:@"确认" forState:UIControlStateNormal];
       [self.centerBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
       self.centerBtn.titleLabel.font = font(14);
    self.centerBtn.hidden = YES;
    
    self.tipLab = [UILabel new];
       [_backView addSubview:self.tipLab];
       [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(self.leftBtn.mas_top).offset(scale(-10));
           make.centerX.mas_equalTo(0);
           
       }];
       self.tipLab.text = @"请选择预估直播排期时间";
       self.tipLab.hidden = YES;
          self.tipLab.font = font1(@"PingFangSC-Regular", scale(13));
          self.tipLab.textColor = ThemeRedColor;
    [self.leftBtn addTarget:self action:@selector(leftA:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerBtn addTarget:self action:@selector(rightA) forControlEvents:UIControlEventTouchUpInside];

    [self.rightBtn addTarget:self action:@selector(rightA) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setShenqing:(NSString *)shenqing
{
    if ([shenqing isEqualToString:@"12"]) {
        [_address_context mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.timeBtn.mas_bottom).offset(scale(40));
        }];
    }
    
}
-(void)leftA:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"添加地址"]) {
        if (self.addBlock) {
            self.addBlock();
        }
    }
    else
    {
        if (self.changeBlock) {
            self.changeBlock();
        }
    }
}
-(void)rightA
{
    if (self.applyBlock) {
        self.applyBlock();
    }
}
-(void)closeclick
{
    [self removeFromSuperview];
   
}
-(NSString*)getCurrentTimes{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY.MM.dd"];

    //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

    //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

    NSLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;

}
-(void)times:(UIButton *)sender
{
    NSDate* date;
    if ([self.timeBtn.titleLabel.text isEqualToString:@"选择直播排期"]) {
        NSString* dateStr =[NSString stringWithFormat:@"%@ 08:00",[self getCurrentTimes]];

            NSDateFormatter* formater = [[NSDateFormatter alloc] init];

            [formater setDateFormat:@"yyyy.MM.dd HH:mm"];
          date  = [formater dateFromString:dateStr];
    }
    else
    {
    NSString* dateStr = self.timeBtn.titleLabel.text;

        NSDateFormatter* formater = [[NSDateFormatter alloc] init];

        [formater setDateFormat:@"yyyy.MM.dd HH:mm"];
      date  = [formater dateFromString:dateStr];

    }
    [DatePickerAlertView showDatePickerAlertViewWithDateFormat:D_yyyyMMddHHmm
                                                datePickerMode:UIDatePickerModeDateAndTime
                                              selectCompletion:^(NSDate *fromDate, NSDate *toDate) {
                                                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                                  [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
                                                  NSString *strDate = [dateFormatter stringFromDate:fromDate];
                                                  NSLog(@"--------%@", strDate);
                                                  [self.timeBtn setTitle:strDate forState:UIControlStateNormal];
                                                  [self.timeBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
                                                  self.tipLab.hidden = YES;
                                              } withTime:date];

}
-(NSString* )getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
       [formatter setDateStyle:NSDateFormatterMediumStyle];
       [formatter setTimeStyle:NSDateFormatterShortStyle];
       [formatter setDateFormat:@"YYYY-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
       //设置时区,这个对于时间的处理有时很重要
       NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
       [formatter setTimeZone:timeZone];
       NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
       NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return [NSString stringWithFormat:@"%ld",[timeSp integerValue]];

}
@end
