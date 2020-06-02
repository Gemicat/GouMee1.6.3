//
//  PerformanceViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "PerformanceViewCell.h"

@implementation PerformanceViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.markLab = [UILabel new];
    [self.contentView addSubview:self.markLab];
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_centerY).offset(-8);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(0);
        make.left.mas_equalTo(8);
    }];
    self.markLab.textAlignment = NSTextAlignmentCenter;
    self.markLab.text = @"今日付款预估";
    self.markLab.font = font1(@"PingFangSC-Regular", scale(12));
    self.markLab.textColor = COLOR_STR(0xA9AEB9);
    
    self.moneyLab = [UILabel new];
    [self.contentView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_centerY).offset(5);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(0);
        make.left.mas_equalTo(8);
    }];
    self.moneyLab.textAlignment = NSTextAlignmentCenter;
    self.moneyLab.text = @"8888.88";
    self.moneyLab.font = font1(@"PingFangSC-Semibold", scale(15));
    self.moneyLab.textColor = COLOR_STR(0x333333);
}
@end
