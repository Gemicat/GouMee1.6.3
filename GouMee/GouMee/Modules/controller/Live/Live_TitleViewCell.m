//
//  Live_TitleViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Live_TitleViewCell.h"
#import "AppDelegate.h"
@implementation Live_TitleViewCell

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
    self.goodsName = [UILabel new];
    [self addSubview:self.goodsName];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(10));
        make.left.mas_equalTo(scale(15));
        make.centerX.mas_equalTo(0);
    }];
    self.goodsName.numberOfLines = 2;
    self.goodsName.font = font1(@"PingFangSC-Semibold", scale(16));
    self.goodsName.textColor = COLOR_STR(0x333333);
    
    self.currentPrice = [UILabel new];
    [self addSubview:self.currentPrice];
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsName.mas_bottom).offset(scale(5));
        make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
    }];
    self.currentPrice.font = font1(@"PingFangSC-Regular", scale(14));
    self.currentPrice.textColor = COLOR_STR(0x666666);
    
    self.saleNum = [UILabel new];
    [self addSubview:self.saleNum];
    [self.saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(-3));
        make.right.mas_equalTo(self.goodsName.mas_right).offset(0);
    }];
    self.saleNum.font = font(11);
    self.saleNum.textColor = COLOR_STR(0x999999);
   


    self.arrowView = [UIImageView new];
    [self addSubview:self.arrowView];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(12));
        make.top.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(24));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(16));
    }];
    self.oneView = [UIView new];
    [self addSubview:self.oneView];
    self.twoView = [UIView new];
    [self addSubview:self.twoView];
    self.threeView = [UIView new];
    [self addSubview:self.threeView];
     CGSize baseSize = CGSizeMake(SW-scale(30), CGFLOAT_MAX);
    CGSize labelsize = [_goodsName sizeThatFits:baseSize];
     CGSize labelsize1 = [_currentPrice sizeThatFits:baseSize];
    CGSize labelsize2 = [_oneMoney sizeThatFits:baseSize];
     CGSize labelsize3 = [_oneNum sizeThatFits:baseSize];
    CGFloat h = scale(20)+labelsize.height+labelsize1.height+scale(48)+scale(16);
    _slider = [[MQGradientProgressView alloc]initWithFrame:CGRectMake(scale(15), h, SW-scale(30), scale(22))];
       [self addSubview:_slider];
     
    self.teamNum = [UILabel new];
    [self addSubview:self.teamNum];
    [self.teamNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_slider.mas_centerY).offset(0);
        make.left.mas_equalTo(_slider.mas_left).offset(scale(15));
        
    }];
    self.teamNum.textColor = COLOR_STR(0xffffff);
    self.teamNum.font =font(10);
   
    
    self.limitNum = [UILabel new];
       [self addSubview:self.limitNum];
       [self.limitNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(_slider.mas_centerY).offset(0);
           make.right.mas_equalTo(_slider.mas_right).offset(scale(-15));
           
       }];
       self.limitNum.textColor = COLOR_STR(0xffffff);
       self.limitNum.font =font(10);
    
    
    UIView *line = [UIView new];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slider.mas_bottom).offset(scale(8));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(10));
    }];
    line.backgroundColor = viewColor;
    
    self.couspondLab = [UILabel new];
    [self addSubview:self.couspondLab];
    [self.couspondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(_slider.mas_left).offset(scale(0));
    }];
    self.couspondLab.font =font(12);
    
    self.couspondLab.textColor = COLOR_STR(0x999999);
    self.couspondLab.text = @"";
    
    self.commissionLab = [UILabel new];
       [self addSubview:self.commissionLab];
       [self.commissionLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.couspondLab.mas_bottom).offset(scale(10));
           make.left.mas_equalTo(_slider.mas_left).offset(scale(0));
       }];
       self.commissionLab.font =font(12);
       
       self.commissionLab.textColor = COLOR_STR(0x999999);
       self.commissionLab.text = @"";
  
    
    
     _cellHeight = h+scale(45)+[_couspondLab sizeThatFits:baseSize].height+[self.commissionLab sizeThatFits:baseSize].height;
    
    
}
-(void)addModel:(NSDictionary *)model
{
    self.oneNum.text = self.oneMoney.text = @"";
    self.twoNum.text = self.twoMoney.text = @"";
    self.threeNum.text = self.threeMoney.text = @"";

    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
  NSInteger status = [model[@"get_status"] integerValue];
    if (status != 1) {
         self.arrowView.image = [UIImage imageNamed:@"arrow_icon"];
    }
    else
    {

         self.arrowView.image = [UIImage imageNamed:@"arrow_icons"];
    }
     NSMutableAttributedString *maTitleString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@" %@",model[@"good"][@"title"]]];
    UIImage *image;
    if ([model[@"good"][@"user_type"] intValue] == 1) {
        image = [UIImage imageNamed:@"tianmao_icon"];

    }
    else
    {

        image = [UIImage imageNamed:@"taobao_icon"];



    }
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2.5, 36, 16); //这个-2.5是为了调整下标签跟文字的位置
    attach.image = image;
    //添加到富文本对象里
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    [maTitleString insertAttributedString:imageStr atIndex:0];//加入文字前面
    //[maTitleString appendAttributedString:imageStr];//加入文字后面
    //[maTitleString insertAttributedString:imageStr atIndex:4];//加入文字第4的位置

    self.goodsName.attributedText = maTitleString;


    NSString *sum_num;
