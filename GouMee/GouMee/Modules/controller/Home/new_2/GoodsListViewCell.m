//
//  GoodsListViewCell.m
//  KuRanApp
//
//  Created by 白冰 on 2020/2/10.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GoodsListViewCell.h"
#import "AppDelegate.h"
@implementation GoodsListViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = COLOR_STR(0xe2e2e2).CGColor;

    self.goodsIcon = [UIImageView new];
    [self addSubview:self.goodsIcon];
    [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(85));

    }];
    self.goodsIcon.image = [UIImage imageNamed:@"goods_bg"];

    self.currentPrice = [UILabel new];
    [self addSubview:self.currentPrice];
    self.currentPrice.font = font(12);
    self.currentPrice.textColor = COLOR_STR(0x333333);
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsIcon.mas_bottom).offset(scale(5));
        make.left.mas_equalTo(self.goodsIcon.mas_left).offset(scale(5));
        make.right.mas_equalTo(self.goodsIcon.mas_right).offset(-scale(5));
    }];
    NSString *str = @"券后¥125.00";

    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 需要改变的区间(第一个参数，从第几位起，长度)
    NSRange range = NSMakeRange(0, 2);
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:font(12) range:range];
    [noteStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:range];

    // 为label添加Attributed
    // 为label添加Attributed
    [self.currentPrice setAttributedText:noteStr];

    UIView *line = [UIView new];
    [self addSubview:line];
    line.backgroundColor = COLOR_STR(0xf9f9f9);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.top.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(5));
    }];



    self.moneyLab = [UIButton new];
    [self addSubview:self.moneyLab];
    [self.moneyLab setTitleColor:ThemeRedColor forState:UIControlStateNormal];;
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(scale(-5));
        make.left.mas_equalTo(self.goodsIcon.mas_left).offset(scale(5));
        make.right.mas_equalTo(self.goodsIcon.mas_right).offset(-scale(5));
        make.height.mas_equalTo(scale(16));

    }];
    self.moneyLab.titleLabel.font = font(12);
    [self.moneyLab setTitle:@"赚¥8.99" forState:UIControlStateNormal];
