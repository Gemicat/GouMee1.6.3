//
//  CommodityTrendViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/2.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "CommodityTrendViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface CommodityTrendViewCell ()
{
    NSInteger type;
}

@end
@implementation CommodityTrendViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

if (self) {
    self.backgroundColor = COLOR_STR(0xffffff);
    [self creatCell];
}
    return self;
}
-(void)creatCell
{
    type = 1;
     UILabel *tips = [UILabel new];
       [self addSubview:tips];
       [tips mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(scale(12));
           make.height.mas_equalTo(scale(20));
           make.left.mas_equalTo(scale(12));
       }];
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

   MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _hud.label.text = @"正在加载中...";

    _hud.label.textColor = COLOR_STR(0x333333);
    //hud.bezelView.style = MBProgressHUDBackgroundStyleSolidCo;
    _hud.label.font = font(15);
    _hud.userInteractionEnabled= NO;

    _hud.mode = MBProgressHUDModeIndeterminate;

    NSString *url = [NSString stringWithFormat:@"api/consumer/v1/chart/?chart_type=%@&item_id=%@&live_id=%@",@(type),_model[@"good"][@"item_id"],_model[@"id"]];
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
        [_hud hideAnimated:YES];
    } error:^(id data) {
        [_hud hideAnimated:YES];
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
    
    UIView *lines = [self viewWithTag:sender.tag+1000];
                  lines.hidden = NO;
    type = sender.tag -999;
    [self getImgUrl:sender.tag-999];
}
@end
