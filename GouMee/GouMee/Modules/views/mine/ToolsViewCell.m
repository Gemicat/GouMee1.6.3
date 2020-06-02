//
//  ToolsViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "ToolsViewCell.h"
#import "LCVerticalBadgeBtn.h"
#import "AppDelegate.h"
@implementation ToolsViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
//    self.toolIcon = [UIImageView new];
//    [self.contentView addSubview:self.toolIcon];
//    [self.toolIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(10);
//        make.centerX.mas_equalTo(0);
//        make.height.width.mas_equalTo(42);
//    }];
//    self.toolIcon.layer.cornerRadius = 8;
//    self.toolIcon.layer.masksToBounds = YES;
//    self.toolIcon.backgroundColor = [UIColor clearColor];
//    self.toolName = [UILabel new];
//    [self.contentView addSubview:self.toolName];
//    [self.toolName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.toolIcon.mas_bottom).offset(10);
//        make.centerX.mas_equalTo(0);
//    }];
//    self.toolName.textColor = COLOR_STR(0x333333);
//    self.toolName.font = font1(@"PingFangSC-Medium", scale(11));
//    self.toolName.text = @"淘宝客PID";

    self.backgroundColor = COLOR_STR(0xf5f5f5);
    UIView *bakcView = [UIView new];
    [self addSubview:bakcView];
    [bakcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(scale(15));
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-40);
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
    tips.text = @"我的工具";
    tips.textColor = COLOR_STR(0x333333);
    tips.font =font1(@"PingFangSC-Medium", scale(14));

    UIView *line = [UIView new];
    [bakcView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tips.mas_bottom).offset(6);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = COLOR_STR(0xf9f9f9);

    LCVerticalBadgeBtn *BoBtn = [LCVerticalBadgeBtn new];
    [bakcView addSubview:BoBtn];
    [BoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(11);
        make.bottom.mas_equalTo(bakcView.mas_bottom).offset(-10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo((SW-scale(30))/4.0);
    }];
    BoBtn.titleLabel.font = font(13);
    [BoBtn setTitle:@"直播排期" forState:UIControlStateNormal];
    [BoBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    [BoBtn setImage:[UIImage imageNamed:@"Bo_icon"] forState:UIControlStateNormal];
    [BoBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:15];




    LCVerticalBadgeBtn *collectBtn = [LCVerticalBadgeBtn new];
    [bakcView addSubview:collectBtn];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(11);
        make.bottom.mas_equalTo(bakcView.mas_bottom).offset(-10);
        make.left.mas_equalTo(BoBtn.mas_right).offset(0);
        make.width.mas_equalTo((SW-scale(30))/4.0);
    }];
    collectBtn.titleLabel.font = font(13);
    [collectBtn setTitle:@"收藏夹" forState:UIControlStateNormal];
    [collectBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"collect_mine"] forState:UIControlStateNormal];
     [collectBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:15];


    LCVerticalBadgeBtn *PidBtn = [LCVerticalBadgeBtn new];
    [bakcView addSubview:PidBtn];
    [PidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(11);
        make.bottom.mas_equalTo(bakcView.mas_bottom).offset(-10);
        make.left.mas_equalTo(collectBtn.mas_right).offset(0);
        make.width.mas_equalTo((SW-scale(30))/4.0);
    }];
    PidBtn.titleLabel.font = font(13);
    [PidBtn setTitle:@"淘宝客PID" forState:UIControlStateNormal];
    [PidBtn setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
    [PidBtn setImage:[UIImage imageNamed:@"PID_icon"] forState:UIControlStateNormal];
    [PidBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleTop imageTitleSpace:15];
    



    UILabel *tipss = [UILabel new];
    [self addSubview:tipss];
    [tipss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(15));
        make.bottom.mas_equalTo(self.mas_bottom).offset(-6);

    }];
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.auditStatus == 0) {
         tipss.text = @"帮助中心";
    }
   
    tipss.textColor = COLOR_STR(0x333333);
    tipss.font =font1(@"PingFangSC-Medium", scale(14));

    [collectBtn addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    [PidBtn addTarget:self action:@selector(pid) forControlEvents:UIControlEventTouchUpInside];
     [BoBtn addTarget:self action:@selector(boAction) forControlEvents:UIControlEventTouchUpInside];

}
-(void)boAction
{
    if (self.clickBlock) {
        self.clickBlock(3);
    }
    
}
-(void)collect
{
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}
-(void)pid
{

    if (self.clickBlock) {
        self.clickBlock(2);
    }
}
@end
