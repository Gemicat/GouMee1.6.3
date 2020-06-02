//
//  GoodsFuliListViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/23.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GoodsFuliListViewCell.h"

@implementation GoodsFuliListViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {

    self.titleLab = [UILabel new];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(scale(12));
        make.left.mas_equalTo(self.mas_left).offset(scale(12));
        make.width.mas_equalTo(scale(60));
    }];
    self.titleLab.font = font1(@"PingFangSC-Regular", scale(13));
    self.titleLab.textColor = COLOR_STR(0x999999);
    self.context = [UILabel new];
    [self addSubview:self.context];
    self.context.numberOfLines = 0;
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(scale(12));
        make.left.mas_equalTo(self.titleLab.mas_right).offset(scale(5));
        make.right.mas_equalTo(scale(-12));
    }];
    self.context.font = font1(@"PingFangSC-Regular", scale(12));
    self.context.textColor = COLOR_STR(0x999999);


    self.contexts = [UILabel new];
    [self addSubview:self.contexts];
    [self.contexts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(scale(13));
        make.left.mas_equalTo(self.mas_left).offset(scale(28));
        make.right.mas_equalTo(scale(-12));
    }];

    self.leftIcon = [UIImageView new];
    [self addSubview:self.leftIcon];
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contexts.mas_centerY).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(scale(12));
        make.width.height.mas_equalTo(scale(12));
    }];



    self.contexts.font = font1(@"PingFangSC-Regular", scale(12));
    self.contexts.textColor = COLOR_STR(0x999999);

    self.context.hidden = YES;
    self.contexts.hidden = YES;
    self.leftIcon.hidden = YES;
    self.titleLab.hidden = YES;
}
-(void)addModel:(NSDictionary *)model index:(NSInteger)index
{
    self.context.hidden = NO;
    self.contexts.hidden = YES;
    self.leftIcon.hidden = YES;
    self.titleLab.hidden = NO;
    self.context.text = @"";
    self.titleLab.text = @"";
    self.contexts.text = @"";
    self.leftIcon.image = [UIImage new];

    NSDictionary *fuli = model[@"kurangoods"];
    if (index == 2) {
        self.titleLab.text = @"佣金";

        if ([fuli[@"data_source"] integerValue] == 1) {
            NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"commission_rate"] floatValue]/100)]]];
            NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:model[@"commission"]]];
            self.context.text=[NSString stringWithFormat: @"%@（预计¥%@）",div_Money,aa];
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
            [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, div_Money.length)];
            _context.attributedText = attriStr;
        }
        else
        {
            if ([fuli[@"commission"] floatValue] > 0) {

             self.titleLab.text = @"库然高佣";
            NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([fuli[@"commission_rate"] floatValue]/100)]]];
            NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:fuli[@"commission"]]];

            self.context.text=[NSString stringWithFormat: @"%@（预计¥%@）",div_Money,aa];
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
            [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, div_Money.length)];
            _context.attributedText = attriStr;
            }
            else
            {
                self.titleLab.text = @"佣金";
                NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"commission_rate"] floatValue]/100)]]];
                NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:model[@"commission"]]];

                self.context.text=[NSString stringWithFormat: @"%@（预计¥%@）",div_Money,aa];
                NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
                [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, div_Money.length)];
                _context.attributedText = attriStr;
            }
        }

    }
    if (index == 3) {
        if (isNotNull(model[@"lock_rate"])) {
            self.titleLab.text = @"佣金保障";

            NSString *rateStr = [Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"lock_rate"] floatValue]/100)]];
            NSString *start_time = [self getTimeFromTimestamp:[model[@"lock_rate_start_time"] integerValue]];
            NSString *end_time = [self getTimeFromTimestamp:[model[@"lock_rate_end_time"] integerValue]];
            _context.text =[NSString stringWithFormat:@"佣金≥%@%%（%@-%@）",rateStr,start_time,end_time];

        }
        else
        {
            _context.text = @"";
            _context.text = @"";

        }
    }
    if (index == 4) {




            _titleLab.text = @"优惠券";
            if ([fuli[@"data_source"] integerValue] == 1) {
                  if ([model[@"coupon_remain_count"] intValue] > 0) {
                NSString *num = [Network removeSuffix:model[@"good"][@"coupon_amount"]];
                NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"good"][@"coupon_end_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
                NSString *time1 = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"good"][@"coupon_start_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
                _context.text =[NSString stringWithFormat:@"%@元（%@-%@）",num,time1,time] ;
                NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
                [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, num.length+1)];
                _context.attributedText = attriStr;
                  }
                else
                {
                    _context.text = @"";
                    _titleLab.text = @"";
                }
            }
            else
            {
                if (isNotNull(fuli[@"coupon_amount"])) {

                NSString *num = [Network removeSuffix:fuli[@"coupon_amount"]];
                if (isNotNull(fuli[@"coupon_end_time"]) &&isNotNull(fuli[@"coupon_start_time"])) {

                    NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:fuli[@"coupon_end_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
                    NSString *time1 = [Network timestampSwitchTime:[Network timeSwitchTimestamp:fuli[@"coupon_start_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
                    _context.text =[NSString stringWithFormat:@"%@元（%@-%@）",num,time1,time] ;
                }
                else
                {

                    _context.text =[NSString stringWithFormat:@"%@元",num] ;
                }
                NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
                [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, num.length+1)];
                _context.attributedText = attriStr;

            }
            else
            {
                _context.text = @"";
                _titleLab.text = @"";

                
            }
            }



    }
    if (index == 5) {

        if (isNotNull(fuli[@"reduction_amount"])) {
            self.titleLab.text = @"拍下立减";
            self.context.text = [NSString stringWithFormat:@"立减%@元",[Network removeSuffix:fuli[@"reduction_amount"] ]];

            self.context.textColor = COLOR_STR(0x333333);

        }
        else
        {
            self.context.text = @"";
            self.titleLab.text = @"";
        }

    }
    if (index == 6) {
        if (isNotNull(fuli[@"buy_send"])) {
            self.titleLab.text = @"拍下多发";
            self.context.text = [NSString stringWithFormat:@"拍%@发%@",fuli[@"buy_send"][@"buy_count"],fuli[@"buy_send"][@"send_count"]];

            self.context.textColor = COLOR_STR(0x333333);

        }
        else
        {

            self.context.text = @"";
            self.titleLab.text = @"";
        }

    }
    if (index == 7) {
        if (isNotNull(fuli[@"gift_info"])) {

            self.titleLab.text = @"专属赠品";
            self.context.text = [NSString stringWithFormat:@"%@",fuli[@"gift_info"]];
            self.context.textColor = COLOR_STR(0x333333);

        }
        else
        {
            self.titleLab.text = @"";
            self.context.text = @"";
        }

    }
    if (index == 8) {

        if ( [fuli[@"is_support_send"] integerValue] == 1) {

            self.titleLab.text = @"免费寄样";
            if ([fuli[@"is_recycle"] integerValue] == 1) {
                self.context.text = @"借用结束后需将样品寄回";
            }
            else
            {
                self.context.text = @"样品无需寄回";
            }
            self.context.textColor = COLOR_STR(0x333333);


        }
        else
        {

            self.context.text = @"";
            self.titleLab.text = @"";


        }
    }

}
-(void)addModels:(NSDictionary *)model indexs:(NSInteger)index
{

    self.context.hidden = YES;
    self.contexts.hidden = NO;
    self.leftIcon.hidden = NO;
    self.titleLab.hidden = YES;
    self.context.text = @"";
    self.titleLab.text = @"";
    self.contexts.text = @"";
    self.leftIcon.image = [UIImage new];
    if (index == 2) {
                 _leftIcon.image = [UIImage imageNamed:@"money_bg"];
            NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"commission_rate"] floatValue]/100)]]];
            NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:model[@"commission"] ]];
          AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (app.auditStatus == 0) {
            self.contexts.text=[NSString stringWithFormat: @"佣金%@（预计¥%@）",div_Money,aa];
        }
        else
        {
            self.contexts.text=[NSString stringWithFormat: @"优惠%@（预计¥%@）",div_Money,aa];
        }

            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_contexts.text];
            [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, 2)];
         [attriStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
            _contexts.attributedText = attriStr;


    }
    if (index == 3) {
        if (isNotNull(model[@"lock_rate"])) {
             _leftIcon.image = [UIImage imageNamed:@"bao_icon"];
            NSString *rateStr = [Network removeSuffix:model[@"lock_rate"] ];
            NSString *start_time = [self getTimeFromTimestamp:[model[@"lock_rate_start_time"] integerValue]];
            NSString *end_time = [self getTimeFromTimestamp:[model[@"lock_rate_end_time"] integerValue]];
            _contexts.text =[NSString stringWithFormat:@"佣金保障≥%@%%（时间%@-%@）",rateStr,start_time,end_time];
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_contexts.text];
            [attriStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(4, rateStr.length+1)];
            [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, 4)];
            _contexts.attributedText = attriStr;

        }
        else
        {
            _contexts.text = @"";
            _leftIcon.image = [UIImage imageNamed:@""];
        }

    }
    if (index == 4) {

        if ([model[@"coupon_remain_count"] intValue] > 0) {
 _leftIcon.image = [UIImage imageNamed:@"coupon_bg"];
            NSString *num = [Network removeSuffix:model[@"coupon_amount"] ];
            NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"coupon_end_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
            if ([model[@"coupon_remain_count"] integerValue] >= 10000) {
       _contexts.text =  [NSString stringWithFormat:@"优惠券%@元（%@过期，剩余%@万张）",num,time,[Network notRounding:[model[@"coupon_remain_count"] floatValue] afterPoint:2]];
//                [Network notRounding:[model[@"coupon_remain_count"] floatValue]/10000 afterPoint:2]

            }
            else
            {
            _contexts.text =[NSString stringWithFormat:@"优惠券%@元（%@过期，剩余%@张）",num,time,model[@"coupon_remain_count"]] ;
            }
                   NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_contexts.text];
                   [attriStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(3, num.length+1)];
             [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, 3)];
            _contexts.attributedText = attriStr;


        }
        else
        {
            _contexts.text = @"";
            _leftIcon.image = [UIImage imageNamed:@""];
        }
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
@end
