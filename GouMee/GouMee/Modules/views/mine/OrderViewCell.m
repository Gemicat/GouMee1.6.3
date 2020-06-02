//
//  OrderViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/5.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "OrderViewCell.h"
#import "LCVerticalBadgeBtn.h"
@implementation OrderViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{

    self.backgroundColor = COLOR_STR(0xf5f5f5);
    UIView *bakcView = [UIView new];
    [self addSubview:bakcView];
    [bakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(scale(15));
               make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    bakcView.layer.cornerRadius = 10;
    bakcView.layer.masksToBounds = YES;
    bakcView.backgroundColor = [UIColor whiteColor];

    UILabel *tips = [UILabel new];
    [bakcView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(scale(10));
        make.height.mas_equalTo(24);

    }];
    tips.text = @"样品订单";
    tips.textColor = COLOR_STR(0x333333);
    tips.font =font1(@"PingFangSC-Medium", scale(14));
    
    UIButton *allBtn = [UIButton new];
    [bakcView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tips.mas_centerY).offset(0);
        make.right.mas_equalTo(bakcView.mas_right).offset(scale(-10));
    }];
    [allBtn setTitle:@"查看全部订单" forState:UIControlStateNormal];
    [allBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];
    allBtn.titleLabel.font = font(11);
    [allBtn addTarget:self action:@selector(all) forControlEvents:UIControlEventTouchUpInside];

    UIView *line = [UIView new];
    [bakcView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tips.mas_bottom).offset(6);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = COLOR_STR(0xf9f9f9);
    LCVerticalBadgeBtn *collectBtn = [LCVerticalBadgeBtn new];
    [bakcView addSubview:collectBtn];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(18);
        make.bottom.mas_equalTo(bakcView.mas_bottom).offset(-10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo((SW-scale(30))/4.0);
    }];
    collectBtn.badgeString = @"0";
    collectBtn.titleLabel.font = font(13);
    [collectBtn setTitle:@"待审核" forState:UIControlStateNormal];
    [collectBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"order_shenhe"] forState:UIControlStateNormal];
     [collectBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:14];
     

    LCVerticalBadgeBtn *PidBtn = [LCVerticalBadgeBtn new];
    [bakcView addSubview:PidBtn];
    [PidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(18);
        make.bottom.mas_equalTo(bakcView.mas_bottom).offset(-10);
        make.left.mas_equalTo(collectBtn.mas_right).offset(0);
        make.width.mas_equalTo((SW-scale(30))/4.0);
    }];
    PidBtn.titleLabel.font = font(13);
    PidBtn.badgeString = @"0";
    [PidBtn setTitle:@"待发货" forState:UIControlStateNormal];
    [PidBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    [PidBtn setImage:[UIImage imageNamed:@"order_fahuo"] forState:UIControlStateNormal];
    [PidBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:14];
    
    
    LCVerticalBadgeBtn *BoBtn = [LCVerticalBadgeBtn new];
    [bakcView addSubview:BoBtn];
    [BoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(18);
        make.bottom.mas_equalTo(bakcView.mas_bottom).offset(-10);
        make.left.mas_equalTo(PidBtn.mas_right).offset(0);
        make.width.mas_equalTo((SW-scale(30))/4.0);
    }];
    BoBtn.badgeString = @"0";
    BoBtn.titleLabel.font = font(13);
    [BoBtn setTitle:@"待收货" forState:UIControlStateNormal];
    [BoBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    [BoBtn setImage:[UIImage imageNamed:@"order_shouhuo"] forState:UIControlStateNormal];
    [BoBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:14];
    
    _SendBtn = [LCVerticalBadgeBtn new];
       [bakcView addSubview:_SendBtn];
       [_SendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(line.mas_bottom).offset(18);
           make.bottom.mas_equalTo(bakcView.mas_bottom).offset(-10);
           make.left.mas_equalTo(BoBtn.mas_right).offset(0);
           make.width.mas_equalTo((SW-scale(30))/4.0);
       }];
       _SendBtn.badgeString = @"0";
       _SendBtn.titleLabel.font = font(13);
       [_SendBtn setTitle:@"待寄回" forState:UIControlStateNormal];
       [_SendBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
       [_SendBtn setImage:[UIImage imageNamed:@"order_send"] forState:UIControlStateNormal];
       [_SendBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:14];
       [_SendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [collectBtn addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    [PidBtn addTarget:self action:@selector(pid) forControlEvents:UIControlEventTouchUpInside];
    [BoBtn addTarget:self action:@selector(bo) forControlEvents:UIControlEventTouchUpInside];
    self.collectBtn = collectBtn;
    self.PidBtn = PidBtn;
    self.BoBtn = BoBtn;
}
-(void)all
{
    
    if (self.click) {
        self.click(0);
    }
}
-(void)collect
{
    
    if (self.click) {
        self.click(1);
    }
}
-(void)pid
{
    if (self.click) {
           self.click(2);
       }
}
-(void)bo
{
    if (self.click) {
           self.click(3);
       }
}
-(void)send
{
    
    if (self.click) {
        self.click(7);
    }
}
@end
