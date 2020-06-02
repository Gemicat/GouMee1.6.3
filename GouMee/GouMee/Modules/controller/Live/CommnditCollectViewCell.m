//
//  CommnditCollectViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/12.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "CommnditCollectViewCell.h"

@interface CommnditCollectViewCell ()
{

    NSInteger type;
}

@end
@implementation CommnditCollectViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    return self;
}

-(void)creatView
{

    UILabel *tips = [UILabel new];
    [self addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(12));
          make.height.mas_equalTo(scale(20));
        make.left.mas_equalTo(scale(12));
    }];
    type = 1;
    tips.text = @"商品趋势";
    tips.textColor = COLOR_STR(0x333333);
    tips.font = font1(@"PingFangSC-Medium", scale(16));

    UIButton *lastBtn  = nil;
    NSArray *arr = @[@" 价格趋势",@" 佣金比例",@" 推广销量"];

    [self addSubview:lastBtn];
    NSArray *imgArr = @[@"price_w",@"yongjin_w",@"xiaoliang_w"];
    for (int i = 0 ; i < 3; i++) {
        UIButton *button = [UIButton new];
        [self addSubview:button];
        button.tag = i+1000;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = font(14);
        [button setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@s",imgArr[i]]] forState:UIControlStateSelected];
        [button setTitleColor:ThemeRedColor forState:UIControlStateSelected];
        [button setTitleColor:COLOR_STR(0x333333) forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tips.mas_bottom).offset(scale(6));
            make.height.mas_equalTo(scale(30));
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(scale(0));
            }
            else
            {

                make.left.mas_equalTo(0);
            }
            make.width.mas_equalTo(SW/3);
        }];


        lastBtn = button;
        UIView *lien = [UIView new];
        [button addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(SW/3-30);
        }];
        lien.backgroundColor = ThemeRedColor;
        lien.tag = 2000+i;
        if (i == 0) {
            button.selected = YES;
            lien.hidden = NO;
        }
        else
        {
            button.selected = NO;
            lien.hidden = YES;
        }

        [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    }

    UIView *lines = [UIView new];
    [self addSubview:lines];
    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lastBtn.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(1));
    }];
    lines.backgroundColor = viewColor;
    self.backView = [UIImageView new];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastBtn.mas_bottom).offset(scale(0));
        make.left.mas_equalTo(scale(12));
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(scale(-8));
    }];
      self.backView.contentMode = UIViewContentModeScaleAspectFit;

    UIView *line = [UIView new];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(scale(10));
    }];
    line.backgroundColor = viewColor;

}
-(void)getImgUrl:(NSInteger)type
{
    NSString *url = [NSString stringWithFormat:@"api/consumer/v1/chart/?chart_type=%@&item_id=%@",@(type),_model[@"item_id"]];
    [Network GET:url paramenters:nil success:^(id data) {
        if ([data[@"success"] intValue] == 1) {
            [self removeImageCacheFromUrl:data[@"data"]];
            if (isNotNull(data[@"data"])) {
  [self.backView sd_setImageWithURL:[NSURL URLWithString:data[@"data"]] placeholderImage:[UIImage imageNamed:@"qushi_bg"]];
            }
            else
            {
               
            }

        }
    } error:^(id data) {

    }];

}
-(void)removeImageCacheFromUrl:(NSString *)imageUrl
{
    [[SDImageCache sharedImageCache] removeImageForKey:imageUrl fromDisk:YES withCompletion:^{

    }];
}
-(void)setModel:(NSDictionary *)model
{
    _model = model;
    [self getImgUrl:type];
}
-(void)choose:(UIButton *)sender
{
    for (int i = 0; i<3; i++) {
        UIButton *button = [self viewWithTag:i+1000];
        button.selected = NO;
        UIView *line = [self viewWithTag:i+2000];
        line.hidden = YES;
    }
    sender.selected = !sender.selected;

    UIView *line = [self viewWithTag:sender.tag+1000];
    line.hidden = NO;
    type = sender.tag -999;
    [self getImgUrl:sender.tag-999];
}
@end