//    [self.moneyLab setImage:[UIImage imageNamed:@"moneys"] forState:UIControlStateNormal];


}
-(void)setModel:(NSDictionary *)model
{
    _model = model;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   if (isNotNull(model[@"white_image"])) {
            [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
       }
       else
       {
            [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
       }
    NSDictionary *fuli = model[@"kurangoods"];



    

    NSString *str;

           if (app.auditStatus == 0) {
                 if ([fuli[@"data_source"] integerValue] == 1) {
                 str = [NSString stringWithFormat:@"券后¥%@",[Network removeSuffix:_model[@"final_price"] ]];
                     NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
                     // 需要改变的区间(第一个参数，从第几位起，长度)
                     NSRange range = NSMakeRange(0, 2);
                     // 改变字体大小及类型
                     [noteStr addAttribute:NSFontAttributeName value:font(12) range:range];
                     [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(2, 1)];
                     [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(1, 1)];
                     [noteStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:range];

                     NSRange range1 = NSMakeRange(3, str.length-3);
                     // 改变字体大小及类型
                     [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(12)) range:range1];

                     // 为label添加Attributed
                     // 为label添加Attributed
                     [self.currentPrice setAttributedText:noteStr];
                 }
               else
               {
 str = [NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:fuli[@"kuran_price"]]];
                   NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
                   // 需要改变的区间(第一个参数，从第几位起，长度)
                   NSRange range = NSMakeRange(0, 2);
                   // 改变字体大小及类型
                   [noteStr addAttribute:NSFontAttributeName value:font(12) range:range];
                   [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(2, 1)];
                   [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(1, 1)];
                   [noteStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:range];

                   NSRange range1 = NSMakeRange(4, str.length-4);
                   // 改变字体大小及类型
                   [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(12)) range:range1];

                   // 为label添加Attributed
                   // 为label添加Attributed
                   [self.currentPrice setAttributedText:noteStr];
               }
           }
           else
           {
                if ([fuli[@"data_source"] integerValue] == 1) {
                 str = [NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:_model[@"zk_final_price"]]];
                    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
                    // 需要改变的区间(第一个参数，从第几位起，长度)
                    NSRange range = NSMakeRange(0, 2);
                    // 改变字体大小及类型
                    [noteStr addAttribute:NSFontAttributeName value:font(12) range:range];
                    [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(2, 1)];
                    [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(1, 1)];
                    [noteStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:range];

                    NSRange range1 = NSMakeRange(3, str.length-3);
                    // 改变字体大小及类型
                    [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(12)) range:range1];

                    // 为label添加Attributed
                    // 为label添加Attributed
                    [self.currentPrice setAttributedText:noteStr];
                }
               else
               {
 str = [NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:fuli[@"kuran_price"]]];
                   NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
                   // 需要改变的区间(第一个参数，从第几位起，长度)
                   NSRange range = NSMakeRange(0, 2);
                   // 改变字体大小及类型
                   [noteStr addAttribute:NSFontAttributeName value:font(12) range:range];
                   [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(2, 1)];
                   [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(1, 1)];
                   [noteStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:range];

                   NSRange range1 = NSMakeRange(4, str.length-4);
                   // 改变字体大小及类型
                   [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(12)) range:range1];

                   // 为label添加Attributed
                   // 为label添加Attributed
                   [self.currentPrice setAttributedText:noteStr];
               }
           }



    if (app.auditStatus == 0) {
     if ([fuli[@"data_source"] integerValue] == 1) {
    NSString *xxx = [NSString stringWithFormat:@"赚¥%@",[Network removeSuffix:_model[@"commission"]]];
    NSMutableAttributedString *notexxx = [[NSMutableAttributedString alloc] initWithString:xxx];
    NSRange range2 = NSMakeRange(1, xxx.length-1);
    // 改变字体大小及类型
    [notexxx addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(1, 1)];
    [notexxx addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
    [notexxx addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(12)) range:range2];
     [notexxx addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(12)) range:NSMakeRange(0, 2)];
    [notexxx addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(0, 2)];
    [notexxx addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:range2];
    [_moneyLab setAttributedTitle:notexxx forState:UIControlStateNormal];
     }
        else
        {
            if ([fuli[@"commission"] floatValue] > 0) {

            NSString *xxx = [NSString stringWithFormat:@"赚¥%@",[Network removeSuffix:fuli[@"commission"]]];
            NSMutableAttributedString *notexxx = [[NSMutableAttributedString alloc] initWithString:xxx];
            NSRange range2 = NSMakeRange(1, xxx.length-1);
            // 改变字体大小及类型
            [notexxx addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(1, 1)];
            [notexxx addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
            [notexxx addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(12)) range:range2];
            [notexxx addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(12)) range:NSMakeRange(0, 2)];
            [notexxx addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(0, 2)];
            [notexxx addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:range2];
            [_moneyLab setAttributedTitle:notexxx forState:UIControlStateNormal];
            }
            else
            {
                NSString *xxx = [NSString stringWithFormat:@"赚¥%@",[Network removeSuffix:_model[@"commission"]]];
                NSMutableAttributedString *notexxx = [[NSMutableAttributedString alloc] initWithString:xxx];
                NSRange range2 = NSMakeRange(1, xxx.length-1);
                // 改变字体大小及类型
                [notexxx addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(1, 1)];
                [notexxx addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                [notexxx addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Medium", scale(12)) range:range2];
                [notexxx addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(12)) range:NSMakeRange(0, 2)];
                [notexxx addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(0, 2)];
                [notexxx addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:range2];
                [_moneyLab setAttributedTitle:notexxx forState:UIControlStateNormal];
            }



        }
    }
    else
    {
        [_moneyLab setTitle:@"立即购买" forState:UIControlStateNormal];
    }
//     [_moneyLab setTitle:[NSString stringWithFormat:@"赚¥%@",_model[@"commission"]] forState:UIControlStateNormal];



}
@end
