//
//  ScheduleViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "ScheduleViewCell.h"

@implementation ScheduleViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_STR(0xf5f5f5);
        [self creatView];
    }
    return self;
}

-(void)creatView
{

    UIView *backView = [UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(10));
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(scale(15));
        make.bottom.mas_equalTo(0);
    }];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    
    UIView *line1 = [UIView new];
    [backView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(33));
        make.left.mas_equalTo(scale(10));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));
    }];
    line1.backgroundColor = COLOR_STR(0xf2f2f2);
    
    UIView *line2 = [UIView new];
    [backView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(scale(-33));
        make.left.mas_equalTo(scale(10));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));
    }];
    line2.backgroundColor = COLOR_STR(0xf2f2f2);
    
    
    UIView *line3 = [UIView new];
       [backView addSubview:line3];
       [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(line1.mas_bottom).offset(scale(15));
           make.left.mas_equalTo(SW/3.0-scale(10));
           make.bottom.mas_equalTo(line2.mas_top).offset(scale(-15));
           make.width.mas_equalTo(scale(0.5));
       }];
       line3.backgroundColor = COLOR_STR(0xf2f2f2);
    
    UIView *line4 = [UIView new];
    [backView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(scale(15));
        make.right.mas_equalTo(-SW/3.0+scale(10));
        make.bottom.mas_equalTo(line2.mas_top).offset(scale(-15));
        make.width.mas_equalTo(scale(0.5));
    }];
    line4.backgroundColor = COLOR_STR(0xf2f2f2);
    
    self.liveTime = [UILabel new];
    [backView addSubview:self.liveTime];
    [self.liveTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top).offset(0);
        make.left.mas_equalTo(line1.mas_left).offset(0);
        make.bottom.mas_equalTo(line1.mas_top).offset(0);
    }];
    self.liveTime.textColor = COLOR_STR(0x333333);
    self.liveTime.font = font1(@"PingFangSC-Medium", scale(14));
    self.liveTime.text = @"1月28日09:00";

    UIImageView *nextIcon = [UIImageView new];
    [backView addSubview:nextIcon];
    [nextIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.liveTime.mas_centerY).offset(0);
        make.right.mas_equalTo(backView.mas_right).offset(scale(-10));
    }];
    nextIcon.image = [UIImage imageNamed:@"next_icon"];
    self.wentLab = [UILabel new];
    [backView addSubview:self.wentLab];
    [self.wentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(line3.mas_centerY).offset(scale(-2));
        make.left.mas_equalTo(backView.mas_left).offset(5);
        make.right.mas_equalTo(line3.mas_left).offset(-5);
        
    }];
    self.wentLab.textColor = COLOR_STR(0x333333);
    self.wentLab.text = @"30款";
    self.wentLab.textAlignment = NSTextAlignmentCenter;
    self.wentLab.font = font1(@"PingFangSC-Medium", scale(11));
    
    self.willLab = [UILabel new];
    [backView addSubview:self.willLab];
    [self.willLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(line3.mas_centerY).offset(scale(-2));
        make.left.mas_equalTo(line3.mas_right).offset(5);
        make.right.mas_equalTo(line4.mas_left).offset(-5);
        
    }];
    self.willLab.textColor = COLOR_STR(0x333333);
    self.willLab.text = @"30款";
    self.willLab.textAlignment = NSTextAlignmentCenter;
    self.willLab.font = font1(@"PingFangSC-Medium", scale(11));
    NSMutableAttributedString * attriStr1 = [[NSMutableAttributedString alloc] initWithString:self.willLab.text];
    [attriStr1 addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(18)) range:NSMakeRange(0,2)];
    self.willLab.attributedText = attriStr1;
    
    self.notLab = [UILabel new];
       [backView addSubview:self.notLab];
       [self.notLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(line3.mas_centerY).offset(scale(-2));
           make.left.mas_equalTo(line4.mas_right).offset(5);
           make.right.mas_equalTo(backView.mas_right).offset(-5);
           
       }];
       self.notLab.textColor = COLOR_STR(0x333333);
       self.notLab.text = @"30款";
       self.notLab.textAlignment = NSTextAlignmentCenter;
       self.notLab.font = font1(@"PingFangSC-Medium", scale(11));
       NSMutableAttributedString * attriStr2 = [[NSMutableAttributedString alloc] initWithString:self.notLab.text];
       [attriStr2 addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(18)) range:NSMakeRange(0,2)];
       self.notLab.attributedText = attriStr2;
    
    UILabel *tip = [UILabel new];
    [backView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wentLab.mas_bottom).offset(scale(4));
        make.centerX.mas_equalTo(self.wentLab.mas_centerX).offset(0);
    }];
    tip.font = font(12);
    tip.textColor =COLOR_STR(0x999999);
    tip.text = @"已到样";
    
    UILabel *tip1 = [UILabel new];
    [backView addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.willLab.mas_bottom).offset(scale(4));
        make.centerX.mas_equalTo(self.willLab.mas_centerX).offset(0);
    }];
    tip1.font = font(12);
    tip1.textColor =COLOR_STR(0x999999);
    tip1.text = @"途中";
    
    UILabel *tip2 = [UILabel new];
    [backView addSubview:tip2];
    [tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.notLab.mas_bottom).offset(scale(4));
        make.centerX.mas_equalTo(self.notLab.mas_centerX).offset(0);
    }];
    tip2.font = font(12);
    tip2.textColor =COLOR_STR(0x999999);
    tip2.text = @"未发货";
    
    self.numLab = [UILabel new];
    [backView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2.mas_left).offset(0);
        make.top.mas_equalTo(line2.mas_bottom).offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(0);
    }];
    self.numLab.textColor = COLOR_STR(0x333333);
    self.numLab.font = font(12);
    self.numLab.text = @"共36款商品";
    NSMutableAttributedString * attriStrs = [[NSMutableAttributedString alloc] initWithString:self.numLab.text];
    [attriStrs addAttribute:NSFontAttributeName value:font(14) range:NSMakeRange(1,2)];
    [attriStrs addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(1, 2)];
    self.numLab.attributedText = attriStrs;
    
    
    self.timeLab = [UILabel new];
    [backView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line2.mas_right).offset(0);
        make.top.mas_equalTo(line2.mas_bottom).offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(0);
    }];
    
    self.timeLab.textColor = COLOR_STR(0x333333);
    self.timeLab.font = font(12);
    self.timeLab.text = @"距开播还剩 11天23:11";


}
-(void)addModel:(NSDictionary *)model
{
    NSString *wentStr = [NSString stringWithFormat:@"%@款",model[@"arrival_count"]];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:wentStr];
       [attriStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(18)) range:NSMakeRange(0,wentStr.length-1)];
       self.wentLab.attributedText = attriStr;
    
    NSString *willStr = [NSString stringWithFormat:@"%@款",model[@"send_count"]];
       NSMutableAttributedString * attriStrs = [[NSMutableAttributedString alloc] initWithString:willStr];
          [attriStrs addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(18)) range:NSMakeRange(0,willStr.length-1)];
          self.willLab.attributedText = attriStrs;
    
    NSString *notStr = [NSString stringWithFormat:@"%@款",model[@"unsend_count"]];
          NSMutableAttributedString * attriStrss = [[NSMutableAttributedString alloc] initWithString:notStr];
             [attriStrss addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(18)) range:NSMakeRange(0,notStr.length-1)];
             self.notLab.attributedText = attriStrss;
      NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_time"] andFormatter:@"YYY-MM-dd HH:mm:"] andFormatter:@"MM月dd日 HH:mm"];
    self.liveTime.text = time;
    NSString *num = [NSString stringWithFormat:@"%@",model[@"good_count"]];
    NSMutableAttributedString * attriStrT = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共 %@ 款商品",model[@"good_count"]]];
       [attriStrT addAttribute:NSFontAttributeName value:font(14) range:NSMakeRange(2,num.length)];
       [attriStrT addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, num.length)];
       self.numLab.attributedText = attriStrT;
    if ([model[@"countdown"] isEqualToString:@"0分"]) {
        self.timeLab.text = @"已到开播时间";
    }
    else
    {
    self.timeLab.text = [NSString stringWithFormat:@"距开播还剩 %@",model[@"countdown"]];
    }
}

@end
