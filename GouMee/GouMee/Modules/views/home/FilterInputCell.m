//
//  FilterInputCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/13.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "FilterInputCell.h"

@implementation FilterInputCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.lowPrice = [UITextField new];
    [self.contentView addSubview:self.lowPrice];
    self.highPrice = [UITextField new];
    [self.contentView addSubview:self.highPrice];
    self.line = [UIView new];
    [self.contentView addSubview:self.line];
    self.profitsNum = [UITextField new];
    [self.contentView addSubview:self.profitsNum];
    self.markLab = [UILabel new];
    [self.contentView addSubview:self.markLab];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(20);
    }];
    self.line.backgroundColor = COLOR_STR(0xe6e6e6);
    
    [self.lowPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.height.mas_equalTo(scale(30));
        make.right.mas_equalTo(self.line.mas_left).offset(-20);
    }];
    self.lowPrice.layer.cornerRadius = scale(15);
    self.lowPrice.layer.masksToBounds = YES;
    self.lowPrice.font = font(10);
    self.lowPrice.backgroundColor = COLOR_STR(0xf2f2f2);
    self.lowPrice.textAlignment = NSTextAlignmentCenter;
    self.lowPrice.placeholder = @"最低价";
    [self.highPrice mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
           make.right.mas_equalTo(self.contentView.mas_right).offset(0);
           make.height.mas_equalTo(scale(30));
           make.left.mas_equalTo(self.line.mas_right).offset(20);
       }];
       self.highPrice.layer.cornerRadius = scale(15);
       self.highPrice.layer.masksToBounds = YES;
       self.highPrice.font = font(10);
       self.highPrice.backgroundColor = COLOR_STR(0xf2f2f2);
       self.highPrice.textAlignment = NSTextAlignmentCenter;
    self.highPrice.placeholder = @"最高价";
    self.highPrice.hidden = YES;
    self.lowPrice.hidden = YES;
    self.line.hidden = YES;
    [self.profitsNum mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
              make.height.mas_equalTo(scale(30));
              make.left.mas_equalTo(self.contentView.mas_left).offset(0);
              make.right.mas_equalTo(self.contentView.mas_centerX).offset(-5);
          }];
          self.profitsNum.layer.cornerRadius = scale(15);
          self.profitsNum.layer.masksToBounds = YES;
          self.profitsNum.font = font(10);
          self.profitsNum.backgroundColor = COLOR_STR(0xf2f2f2);
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.profitsNum.mas_centerY).offset(0);
        make.left.mas_equalTo(self.profitsNum.mas_right).offset(5);
    }];
    self.markLab.text = @"%以上";
    self.markLab.font = font(10);
    self.markLab.textColor = COLOR_STR(0x333333);
    self.markLab.hidden = YES;
    self.profitsNum.hidden = YES;
    
    
}
@end
