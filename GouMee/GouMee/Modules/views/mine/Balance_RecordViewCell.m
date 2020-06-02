//
//  Balance_RecordViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/1/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Balance_RecordViewCell.h"

@implementation Balance_RecordViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

if (self) {
    
    [self creatCell];
}
    return self;
}
-(void)creatCell
{
    self.backgroundColor = [UIColor whiteColor];
    self.typeLab = [UILabel new];
    [self addSubview:self.typeLab];
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(self.mas_centerY).offset(0);
        make.left.mas_equalTo(15);
    }];
    self.typeLab.textColor = COLOR_STR(0x333333);
    self.typeLab.font = font1(@"PingFangSC-Regular", scale(12));
    self.typeLab.text = @"提现";
    
    self.retainLab = [UILabel new];
    [self addSubview:self.retainLab];
    [self.retainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(self.mas_centerY).offset(0);
        make.left.mas_equalTo(15);
    }];
    self.retainLab.textColor = COLOR_STR(0x999999);
    self.retainLab.font = font1(@"PingFangSC-Regular", scale(10));
    self.retainLab.text = @"余额：0.00";
    
    self.timeLab = [UILabel new];
       [self addSubview:self.timeLab];
       [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(self.typeLab.mas_centerY).offset(0);
           
           make.right.mas_equalTo(-15);
       }];
       self.timeLab.textColor = COLOR_STR(0x999999);
       self.timeLab.font = font1(@"PingFangSC-Regular", scale(10));
       self.timeLab.text = @"2019-12-12";
    
    self.moneyLab = [UILabel new];
          [self addSubview:self.moneyLab];
          [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.mas_equalTo(self.retainLab.mas_centerY).offset(0);
              
              make.right.mas_equalTo(-15);
          }];
          self.moneyLab.textColor = COLOR_STR(0x333333);
          self.moneyLab.font = font1(@"PingFangSC-Medium", scale(14));
          self.moneyLab.text = @"-10000.00";

    UILabel *line = [UILabel new];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = COLOR_STR(0xf0f0f0);
    
    
    
}
-(void)addModel:(NSDictionary *)model
{
    self.typeLab.text = model[@"title"];
    self.retainLab.text = [NSString stringWithFormat:@"余额：%@",model[@"current_balance"]];
    if (isNotNull(model[@"create_time"])) {
        self.timeLab.text =[model[@"create_time"] substringToIndex:10];
    }
   
    if ([model[@"status"] intValue] == 1) {
        self.moneyLab.text = [NSString stringWithFormat:@"+%@",model[@"money"]];
        self.moneyLab.textColor = COLOR_STR(0xDF3811);
    }
    else
    {
         self.moneyLab.text = [NSString stringWithFormat:@"%@",model[@"money"]];
        self.moneyLab.textColor = COLOR_STR(0x333333);
    }
    
    
}
@end
