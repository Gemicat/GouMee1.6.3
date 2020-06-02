//
//  CouspondViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "CouspondViewCell.h"
#import "AppDelegate.h"
@interface CouspondViewCell ()
{
    UIImageView *couponIcon;
    UIImageView *moneyIcon;
    UILabel *moneyRate;
    UILabel *moneyNum;
    UIImageView *commissionIcon;
       UILabel *commissionLab;
    CGFloat cellHeight;
}
@property (nonatomic, strong)UILabel *couponMoney;
@property (nonatomic, strong)UILabel *couponTime;

@end
@implementation CouspondViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {
    self.backgroundColor = COLOR_STR(0xffffff);
    
    
//    moneyRate = [UILabel new];
//    [self.contentView addSubview:moneyRate];
//    [moneyRate mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mas_top).offset(5);
//        make.left.mas_equalTo(self.mas_left).offset(scale(30));
//        make.height.mas_equalTo(scale(22));
//    }];
//    moneyRate.textColor = COLOR_STR(0xE3375D);
//    moneyRate.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//
//     moneyNum = [UILabel new];
//    [self.contentView addSubview:moneyNum];
//    [moneyNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(moneyRate.mas_centerY).offset(0);
//        make.left.mas_equalTo(moneyRate.mas_right).offset(0);
//    }];
//    moneyNum.textColor = COLOR_STR(0x999999);
//    moneyNum.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//
//    commissionLab = [UILabel new];
//          [self.contentView addSubview:commissionLab];
//          [commissionLab mas_makeConstraints:^(MASConstraintMaker *make) {
//              make.top.mas_equalTo(moneyRate.mas_bottom).offset(0);
//              make.left.mas_equalTo(self.mas_left).offset(scale(30));
//              make.height.mas_equalTo(scale(22));
//          }];
//          commissionLab.textColor = COLOR_STR(0x999999);
//          commissionLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//
//    self.couponMoney = [UILabel new];
//    [self.contentView addSubview:self.couponMoney];
//    [self.couponMoney mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(commissionLab.mas_bottom).offset(0);
//        make.left.mas_equalTo(self.mas_left).offset(scale(30));
//        make.height.mas_equalTo(scale(22));
//    }];
//    self.couponMoney.textColor = COLOR_STR(0xE3375D);
//    self.couponMoney.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//
//    self.couponTime = [UILabel new];
//       [self.contentView addSubview:self.couponTime];
//       [self.couponTime mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.centerY.mas_equalTo(self.couponMoney.mas_centerY).offset(0);
//           make.left.mas_equalTo(self.couponMoney.mas_right).offset(0);
//       }];
//       self.couponTime.textColor = COLOR_STR(0x999999);
//       self.couponTime.font = [UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)];
//
//
//    couponIcon = [UIImageView new];
//       [self.contentView addSubview:couponIcon];
//       moneyIcon = [UIImageView new];
//        moneyIcon.image = [UIImage imageNamed:@"money_bg"];
//       [self.contentView addSubview:moneyIcon];
//    commissionIcon = [UIImageView new];
//          commissionIcon.image = [UIImage imageNamed:@"bao_icon"];
//         [self.contentView addSubview:commissionIcon];
//
//
//       [moneyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.centerY.mas_equalTo(moneyRate.mas_centerY).offset(0);
//           make.left.mas_equalTo(self.mas_left).offset(scale(15));
//           make.width.mas_equalTo(12);
//           make.height.mas_equalTo(12);
//       }];
//       [couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//              make.centerY.mas_equalTo(_couponMoney.mas_centerY).offset(0);
//             make.left.mas_equalTo(self.mas_left).offset(scale(15));
//              make.width.mas_equalTo(12);
//              make.height.mas_equalTo(9);
//          }];
//    [commissionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(commissionLab.mas_centerY).offset(0);
//        make.left.mas_equalTo(self.mas_left).offset(scale(15));
//        make.width.mas_equalTo(12);
//        make.height.mas_equalTo(9);
//             }];
//
//    UIView *line = [UIView new];
//    [self.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
//        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
//        make.height.mas_equalTo(10);
//    }];
//    line.backgroundColor = COLOR_STR(0xf2f2f2);



    self.titleLab = [UIButton new];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(scale(13));
        make.left.mas_equalTo(self.mas_left).offset(scale(12));
    }];
    self.titleLab.titleLabel.font = font1(@"PingFangSC-Semibold", scale(16));


    self.ruleBtn = [UIButton new];
    [self addSubview:self.ruleBtn];
    [self.ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY).offset(scale(0));
        make.right.mas_equalTo(self.mas_right).offset(scale(-12));
    }];
    self.ruleBtn.titleLabel.font = font(12);

    [self.ruleBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];

    [self.ruleBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    self.titleLab.adjustsImageWhenDisabled=NO;

    self.titleLab.adjustsImageWhenHighlighted=NO;
    self.ruleBtn.adjustsImageWhenDisabled=NO;

    self.ruleBtn.adjustsImageWhenHighlighted=NO;

  
}
- (NSString *)getTimeFromTimestamp:(NSInteger )times{

    //将对象类型的时间转换为NSDate类型

    double time =(double)times;

    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];

    //设置时间格式

    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"MM.dd"];

    //将时间转换为字符串

    NSString *timeStr=[formatter stringFromDate:myDate];

    return timeStr;

}

-(void)setModel:(NSDictionary *)model
{
    NSDictionary *fuli = model[@"kurangoods"];

        if ([fuli[@"data_source"] integerValue] == 2) {
    [self.titleLab setTitle:@"库然专享福利" forState:UIControlStateNormal];
     [self.ruleBtn setTitle:@"专享福利说明" forState:UIControlStateNormal];
    [self.titleLab setTitleColor:ThemeRedColor forState:UIControlStateNormal];
             [self.ruleBtn setImage:[UIImage imageNamed:@"rule_nn"] forState:UIControlStateNormal];
    [self.titleLab setImage:[UIImage imageNamed:@"zhuanxiang"] forState:UIControlStateNormal];
             [self.ruleBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:0];
             [self.titleLab layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:5];
        }
    else
    {
        [self.titleLab setTitle:@"" forState:UIControlStateNormal];
        [self.ruleBtn setTitle:@"" forState:UIControlStateNormal];
        [self.titleLab setTitleColor:ThemeRedColor forState:UIControlStateNormal];
        [self.titleLab setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
         [self.ruleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}
-(CGFloat)getHeight
{
    return cellHeight;
}
@end
