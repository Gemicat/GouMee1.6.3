//
//  JoinMessageView.m
//  GouMee
//
//  Created by 白冰 on 2020/4/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "JoinMessageView.h"

@implementation JoinMessageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SW, SH);
               self.backgroundColor = COLOR_STR1(0, 0, 0, 0.3);
        [self creaView];
        
    }
    return self;
}
-(void)creaView
{
    
    _backView = [UIView new];
    [self addSubview:_backView];
    _backView.layer.cornerRadius = 8;
    _backView.layer.masksToBounds = YES;
    _backView.backgroundColor = [UIColor whiteColor];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
               
               make.left.mas_equalTo(scale(54));
        make.height.mas_equalTo(_backView.mas_width);
               make.centerX.mas_equalTo(0);
    }];
    _topIcon = [UIImageView new];
    [_backView addSubview:_topIcon];
    _topIcon.backgroundColor = [UIColor clearColor];
    [_topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backView.mas_top).offset(scale(16));
        make.centerX.mas_equalTo(0);

    }];
    _topIcon.image = [UIImage imageNamed:@"join_fail"];
    _closeBtn = [UIButton new];
    [_backView addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.right.mas_equalTo(-12);
        make.height.width.mas_equalTo(30);
    }];
    [_closeBtn setImage:[UIImage imageNamed:@"sheet_close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeclick) forControlEvents:UIControlEventTouchUpInside];
    
        
    _copysBtn = [UIButton new];
    [_backView addSubview:_copysBtn];
    [_copysBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_backView.mas_bottom).offset(scale(-16));
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(_backView.mas_left).offset(scale(15));
        make.height.mas_equalTo(scale(30));
    }];
    _copysBtn.layer.cornerRadius = scale(15);
    _copysBtn.layer.masksToBounds = YES;
    _copysBtn.backgroundColor = ThemeRedColor;
   
    [_copysBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [_copysBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    _copysBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(14));
    [_copysBtn addTarget:self action:@selector(closeclick) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabs = [UILabel new];
    [_backView addSubview:self.titleLabs];
    [self.titleLabs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_topIcon.mas_bottom).offset(scale(12));
        make.centerX.mas_equalTo(0);
    }];
    self.titleLabs.textColor = ThemeRedColor;
    self.titleLabs.font = font1(@"PingFangSC-Medium", scale(16));
    self.titleLabs.text = @"报名失败";
    
    self.contextLabs = [UILabel new];
    [_backView addSubview:self.contextLabs];
    [self.contextLabs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabs.mas_bottom).offset(scale(12));
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(_backView.mas_left).offset(scale(32));
    }];
    self.contextLabs.textAlignment = NSTextAlignmentCenter;
    self.contextLabs.textColor = COLOR_STR(0x333333);
    self.contextLabs.font = font(13);
    self.contextLabs.text = @"您当前暂不符合报名条件，如有疑问请联系您的对接人";
    self.contextLabs.numberOfLines = 0;
    
    
    
}


-(void)closeclick
{
    [self removeFromSuperview];
}

@end
