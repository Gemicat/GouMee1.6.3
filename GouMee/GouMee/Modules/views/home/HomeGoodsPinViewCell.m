//
//  HomeGoodsPinViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/5/12.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "HomeGoodsPinViewCell.h"
#import "UIView+Gradient.h"
#import "AppDelegate.h"
@implementation HomeGoodsPinViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{

    UIView *backView  = [UIView new];
    [self addSubview:backView];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(10));
        make.left.mas_equalTo(scale(0));
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-scale(0));
    }];

    UIView *line = [UIView new];
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(-scale(42));
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(backView.mas_left).offset(scale(10));
    }];
    line.backgroundColor = COLOR_STR1(0, 0, 0, 0.08);



    self.goodIcon = [UIImageView new];
    [backView addSubview:self.goodIcon];
    [self.goodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(10));
        make.left.mas_equalTo(scale(10));
        make.bottom.mas_equalTo(line.mas_top).offset(scale(-15));
        make.width.mas_equalTo(self.goodIcon.mas_height);
    }];

    self.FreeIcon = [UIImageView new];
    [backView addSubview:self.FreeIcon];
    [self.FreeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodIcon.mas_top).offset(-2);
        make.left.mas_equalTo(self.goodIcon.mas_left).offset(scale(4));
    }];
    self.FreeIcon.hidden = YES;
    self.FreeIcon.image = [UIImage imageNamed:@"jiyang_ss"];
    self.goodIcon.layer.cornerRadius =4;
    self.goodIcon.layer.masksToBounds = YES;
    self.goodIcon.image = [UIImage imageNamed:@"goods"];
    self.goodsName = [UILabel new];
    self.goodsName.font = font(14);
    self.goodsName.textColor = COLOR_STR(0x333333);
    self.goodsName.numberOfLines = 2;
    self.goodsName.lineBreakMode = NSLineBreakByWordWrapping;
    [backView addSubview:self.goodsName];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.goodIcon.mas_top).offset(scale(4));
        make.left.mas_equalTo(self.goodIcon.mas_right).offset(scale(10));
        make.right.mas_equalTo(backView.mas_right).offset(-scale(10));
    }];

    _lineView = [UIView new];
    [backView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsName.mas_bottom).offset(scale(5));
        make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
        make.right.mas_equalTo(self.goodsName.mas_right).offset(0);
        make.height.mas_equalTo(scale(43));
    }];
    _lineView.backgroundColor = COLOR_STR(0xFFF1EE);

    _commissionLab = [UILabel new];
    [_lineView addSubview:_commissionLab];
    [_commissionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(_lineView.mas_left).offset(scale(30));
        make.right.mas_equalTo(_lineView.mas_right).offset(scale(-10));
        make.bottom.mas_equalTo(_lineView.mas_centerY).offset(0);
    }];
    _commissionLab.font = font(12);
    _commissionLab.textColor = COLOR_STR(0x999999);
    _commissionLab.text = @"2.29-3.7佣金≥36%";

    _commissionIcon = [UIImageView new];
    [_lineView addSubview:_commissionIcon];
    [_commissionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commissionLab.mas_centerY).offset(0);
        make.right.mas_equalTo(_commissionLab.mas_left).offset(scale(-8));
        make.height.width.mas_equalTo(scale(12));
    }];
    _commissionIcon.image = [UIImage imageNamed:@"num_bg"];



    self.saleNum = [UILabel new];
    [_lineView addSubview:self.saleNum];
    [self.saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(_lineView.mas_left).offset(scale(30));
        make.right.mas_equalTo(_lineView.mas_right).offset(scale(-10));
        make.top.mas_equalTo(_commissionLab.mas_bottom).offset(0);
    }];
    self.saleNum.textColor = COLOR_STR(0x999999);
    self.saleNum.font = font(12);
    self.saleNum.text = @"月销量6.6万件";

    _leftIcon = [UIImageView new];
    [_lineView addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_saleNum.mas_centerY).offset(0);
        make.right.mas_equalTo(_saleNum.mas_left).offset(scale(-8));
        make.height.width.mas_equalTo(scale(12));
    }];
    _leftIcon.image = [UIImage imageNamed:@"num_bg"];




    self.currentPrice = [UILabel new];
    [backView addSubview:self.currentPrice];
    self.currentPrice.textColor = ThemeRedColor;
    self.currentPrice.font = font(21);
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
        make.top.mas_equalTo(_lineView.mas_bottom).offset(scale(3));
    }];
    NSString *str = @"¥125.00";
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 需要改变的区间(第一个参数，从第几位起，长度)
    NSRange range = NSMakeRange(0, 1);
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:font(13) range:range];

    self.oldPrice = [UILabel new];
    [backView addSubview:self.oldPrice];
    self.oldPrice.textColor = COLOR_STR(0xCCCCCC);
    self.oldPrice.font = font(12);
    [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.currentPrice.mas_right).offset(scale(5));
        make.bottom.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(-5));
    }];

    self.couponsView = [UIView new];
    [backView addSubview:self.couponsView];
    self.couponsView.backgroundColor = COLOR_STR(0xFEF3F5);
    self.couponsView.layer.cornerRadius = 4;
    self.couponsView.layer.borderColor =  ThemeRedColor.CGColor;
    self.couponsView.layer.borderWidth = 1;
    [self.couponsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(2));
        make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
        make.height.mas_equalTo(scale(19));

    }];

    self.markLab = [UILabel new];
    [self.couponsView addSubview:self.markLab];
    self.couponsLab = [UILabel new];
    [self.couponsView addSubview:self.couponsLab];
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.couponsView.mas_centerY).offset(scale(0));
        make.left.mas_equalTo(self.couponsView.mas_left).offset(0);
        make.width.mas_equalTo(scale(25));
        make.height.mas_equalTo(scale(19));
    }];
    UIView *lineH = [UIView new];
    [self.couponsView addSubview:lineH];
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.markLab.mas_right).offset(0);
        make.height.mas_equalTo(self.couponsView.mas_height);
        make.width.mas_equalTo(1);
    }];
    lineH.backgroundColor = ThemeRedColor;

    self.markLab.text = @"券";
    self.markLab.font = font(12);
    self.markLab.textColor = ThemeRedColor;
    self.markLab.textAlignment = NSTextAlignmentCenter;

    [self.couponsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.markLab.mas_centerY).offset(0);
        make.left.mas_equalTo(self.markLab.mas_right).offset(0);
    }];

    self.couponsLab.text = @"6 元";
    self.couponsLab.textColor = ThemeRedColor;
    self.couponsLab.font = font(12);
    [self.couponsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.markLab.mas_left).offset(0);
        make.right.mas_equalTo(self.couponsLab.mas_right).offset(0);
    }];

    self.rating = [UILabel new];
    [backView addSubview:self.rating];
    self.rating.textAlignment = NSTextAlignmentCenter;
    [self.rating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(0);
        make.left.mas_equalTo(line.mas_left).offset(0);
        make.right.mas_equalTo(line.mas_centerX).offset(0);
    }];
    self.rating.text = @"佣金率 24%";
    self.rating.textColor = COLOR_STR(0x333333);
    self.rating.font = font(14);

    self.money = [UILabel new];
    [backView addSubview:self.money];
    self.money.textAlignment = NSTextAlignmentCenter;
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(0);
        make.left.mas_equalTo(line.mas_centerX).offset(0);
        make.right.mas_equalTo(line.mas_right).offset(0);
    }];
    self.money.text = @"佣金率 24%";
    self.money.textColor = COLOR_STR(0x333333);
    self.money.font = font(14);



}
-(void)addModel:(NSDictionary *)model
{
    NSDictionary *fuli = model[@"kurangoods"];
    NSDictionary *pumodel;
    if (isNotNull(model[@"good"])) {
        pumodel = model[@"good"];
    }
    else
    {
        pumodel = model;
    }
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (isNotNull(pumodel[@"white_image"])) {
        [self.goodIcon sd_setImageWithURL:[NSURL URLWithString:pumodel[@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }
    else
    {
        [self.goodIcon sd_setImageWithURL:[NSURL URLWithString:pumodel[@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }


    NSString *titleString =  [NSString stringWithFormat:@"%@",pumodel[@"title"]];

    if (isNotNull(pumodel[@"lock_rate"]) && app.auditStatus == 0) {
        NSString *rateStr = [Network removeSuffix:@([pumodel[@"lock_rate"] floatValue]/100)];
        NSString *start_time = [self getTimeFromTimestamp:[pumodel[@"lock_rate_start_time"] integerValue]];
        NSString *end_time = [self getTimeFromTimestamp:[pumodel[@"lock_rate_end_time"] integerValue]];
        _commissionLab.text =[NSString stringWithFormat:@"%@-%@佣金≥%@%%",start_time,end_time,rateStr];
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(scale(43));
        }];
        [_commissionLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_lineView.mas_centerY).offset(0);
        }];
        [_saleNum mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_commissionLab.mas_bottom).offset(0);
        }];
        [_commissionIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(scale(12));
        }];

    }
    else
    {
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(scale(34));
        }];
        [_commissionLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_lineView.mas_top).offset(0);
        }];
        [_commissionIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [_saleNum mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_commissionLab.mas_bottom).offset(0);
            make.bottom.mas_equalTo(_lineView.mas_bottom).offset(0);
        }];
        _commissionLab.text = @"";
    }

    if ( app.auditStatus == 0) {
        if ([fuli[@"data_source"] integerValue] == 1) {
            if (isNotNull(pumodel[@"coupon_amount"])) {
                self.markLab.hidden = NO;
                self.couponsLab.hidden = NO;
                self.oldPrice.hidden = NO;
                self.couponsView.hidden = NO;
                self.couponsLab.text = [NSString stringWithFormat:@"  %@元 ", [Network removeSuffix:pumodel[@"coupon_amount"] ]];
            }
            else
            {
                self.markLab.hidden = YES;
                self.couponsLab.hidden = YES;
                self.oldPrice.hidden = YES;
                self.couponsView.hidden = YES;
            }

        }
        else
        {
            if (isNotNull(fuli[@"coupon_amount"])) {
                self.markLab.hidden = NO;
                self.couponsLab.hidden = NO;
                self.couponsLab.text = [NSString stringWithFormat:@"  %@元 ", [Network removeSuffix:fuli[@"coupon_amount"] ]];


                self.couponsView.hidden = NO;
            } else
            {
                self.markLab.hidden = YES;
                self.couponsLab.hidden = YES;

                self.couponsView.hidden = YES;

            }



        }


    }
    else
    {
        self.markLab.hidden = YES;
        self.couponsLab.hidden = YES;
        [self.couponsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(0);
        }];
    }


    if ([fuli[@"data_source"] integerValue] == 1) {
        NSString *afterPrice = [NSString stringWithFormat:@"¥%@",[Network removeSuffix:pumodel[@"final_price"] ]];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:afterPrice];
        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(13)] range:NSMakeRange(0, 1)];
        [str1 addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(21)] range:NSMakeRange(1, afterPrice.length-1)];
        self.currentPrice.attributedText = str1;

        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:pumodel[@"zk_final_price"] ]]];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
        self.oldPrice.attributedText = str;

    }
    else
    {
        NSString *afterPrice = [NSString stringWithFormat:@"¥%@",[Network removeSuffix:fuli[@"kuran_price"]]];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:afterPrice];
        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(13)] range:NSMakeRange(0, 1)];
        [str1 addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(21)] range:NSMakeRange(1, afterPrice.length-1)];
        self.currentPrice.attributedText = str1;

        NSNumber *a=[NSNumber numberWithFloat:[fuli[@"kuran_price"] floatValue]];
        NSNumber *b=[NSNumber numberWithFloat:[pumodel[@"zk_final_price"] floatValue]];
        if ([a compare:b]==NSOrderedAscending) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:pumodel[@"zk_final_price"]]]];
            [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
            self.oldPrice.attributedText = str;
        }
        else
        {
            self.oldPrice.text = @"";
        }




    }
    if ([pumodel[@"volume"] integerValue] < 10000) {
        self.saleNum.text = [NSString stringWithFormat:@"月销量%@件",pumodel[@"volume"]];
    }
    else
    {
        self.saleNum.text = [NSString stringWithFormat:@"月销量%@万件",[Network notRounding:[pumodel[@"volume"] floatValue] afterPoint:2]];
    }



    self.goodsName.text = titleString;
    if (app.auditStatus == 0) {
        if ([fuli[@"data_source"] integerValue] == 1) {
            self.money.text = [NSString stringWithFormat:@"推广赚¥%@",[Network removeSuffix:pumodel[@"commission"] ]];
            NSString *rates = [NSString stringWithFormat:@"佣金率 %@%%",[Network removeSuffix:@([pumodel[@"commission_rate"] floatValue]/100)]];
            self.rating.text = rates;
        }
        else
        {
            if ([fuli[@"commission"] floatValue] > 0) {
                self.money.text = [NSString stringWithFormat:@"推广赚¥%@",[Network removeSuffix:fuli[@"commission"] ]];
                NSString *rates = [NSString stringWithFormat:@"佣金率 %@%%",[Network removeSuffix:@([fuli[@"commission_rate"] floatValue]/100)]];
                self.rating.text = rates;
            }
            else
            {
                self.money.text = [NSString stringWithFormat:@"推广赚¥%@",[Network removeSuffix:pumodel[@"commission"] ]];
                NSString *rates = [NSString stringWithFormat:@"佣金率 %@%%",[Network removeSuffix:@([pumodel[@"commission_rate"] floatValue]/100)]];
                self.rating.text = rates;
            }


        }
    }
    else
    {
        self.money.text = @"查看详情";

        self.rating.text = @"";
    }



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

//注意 ：创建这个Label的时候，frame，font，cornerRadius要设置成所生成的图片的3倍，也就是说要生成一个三倍图，否则生成的图片会虚，同学们可以试一试。

//view转成image
- (UIImage*) imageWithUIView:(UIView*) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
@end
