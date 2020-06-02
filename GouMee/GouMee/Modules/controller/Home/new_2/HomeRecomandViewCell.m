//
//  HomeRecomandViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/5/13.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "HomeRecomandViewCell.h"

@implementation HomeRecomandViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    UIImageView *backImg = [UIImageView new];
    [self addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    backImg.image = [UIImage imageNamed:@"jingpin"];
    UILabel *tips = [UILabel new];
    [self addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backImg.mas_right).offset(7);
        make.bottom.mas_equalTo(backImg.mas_bottom).offset(2);
    }];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (app.auditStatus == 0) {
        tips.text = @"直播特价，赚取佣金";
    }
    else
    {
        tips.text = @"直播特价";
    }

    tips.textColor = COLOR_STR(0x999999);
    tips.font = font(12);
}
@end
