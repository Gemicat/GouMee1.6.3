//
//  IDEditViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/1/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "IDEditViewCell.h"

@implementation IDEditViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.frontLab = [UILabel new];
    [self addSubview:self.frontLab];
    [self.frontLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(0);
    }];
    self.frontLab.font = font1(@"PingFangSC-Regular", scale(12));
    self.frontLab.textColor = COLOR_STR(0x333333);
    self.frontLab.text = @"姓名";
    
    
    self.field = [UITextField new];
    [self addSubview:self.field];
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.frontLab.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    self.field.placeholder = @"请输入开户行";
    self.field.enabled = NO;
    self.field.textColor = COLOR_STR(0x333333);
    self.field.font = font1(@"PingFangSC-Regular", scale(12));
}
@end
