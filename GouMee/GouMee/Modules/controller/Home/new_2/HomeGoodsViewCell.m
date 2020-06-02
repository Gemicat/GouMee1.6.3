//
//  HomeGoodsViewCell.m
//  KuRanApp
//
//  Created by 白冰 on 2020/2/10.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "HomeGoodsViewCell.h"

@implementation HomeGoodsViewCell
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
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
  

    self.goodsIcon = [UIImageView new];
    [self addSubview:self.goodsIcon];
    [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.goodsIcon.mas_width);

    }];
    self.goodsIcon.image = [UIImage imageNamed:@"goods"];


    self.goodsName = [UILabel new];
    [self addSubview:self.goodsName];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsIcon.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(self.goodsIcon.mas_left).offset(scale(5));
        make.centerX.mas_equalTo(0);
    }];
    NSString *titleString = @" 麻辣零食经典款素果冻酒红色的很干净公司设计蝴蝶结";
    //创建  NSMutableAttributedString 富文本对象
    NSMutableAttributedString *maTitleString = [[NSMutableAttributedString alloc] initWithString:titleString];
    //创建一个小标签的Label
    NSString *aa = @"天猫";
    CGFloat aaW = 12*aa.length +15;
    UILabel *aaL = [UILabel new];
    aaL.frame = CGRectMake(0, 0, aaW*3, 16*3);
    aaL.text = aa;
    aaL.font = [UIFont boldSystemFontOfSize:12*3];
    aaL.textColor = [UIColor whiteColor];
    aaL.backgroundColor = COLOR_STR1(237, 98, 0, 1.0);
    aaL.clipsToBounds = YES;
    aaL.layer.cornerRadius = 8*3;
    aaL.textAlignment = NSTextAlignmentCenter;
    //调用方法，转化成Image
    UIImage *image = [self imageWithUIView:aaL];
    //创建Image的富文本格式
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2.5, aaW, 16); //这个-2.5是为了调整下标签跟文字的位置
    attach.image = image;
    //添加到富文本对象里
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    [maTitleString insertAttributedString:imageStr atIndex:0];//加入文字前面
    //[maTitleString appendAttributedString:imageStr];//加入文字后面
    //[maTitleString insertAttributedString:imageStr atIndex:4];//加入文字第4的位置
    self.goodsName.font = font(13);
    self.goodsName.attributedText = maTitleString;


    self.salesNum = [UILabel new];
    [self addSubview:self.salesNum];
    [self.salesNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsName.mas_bottom).offset(scale(10));
        make.right.mas_equalTo(self.goodsName.mas_right).offset(0);

    }];
    self.salesNum.textColor = COLOR_STR(0x999999);
    self.salesNum.font = font(11);
    self.salesNum.text = @"已售106";




    self.couponsLab = [UILabel new];
    [self addSubview:self.couponsLab];
    [self.couponsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.salesNum.mas_centerY).offset(0);
        make.left.mas_equalTo(self.goodsName.mas_left).offset(scale(15));
        make.height.mas_equalTo(scale(18));
    }];


    self.markLab = [UILabel new];
    [self addSubview:self.markLab];
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.salesNum.mas_centerY).offset(0);
        make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
        make.width.mas_equalTo(scale(20));
        make.height.mas_equalTo(scale(18));
    }];
    self.markLab.text = @"券";
    self.markLab.font = font(10);
    self.markLab.textColor = [UIColor whiteColor];
    self.markLab.textAlignment = NSTextAlignmentCenter;
    self.markLab.backgroundColor =COLOR_STR(0xDF3811);
    self.markLab.layer.cornerRadius = 4;
    self.markLab.layer.masksToBounds = YES;
    self.couponsLab.backgroundColor = [UIColor clearColor];
    self.couponsLab.text = @"  6 元 ";
    self.couponsLab.textColor =  COLOR_STR1(229, 96, 65, 1.0);
    self.couponsLab.font = font(11);
    self.couponsLab.layer.cornerRadius = 4;
    self.couponsLab.layer.masksToBounds = YES;
    self.couponsLab.layer.borderColor =  COLOR_STR1(229, 96, 65, 1.0).CGColor;
    self.couponsLab.layer.borderWidth = 1;

    self.moneyLab = [UIButton new];
    [self addSubview:self.moneyLab];
    self.moneyLab.titleLabel.font = font(14);
    [self.moneyLab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];;
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(scale(-10));
        make.left.mas_equalTo(self.goodsIcon.mas_left).offset(scale(5));
        make.right.mas_equalTo(self.goodsIcon.mas_right).offset(-scale(5));
        make.height.mas_equalTo(scale(30));

    }];

    self.currentPrice = [UILabel new];
    [self addSubview:self.currentPrice];
    self.currentPrice.font = font(14);
    self.currentPrice.textColor = COLOR_STR(0x333333);
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.moneyLab.mas_top).offset(scale(-10));
        make.left.mas_equalTo(self.goodsName.mas_left).offset(scale(0));
    }];
    NSString *str = @"券后¥125.00";

    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 需要改变的区间(第一个参数，从第几位起，长度)
    NSRange range = NSMakeRange(0, 3);
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:font(12) range:range];
    [noteStr addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:range];

    // 为label添加Attributed
    // 为label添加Attributed
    [self.currentPrice setAttributedText:noteStr];


    self.oldPrice = [UILabel new];
    [self addSubview:self.oldPrice];
    self.oldPrice.textColor = COLOR_STR(0x999999);
    self.oldPrice.font = font(12);
    [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.currentPrice.mas_right).offset(5);
        make.bottom.mas_equalTo(self.currentPrice.mas_bottom).offset(-3);
    }];
    NSString *str1 = @"¥199.00";
    // 需要改变的区间(第一个参数，从第几位起，长度)
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str1 attributes:attribtDic];

    // 赋值
    self.oldPrice.attributedText = attribtStr;


    self.moneyLab.layer.cornerRadius = scale(14);
    self.moneyLab.layer.masksToBounds = YES;
    self.moneyLab.backgroundColor = COLOR_STR(0xD72E51);
    [self.moneyLab setTitle:@" 赚¥8.99" forState:UIControlStateNormal];
    [self.moneyLab setImage:[UIImage imageNamed:@"money_white"] forState:UIControlStateNormal];
}

