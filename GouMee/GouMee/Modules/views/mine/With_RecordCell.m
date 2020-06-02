//
//  With_RecordCell.m
//  GouMee
//
//  Created by 白冰 on 2020/1/8.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "With_RecordCell.h"

@implementation With_RecordCell

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
    self.dateLab = [UILabel new];
    [self addSubview:self.dateLab];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(self.mas_centerY).offset(0);
        make.left.mas_equalTo(15);
    }];
    self.dateLab.text = @"2019-12-05";
    self.dateLab.textColor = COLOR_STR(0x333333);
    self.dateLab.font = font1(@"PingFangSC-Regular", scale(12));
    
    
    self.timeLab = [UILabel new];
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(self.mas_centerY).offset(0);
        make.left.mas_equalTo(15);
    }];
    self.timeLab.text = @"11:11:23";
    self.timeLab.textColor = COLOR_STR(0x999999);
    self.timeLab.font = font1(@"PingFangSC-Regular", scale(12));
    
    self.moneyLab = [UILabel new];
    [self addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        make.centerX.mas_equalTo(0);
        
        
    }];
    self.moneyLab.text = @"100000.00";
    self.moneyLab.textColor = COLOR_STR(0x333333);
    self.moneyLab.font = font1(@"PingFangSC-Medium", scale(14));
    
    
    self.statusLab = [UILabel new];
    [self addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        make.right.mas_equalTo(-10);
        
        
    }];
    self.statusLab.text = @"待处理";
    self.statusLab.textColor = COLOR_STR(0x1B9747);
    self.statusLab.font = font1(@"PingFangSC-Regular", scale(14));
    
    
    self.statusLabs = [UILabel new];
       [self addSubview:self.statusLabs];
       [self.statusLabs mas_makeConstraints:^(MASConstraintMaker *make) {
          
           make.centerY.mas_equalTo(self.dateLab.mas_centerY).offset(0);
           make.right.mas_equalTo(-10);
           
           
       }];
       self.statusLabs.text = @"未通过";
       self.statusLabs.textColor = COLOR_STR(0x999999);
       self.statusLabs.font = font1(@"PingFangSC-Regular", scale(12));
    
    self.resultBtn = [UILabel new];
          [self addSubview:self.resultBtn];
          [self.resultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             
              make.centerY.mas_equalTo(self.timeLab.mas_centerY).offset(0);
              make.right.mas_equalTo(-10);
              
              
          }];
          self.resultBtn.text = @"查看原因";
          self.resultBtn.textColor = COLOR_STR(0xDF3811);
          self.resultBtn.font = font1(@"PingFangSC-Regular", scale(12));
    self.resultBtn.hidden = YES;
    self.statusLabs.hidden = YES;
    
    UILabel *line = [UILabel new];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = COLOR_STR(0xf0f0f0);
    
}
-(void)addModel:(NSDictionary *)model
{
    self.moneyLab.text = [NSString stringWithFormat:@"%@",model[@"money"]];
    NSArray *array = [model[@"create_time"] componentsSeparatedByString:@" "];
    if (array.count ==2) {
 
    self.dateLab.text = array[0];
    self.timeLab.text = array[1];
    }
    NSInteger status = [model[@"status"] intValue];
    if (status == 1) {
        //待处理
        self.statusLab.text = @"待处理";
           self.statusLab.textColor = COLOR_STR(0x1B9747);
        self.statusLabs.hidden = YES;
         self.statusLab.hidden = NO;
        self.resultBtn.hidden = YES;
        
    }
    if (status == 2) {
        //已完成
        self.statusLab.text = @"已完成";
           self.statusLab.textColor = COLOR_STR(0x999999);
        self.statusLabs.hidden = YES;
               self.resultBtn.hidden = YES;
         self.statusLab.hidden = NO;
        
    }
    if (status == 3) {
        //被驳回
        self.statusLabs.hidden = NO;
               self.resultBtn.hidden = NO;
        self.statusLab.hidden = YES;
    }
    
}
@end
