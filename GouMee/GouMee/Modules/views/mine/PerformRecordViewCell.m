//
//  PerformRecordViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/17.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "PerformRecordViewCell.h"

@implementation PerformRecordViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

if (self) {
    
    [self creatCell];
}
    return self;
}
-(void)creatCell
{
    self.dateLab = [UILabel new];
    [self.contentView addSubview:self.dateLab];
    self.dateLab.textColor = COLOR_STR(0x999999);
    self.dateLab.font = font1(@"PingFangSC-Regular", scale(12));
    self.dateLab.textAlignment = NSTextAlignmentCenter;
    
    self.payNum = [UILabel new];
    [self.contentView addSubview:self.payNum];
    self.payNum.textColor = COLOR_STR(0x999999);
    self.payNum.font = font1(@"PingFangSC-Regular", scale(12));
    self.payNum.textAlignment = NSTextAlignmentCenter;
    
    self.payMoney = [UILabel new];
    [self.contentView addSubview:self.payMoney];
    self.payMoney.textColor = COLOR_STR(0x999999);
    self.payMoney.font = font1(@"PingFangSC-Regular", scale(12));
    self.payMoney.textAlignment = NSTextAlignmentCenter;
    
    self.settleMoney = [UILabel new];
    [self.contentView addSubview:self.settleMoney];
    self.settleMoney.textColor = COLOR_STR(0x999999);
    self.settleMoney.font = font1(@"PingFangSC-Regular", scale(12));
    self.settleMoney.textAlignment = NSTextAlignmentCenter;
    
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.contentView.mas_left).offset(0);
           make.centerY.mas_equalTo(0);
           make.width.mas_equalTo((SW-37)/4.0);
           
       }];
    
    [self.payNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dateLab.mas_right).offset(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo((SW-37)/4.0-20);
        
    }];
    [self.payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.payNum.mas_right).offset(0);
           make.centerY.mas_equalTo(0);
           make.width.mas_equalTo((SW-37)/4.0+10);
           
       }];
    [self.settleMoney mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.payMoney.mas_right).offset(0);
           make.centerY.mas_equalTo(0);
           make.width.mas_equalTo((SW-37)/4.0+10);
           
       }];
    
    self.dateLab.text = @"2109-12-12";
    self.payNum.text = @"100";
    self.payMoney.text = @"1000.00";
    self.settleMoney.text = @"900.99";
                                                                   
    self.line = [UIView new];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    self.line.backgroundColor =COLOR_STR(0xDEDEDE);
    self.line.hidden= YES;
                                                                   
                                                                   
    
    
    
    
    
    
    
}
@end
