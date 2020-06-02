//
//  HelpViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "HelpViewCell.h"

@implementation HelpViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{


    self.backgroundColor= COLOR_STR(0xffffff);
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;

    self.backView = [UIImageView new];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(8);
    }];
    self.name = [UILabel new];
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.backView.mas_right).offset(5);

    }];
    self.name.textColor = COLOR_STR(0x333333);
    self.name.font = font1(@"PingFangSC-Medium", scale(12));
}
@end
