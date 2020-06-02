//
//  DY_SheetView.m
//  GouMee
//
//  Created by 白冰 on 2019/12/19.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "DY_SheetView.h"

@implementation DY_SheetView

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
    
    UIView *backView = [UIView new];
    [self addSubview:backView];
    backView.layer.cornerRadius = 8;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(scaleH(160));
               make.height.mas_equalTo(200);
               make.left.mas_equalTo(80);
               make.centerX.mas_equalTo(0);
    }];
    UILabel *titleLab = [UILabel new];
    [backView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
    titleLab.text = @"上架商品到抖音";
    titleLab.font = font1(@"PingFangSC-Semibold", scale(15));
    titleLab.textColor = COLOR_STR(0x333333);
     UIButton *closeBtn = [UIButton new];
        [backView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.width.mas_equalTo(30);
        }];
        [closeBtn setImage:[UIImage imageNamed:@"sheet_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeclick) forControlEvents:UIControlEventTouchUpInside];

    UILabel *tip1 = [UILabel new];
    [backView addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).offset(8);
        make.centerX.mas_equalTo(0);
    }];
    tip1.numberOfLines = 0;
    NSString *str = @"1. 请确保已经在抖音橱窗绑定库然\n分配给您的淘宝PID，否则无法\n正常获取佣金";
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
           paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
//           paraStyle.alignment = NSTextAlignmentLeft;
           paraStyle.lineSpacing = 5; //设置行间距
           paraStyle.hyphenationFactor = 1.0;
           paraStyle.firstLineHeadIndent = 0.0;
           paraStyle.paragraphSpacingBefore = 0.0;
           paraStyle.headIndent = 0;
           paraStyle.tailIndent = 0;
           //设置字间距 NSKernAttributeName:@1.5f
           NSDictionary *dic = @{NSFontAttributeName:font1(@"PingFangSC-Semibold", scale(15)), NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                                 };
           NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:dic];
    [attributeStr addAttributes:@{NSFontAttributeName:font1(@"PingFangSC-Semibold", scale(15))} range:NSMakeRange(0, 1)];//NSMakeRange(0, 3)
     [attributeStr addAttributes:@{NSFontAttributeName:font1(@"PingFangSC-Semibold", scale(12))} range:NSMakeRange(1, str.length-1)];
    //设置刘德华三个字的的字体颜色为红色
    [attributeStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, str.length-10)];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0xDF3811) range:NSMakeRange(str.length-11, 11)];
    tip1.attributedText = attributeStr;

    UIButton *pidBtn = [UIButton new];
    [backView addSubview:pidBtn];
    [pidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tip1.mas_bottom).offset(5);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(tip1.mas_left).offset(0);
        make.height.mas_equalTo(34);
    }];
    pidBtn.layer.cornerRadius = 5;
    pidBtn.layer.masksToBounds = YES;
    pidBtn.backgroundColor = COLOR_STR(0xE4EEFE);
    [pidBtn setTitle:@"如何绑定淘宝PID?" forState:UIControlStateNormal];
    [pidBtn setTitleColor:COLOR_STR(0x6269F8) forState:UIControlStateNormal];
    pidBtn.titleLabel.font = font1(@"PingFangSC-Semibold", scale(11));
    [pidBtn addTarget:self action:@selector(pid) forControlEvents:UIControlEventTouchUpInside];

    UILabel *tip2 = [UILabel new];
    [backView addSubview:tip2];
    [tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tip1.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(pidBtn.mas_bottom).offset(10);
    }];
    tip2.numberOfLines = 0;
    NSString *str1 = @"2. 在本页面复制淘口令后去抖音\n橱窗上架商品";
           NSMutableAttributedString *attributeStr1 = [[NSMutableAttributedString alloc] initWithString:str1 attributes:dic];
    [attributeStr1 addAttributes:@{NSFontAttributeName:font1(@"PingFangSC-Semibold", scale(15))} range:NSMakeRange(0, 1)];//NSMakeRange(0, 3)
     [attributeStr1 addAttributes:@{NSFontAttributeName:font1(@"PingFangSC-Semibold", scale(12))} range:NSMakeRange(1, str1.length-1)];
    //设置刘德华三个字的的字体颜色为红色
    [attributeStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, str1.length)];
    tip2.attributedText = attributeStr1;

    UIButton *dyBtn = [UIButton new];
    [backView addSubview:dyBtn];
    [dyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tip2.mas_bottom).offset(5);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(tip1.mas_left).offset(0);
        make.height.mas_equalTo(34);
    }];
    dyBtn.layer.cornerRadius = 5;
    dyBtn.layer.masksToBounds = YES;
    dyBtn.backgroundColor = COLOR_STR(0xE4EEFE);
    [dyBtn setTitle:@"如何上架商品?" forState:UIControlStateNormal];
    [dyBtn setTitleColor:COLOR_STR(0x6269F8) forState:UIControlStateNormal];
    dyBtn.titleLabel.font = font1(@"PingFangSC-Semibold", scale(11));
    [dyBtn addTarget:self action:@selector(dy) forControlEvents:UIControlEventTouchUpInside];

    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(scaleH(160));
        make.left.mas_equalTo(tip1.mas_left).offset(-20);
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(dyBtn.mas_bottom).offset(15);
    }];

//    UIView *circleView = [UIView new];
//    [backView addSubview:circleView];
//    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(titleLab.mas_left).offset(6);
//        make.centerY.mas_equalTo(titleLab.mas_centerY).offset(-6);
//        make.height.width.mas_equalTo(18);
//    }];
//    circleView.layer.cornerRadius = 9;
//    circleView.layer.masksToBounds = YES;
//    circleView.backgroundColor = COLOR_STR(0xEDEF24);
    [backView bringSubviewToFront:titleLab];

    
}
-(void)dy
{
    if (self.taobaoclick) {
        self.taobaoclick();
    }
}
-(void)pid
{
    if (self.pidclick) {
        self.pidclick();
    }
}
-(void)closeclick
{
    [self removeFromSuperview];
    if (self.click) {
        self.click();
    }
}
-(NSAttributedString *)setSpace:(CGFloat)space withFont:(UIFont*)font withstr:(NSString *)context {
    
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = space; //设置行间距
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        //设置字间距 NSKernAttributeName:@1.5f
        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                              };
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:context attributes:dic];
    return attributeStr;
        
}

@end
