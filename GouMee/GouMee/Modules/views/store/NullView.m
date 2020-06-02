//
//  NullView.m
//  GouMee
//
//  Created by 白冰 on 2019/12/21.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "NullView.h"

@implementation NullView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
  
    self.nullIocn = [UIImageView new];
    [self addSubview:self.nullIocn];
    [self.nullIocn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-70);
    }];
    self.nullTitle = [UILabel new];
    [self addSubview:self.nullTitle];
    self.nullTitle.textColor = COLOR_STR(0x999999);
    self.nullTitle.font = font(12);
    [self.nullTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nullIocn.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
    }];
    
    self.refreshBtn = [UIButton new];
    [self addSubview:self.refreshBtn];
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nullTitle.mas_bottom).offset(30);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];
    self.refreshBtn.layer.cornerRadius = 15;
    self.refreshBtn.layer.masksToBounds = YES;
    [self.refreshBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    [self.refreshBtn setTitleColor:COLOR_STR(0xffffff) forState:UIControlStateNormal];
    self.refreshBtn.titleLabel.font = font1(@"PingFangSC-Regular", scale(12));
    [self.refreshBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [self.refreshBtn addTarget:self action:@selector(review) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)review
{
    if (self.click) {
        self.click();
    }
}
@end