//    if ([model[@"stock"] integerValue] < 10000) {
        sum_num = [NSString stringWithFormat:@"限量%@件",model[@"stock"]];
//    }
//    else
//    {
//        sum_num = [NSString stringWithFormat:@"限量%@万件",[Network notRounding:[model[@"stock"] floatValue] afterPoint:2]];
//    }


    self.limitNum.text = sum_num;
    self.currentPrice.textColor = COLOR_STR(0x333333);
    self.currentPrice.font =font1(@"PingFangSC-Semibold", scale(16));
     self.currentPrice.text = [NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:model[@"good"][@"zk_final_price"] ]];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_currentPrice.text];
    [attriStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(2, 1)];
    [attriStr addAttribute:NSKernAttributeName value:@(4.0) range:NSMakeRange(1, 1)];
    [attriStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Semibold", scale(12)) range:NSMakeRange(2, 1)];
      [attriStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(14)) range:NSMakeRange(0, 2)];
    _currentPrice.attributedText = attriStr;



    if ([model[@"good"][@"volume"] integerValue] > 9999) {
       self.saleNum.text =[NSString stringWithFormat:@"月销%@万",[Network notRounding:[model[@"good"][@"volume"] floatValue] afterPoint:2]];
    }
    else
    {
        self.saleNum.text =[NSString stringWithFormat:@"月销%@",model[@"good"][@"volume"]];
    }
    
    NSArray *arr = model[@"price_json"];
    if (arr.count == 1) {

        [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.arrowView.mas_centerY).offset(0);
            make.left.mas_equalTo(scale(40));
            make.right.mas_equalTo(scale(-12));
        }];
        [self creatView:self.oneView dic:arr.firstObject status:status];


    }
    if (arr.count == 2) {

        [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.arrowView.mas_centerY).offset(0);
            make.left.mas_equalTo(scale(40));
            make.width.mas_equalTo((SW-scale(52))/2.0);
        }];
        [self creatView:self.oneView dic:arr.firstObject status:status];
        [self.twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.arrowView.mas_centerY).offset(0);
            make.left.mas_equalTo(self.oneView.mas_right).offset(0);
            make.width.mas_equalTo((SW-scale(52))/2.0);
        }];
        [self creatView:self.twoView dic:arr[1] status:status];

    }
    if (arr.count == 3) {
        [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.arrowView.mas_centerY).offset(0);
            make.left.mas_equalTo(scale(40));
            make.width.mas_equalTo((SW-scale(52))/3.0);
        }];
        [self creatView:self.oneView dic:arr.firstObject status:status];
        [self.twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.arrowView.mas_centerY).offset(0);
            make.left.mas_equalTo(self.oneView.mas_right).offset(0);
            make.width.mas_equalTo((SW-scale(52))/3.0);
        }];
        [self creatView:self.twoView dic:arr[1] status:status];
        [self.threeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.arrowView.mas_centerY).offset(0);
            make.left.mas_equalTo(self.twoView.mas_right).offset(0);
            make.width.mas_equalTo((SW-scale(52))/3.0);
        }];
        [self creatView:self.threeView dic:arr[2] status:status];

    }
     self.teamNum.text = [NSString stringWithFormat:@"报名%@人成团（%@/%@）",model[@"max_usercount"],model[@"usercount"],model[@"max_usercount"]];
    _slider.progress = [model[@"usercount"] floatValue]/[model[@"max_usercount"] floatValue];

    CGSize baseSize = CGSizeMake(SW-scale(30), CGFLOAT_MAX);
       CGSize labelsize = [_goodsName sizeThatFits:baseSize];
        CGSize labelsize1 = [_currentPrice sizeThatFits:baseSize];
