//
//  MineReusableView.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "MineReusableView.h"

@implementation MineReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addTexts:self];
    }
    return self;
}




- (void)addTexts:(UIView*)view {
    UIView *topView = [UIView new];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(scale(15));
    }];
    topView.layer.cornerRadius = scale(7.5);
    topView.layer.masksToBounds = YES;
    topView.backgroundColor =[UIColor clearColor];

    self.textLab = [UILabel new];
    [self addSubview:self.textLab];
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(6);
        make.top.mas_equalTo(topView.mas_top).offset(3);
    }];
    self.textLab.textColor = COLOR_STR(0x333333);
    self.textLab.font = font1(@"PingFangSC-Medium", scale(14));
    self.textLab.text = @"";
}
@end
