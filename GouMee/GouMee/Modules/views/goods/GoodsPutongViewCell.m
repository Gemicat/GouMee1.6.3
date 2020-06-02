//
//  GoodsPutongViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/23.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GoodsPutongViewCell.h"

@implementation GoodsPutongViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {

    self.leftIcon = [UIImageView new];
    [self addSubview:self.leftIcon];
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(scale(12));
        make.width.height.mas_equalTo(scale(12));
    }];


    self.context = [UILabel new];
    [self addSubview:self.context];
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(scale(0));
        make.left.mas_equalTo(self.leftIcon.mas_right).offset(scale(10));
        make.right.mas_equalTo(scale(-12));
    }];
    self.context.font = font1(@"PingFangSC-Regular", scale(13));
    self.context.textColor = COLOR_STR(0x999999);



}
-(void)addModel:(NSDictionary *)model index:(NSInteger)index
{

    NSDictionary *fuli = model[@"kurangoods"];
    if (index == 2) {
        if ([fuli[@"data_source"] integerValue] == 1) {
            NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",[model[@"commission_rate"] floatValue]/100]]];
            NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.f",[model[@"commission"] floatValue]]]];
            self.context.text=[NSString stringWithFormat: @"%@（预计¥%@）",div_Money,aa];
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
            [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, div_Money.length)];
            _context.attributedText = attriStr;
        }
        else
        {

            NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",[fuli[@"commission_rate"] floatValue]/100]]];
            NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.f",[fuli[@"commission"] floatValue]]]];

            self.context.text=[NSString stringWithFormat: @"%@（预计¥%@）",div_Money,aa];
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
            [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, div_Money.length)];
            _context.attributedText = attriStr;
        }

    }
    if (index == 3) {
        if (isNotNull(model[@"lock_rate"])) {
//            self.titleLab.text = @"佣金保障";

            NSString *rateStr = [Network removeSuffix:[NSString stringWithFormat:@"%.f",[model[@"lock_rate"] floatValue]/100]];
            NSString *start_time = [self getTimeFromTimestamp:[model[@"lock_rate_start_time"] integerValue]];
            NSString *end_time = [self getTimeFromTimestamp:[model[@"lock_rate_end_time"] integerValue]];
            _context.text =[NSString stringWithFormat:@"佣金≥%@%%（%@-%@）",rateStr,start_time,end_time];


        }
        else
        {
            _context.text = @"";

        }
    }
    if (index == 4) {

        if ([model[@"coupon_remain_count"] intValue] > 0) {


//            _titleLab.text = @"优惠券";
            NSString *num = [Network removeSuffix:[NSString stringWithFormat:@"%.f",[model[@"coupon_amount"] floatValue]]];
            NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"coupon_end_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
            NSString *time1 = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"coupon_start_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
            _context.text =[NSString stringWithFormat:@"%@元（%@-%@）",num,time1,time] ;
            NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_context.text];
            [attriStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x333333) range:NSMakeRange(0, num.length+1)];
            _context.attributedText = attriStr;


        }
        else
        {
            _context.text = @"";


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
