//
//  GoodsViewCell.m
//  KuRanApp
//
//  Created by 白冰 on 2020/2/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "GoodssViewCell.h"
#import "UIView+Gradient.h"
@implementation GoodssViewCell
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
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];

    self.goodIcon = [UIImageView new];
    [backView addSubview:self.goodIcon];
    [self.goodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.height.width.mas_equalTo(100);
    }];

    self.goodIcon.layer.cornerRadius = 10;
    self.goodIcon.layer.masksToBounds = YES;
  
    self.goodIcon.image = [UIImage imageNamed:@"goods"];
    self.goodsName = [UILabel new];
    [backView addSubview:self.goodsName];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.goodIcon.mas_top).offset(6);
        make.left.mas_equalTo(self.goodIcon.mas_right).offset(10);
        make.right.mas_equalTo(backView.mas_right).offset(-10);
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
    aaL.backgroundColor = [UIColor redColor];
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
    self.goodsName.numberOfLines = 0;
    self.goodsName.attributedText = maTitleString;

    self.currentPrice = [UILabel new];
    [backView addSubview:self.currentPrice];
    self.currentPrice.textColor = COLOR_STR(0x333333);
    self.currentPrice.font = font(15);
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
        make.bottom.mas_equalTo(self.goodIcon.mas_bottom).offset(-6);
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
    [backView addSubview:self.oldPrice];
    self.oldPrice.textColor = COLOR_STR(0x999999);
    self.oldPrice.font = font(12);
    [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.currentPrice.mas_right).offset(5);
        make.bottom.mas_equalTo(self.goodIcon.mas_bottom).offset(-6);
    }];
    NSString *str1 = @"¥199.00";
    // 需要改变的区间(第一个参数，从第几位起，长度)
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str1 attributes:attribtDic];

    // 赋值
    self.oldPrice.attributedText = attribtStr;


    self.saleNum = [UILabel new];
    [backView addSubview:self.saleNum];
    [self.saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsName.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.currentPrice.mas_top).offset(0);
        make.right.mas_equalTo(self.goodsName.mas_right).offset(0);
    }];
    self.saleNum.textColor = COLOR_STR(0x999999);
    self.saleNum.font = font(13);
    self.saleNum.text = @"已售8888";


    self.markLab = [UILabel new];
    [self addSubview:self.markLab];
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.saleNum.mas_centerY).offset(0);
        make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
        make.width.mas_equalTo(scale(16));
        make.height.mas_equalTo(scale(14));
    }];
    self.markLab.text = @"券";
    self.markLab.font = font(11);
    self.markLab.textColor = [UIColor whiteColor];
    self.markLab.textAlignment = NSTextAlignmentCenter;
    self.markLab.backgroundColor = COLOR_STR1(229, 96, 65, 1.0);
    self.markLab.layer.cornerRadius = 4;
    self.markLab.layer.masksToBounds = YES;


    self.couponsLab = [UILabel new];
    [self addSubview:self.couponsLab];
    [self.couponsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.markLab.mas_centerY).offset(0);
        make.left.mas_equalTo(self.markLab.mas_right).offset(-5);
        make.top.mas_equalTo(self.markLab.mas_top).offset(0);
    }];
    self.couponsLab.text = @"  6 元 ";
    self.couponsLab.textColor =  COLOR_STR1(229, 96, 65, 1.0);
    self.couponsLab.font = font(13);
    self.couponsLab.layer.cornerRadius = 4;
    self.couponsLab.layer.masksToBounds = YES;
    self.couponsLab.layer.borderColor =  COLOR_STR1(229, 96, 65, 1.0).CGColor;
    self.couponsLab.layer.borderWidth = 1;



    self.money = [UIButton new];
    [backView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodIcon.mas_bottom).offset(10);
        make.right.mas_equalTo(self.goodsName.mas_right).offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);

    }];
    self.money.layer.cornerRadius = 15;
    self.money.layer.masksToBounds = YES;
    [self.money setGradientBackgroundWithColors:@[COLOR_STR1(227, 57, 15, 1.0),COLOR_STR1(193, 50, 23, 1.0)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [self.money setImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
    [self.money setTitle:@"赚¥8.88" forState:UIControlStateNormal];
    self.money.titleLabel.font = font(14);
    [self.money setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];




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
