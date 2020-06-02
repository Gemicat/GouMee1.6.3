//
//  Kuran_FuliViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/22.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Kuran_FuliViewCell.h"

@implementation Kuran_FuliViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatCell];
    }
    return self;
}
-(void)creatCell
{

    self.titleLab = [UIButton new];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(scale(13));
        make.left.mas_equalTo(self.mas_left).offset(scale(12));
    }];
    self.titleLab.titleLabel.font = font1(@"PingFangSC-Semibold", scale(16));

    [self.titleLab setTitleColor:ThemeRedColor forState:UIControlStateNormal];



    self.ruleBtn = [UIButton new];
    [self addSubview:self.ruleBtn];
    [self.ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY).offset(scale(0));
        make.right.mas_equalTo(self.mas_right).offset(scale(-12));
    }];
    self.ruleBtn.titleLabel.font = font(12);

    [self.ruleBtn setTitleColor:COLOR_STR(0x999999) forState:UIControlStateNormal];


    self.titleLab.adjustsImageWhenDisabled=NO;

    self.titleLab.adjustsImageWhenHighlighted=NO;

    self.ruleBtn.adjustsImageWhenDisabled=NO;

    self.ruleBtn.adjustsImageWhenHighlighted=NO;


//    CGSize labelsize7 = [self.jiyangLabs sizeThatFits:baseSize];
//    _cellHeight = _cellHeight+labelsize7.height+scale(12);

}
-(void)addModel:(NSDictionary *)model
{
    if ([model[@"kurangoods"][@"data_source"] integerValue ] == 2) {
  [self.titleLab setTitle:@"库然专享福利" forState:UIControlStateNormal];
         [self.ruleBtn setTitle:@"专享福利说明" forState:UIControlStateNormal];
         [self.titleLab setImage:[UIImage imageNamed:@"zhuanxiang"] forState:UIControlStateNormal];
         [self.ruleBtn setImage:[UIImage imageNamed:@"rule_nn"] forState:UIControlStateNormal];
         [self.titleLab layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:3];
          [self.ruleBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:0];
  CGSize baseSize = CGSizeMake(SW-scale(89), CGFLOAT_MAX);
    _cellHeight = scale(13);
    CGSize labelsize = [self.titleLab sizeThatFits:baseSize];
    _cellHeight = labelsize.height+_cellHeight;
    }
    else
    {
        [self.titleLab setTitle:@"" forState:UIControlStateNormal];
        [self.ruleBtn setTitle:@"" forState:UIControlStateNormal];
        [self.titleLab setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.ruleBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _cellHeight = 0;
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
-(CGFloat)getHeight
{

   return   _cellHeight;
}
@end
