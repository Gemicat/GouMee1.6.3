//
//  MessageViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "MessageViewCell.h"

@implementation MessageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

if (self) {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self creatCell];
}
    return self;
}
-(void)creatCell
{
    self.leftBtn = [LCVerticalBadgeBtn new];
    [self addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(scale(12));
        make.width.mas_equalTo(scale(44));
    }];
    self.leftBtn.messageStr = @"消息";
    self.titleLab = [UILabel new];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftBtn.mas_top).offset(0);
        make.left.mas_equalTo(self.leftBtn.mas_right).offset(scale(15));
    }];
    self.titleLab.textColor = COLOR_STR(0x333333);
    self.titleLab.font = font1(@"PingFangSC-Medium", scale(16));
    self.titleLab.text = @"账户通知";
    
    
    self.context = [UILabel new];
       [self addSubview:self.context];
       [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(self.leftBtn.mas_bottom).offset(3);
           make.left.mas_equalTo(self.leftBtn.mas_right).offset(scale(15));
           make.right.mas_equalTo(scale(scale(-12)));
       }];
       self.context.textColor = COLOR_STR(0x999999);
       self.context.font = font1(@"PingFangSC-Regular", scale(14));
       self.context.text = @"您的实名认证资料已通过审核";
    
    self.timeLab = [UILabel new];
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY).offset(0);
        make.right.mas_equalTo(scale(scale(-12)));
    }];
    self.timeLab.textColor = COLOR_STR(0x999999);
    self.timeLab.font = font1(@"PingFangSC-Regular", scale(12));
    self.timeLab.text = @"12:30";
    
    self.line = [UIView new];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.titleLab.mas_left).offset(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));
    }];
    self.line.backgroundColor = COLOR_STR(0xf4f6f6);
    self.line.hidden = YES;
    
}

@end