//       CGSize labelsize2 = [_oneMoney sizeThatFits:baseSize];
//        CGSize labelsize3 = [_oneNum sizeThatFits:baseSize];
     CGFloat h = scale(20)+labelsize.height+labelsize1.height+scale(64);
    _slider.frame = CGRectMake(scale(15), h, SW-scale(30), scale(22));
    CGFloat h1= h+scale(36);

    if (status != 1) {
        _slider.bgProgressColor = COLOR_STR1(51, 51, 51, 0.24);

          _slider.colorArr = @[(id)COLOR_STR1(215, 46, 81, 0.8).CGColor,(id)COLOR_STR1(215, 46, 81, 0.8).CGColor];
       }
       else
       {
          _slider.bgProgressColor = ThemeGreenColor;
           _slider.colorArr = @[(id)COLOR_STR1(15, 183, 78, 1).CGColor,(id)COLOR_STR1(15, 183, 78, 1).CGColor];
       }
   
    _cellHeight = h1;
}
-(void)creatView:(UIView *)views dic:(NSDictionary *)model status:(NSInteger)type
{

    UIView *dotView = [UIView new];
    [views addSubview:dotView];
    [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-0.5);
        make.height.with.width.mas_equalTo(scale(6));
    }];
    dotView.layer.cornerRadius = scale(3);
    dotView.layer.masksToBounds = YES;




    UILabel *money = [UILabel new];
    [views addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(dotView.mas_top).offset(scale(-5));
        make.centerX.mas_equalTo(dotView.mas_centerX).offset(0);
    }];
    if (type != 1) {
        dotView.backgroundColor = ThemeRedColor;
          money.textColor = ThemeRedColor;
    }
    else
    {
        dotView.backgroundColor = ThemeGreenColor;
          money.textColor = ThemeGreenColor;
    }

    money.font = font1(@"PingFangSC-Medium", scale(16));
    money.text =[NSString stringWithFormat:@"￥%@",[Network removeSuffix:model[@"price"]]];
    //    self.oneNum.text  =
    //
        NSMutableAttributedString *stra = [[NSMutableAttributedString alloc] initWithString:money.text];
        [stra addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(13)] range:NSMakeRange(0, 1)];
        money.attributedText = stra;

    UILabel *num = [UILabel new];
    [views addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dotView.mas_bottom).offset(scale(5));
        make.centerX.mas_equalTo(dotView.mas_centerX).offset(0);
    }];
    num.textColor = COLOR_STR(0x999999);
    num.font = font(12);
     num.text=[NSString stringWithFormat:@"满%@件",model[@"sale_count"]];

}


-(CGFloat)getHeight
{
    
   return  _cellHeight;
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