-(void)addModel:(NSDictionary *)model
{

    if (isNotNull(model[@"white_image"])) {
            [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
       }
       else
       {
            [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
       }

    NSString *titleString =  model[@"title"];
    //创建  NSMutableAttributedString 富文本对象
    NSMutableAttributedString *maTitleString = [[NSMutableAttributedString alloc] initWithString:titleString];
    //创建一个小标签的Label
     NSString *aa  = @"天猫";
    if ([model[@"user_type"] intValue] == 1) {
        aa= @"天猫";

    }
    else
    {

       aa = @"淘宝";



    }
    if (isNotNull(model[@"coupon_amount"])) {
        self.couponsLab.text = [NSString stringWithFormat:@"  %@元 ", [Network removeSuffix:model[@"coupon_amount"] ]];
        self.markLab.hidden = NO;
        self.couponsLab.hidden = NO;
        self.goodsName.numberOfLines = 1;
    }
    else
    {
        self.markLab.hidden = YES;
        self.couponsLab.hidden = YES;
        self.goodsName.numberOfLines = 2;
    }
   if ([model[@"volume"] integerValue] < 10000) {
             self.salesNum.text = [NSString stringWithFormat:@"月销量%@件",model[@"volume"]];
         }
         else
         {
             self.salesNum.text = [NSString stringWithFormat:@"月销量%@万件",[Network notRounding:[model[@"volume"] floatValue] afterPoint:2]];
         }


    CGFloat aaW = 12*aa.length +15;
    UILabel *aaL = [UILabel new];
    aaL.frame = CGRectMake(0, 0, aaW*3, 16*3);
    aaL.text = aa;
    aaL.font = [UIFont boldSystemFontOfSize:12*3];
    aaL.textColor = [UIColor whiteColor];
    aaL.backgroundColor = COLOR_STR(0xDF3811);
    aaL.clipsToBounds = YES;
    aaL.layer.cornerRadius = 8*3;
    aaL.textAlignment = NSTextAlignmentCenter;
    //调用方法，转化成Image
    UIImage *image = [self imageWithUIView:aaL];
    //创建Image的富文本格式
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2.5, aaW, 16); //这个-2.5是为了调整下标签跟文字的位置
    attach.image = image;
    //添加到富文本对象里
    NSAttributedString * imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    [maTitleString insertAttributedString:imageStr atIndex:0];//加入文字前面
    //[maTitleString appendAttributedString:imageStr];//加入文字后面
    //[maTitleString insertAttributedString:imageStr atIndex:4];//加入文字第4的位置

    self.goodsName.attributedText = maTitleString;

 if (isNotNull(model[@"coupon_amount"])) {

    NSString *afterPrice = [NSString stringWithFormat:@"券后¥%@",[Network removeSuffix:model[@"zk_final_price"] ]];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:afterPrice];
    [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(0, 3)];
     [str1 addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:NSMakeRange(0, 3)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)] range:NSMakeRange(3, str1.length-3)];
    self.currentPrice.attributedText = str1;

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:model[@"zk_final_price"]]]];
    [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    self.oldPrice.attributedText = str;

 }
    else
    {

        NSString *afterPrice = [NSString stringWithFormat:@"现价¥%@",[Network removeSuffix:model[@"zk_final_price"]]];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:afterPrice];
        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(0, 3)];
        [str1 addAttribute:NSForegroundColorAttributeName value:COLOR_STR(0x999999) range:NSMakeRange(0, 3)];
        [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)] range:NSMakeRange(3, str1.length-3)];
        self.currentPrice.attributedText = str1;
        self.oldPrice.text = @"";
    }

     [self.moneyLab setTitle:[NSString stringWithFormat:@" 赚¥%.2f",[model[@"commission"] floatValue]] forState:UIControlStateNormal];

}




- (UIImage*) imageWithUIView:(UIView*) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}

@end
