//
//  GoodsViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "GoodsViewCell.h"

@interface GoodsViewCell()

@property (nonatomic, strong) NSOperationQueue *queue;/**<队列*/
@end
@implementation GoodsViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.contentView.backgroundColor = COLOR_STR(0xffffff);
    self.goodsIcon = [UIImageView new];
    self.goodsIcon.layer.cornerRadius = 8;
    self.goodsIcon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.goodsIcon];
    self.brandLab = [UILabel new];
    [self.contentView addSubview:self.brandLab];
    self.brandLab.font = font(10);
//    self.brandLab.backgroundColor = COLOR_STR(0xEB3341);
    self.brandLab.textColor = COLOR_STR(0xffffff);
    self.brandLab.textAlignment = NSTextAlignmentCenter;
    self.brandLab.layer.cornerRadius = 7;
    self.brandLab.layer.masksToBounds = YES;
    self.goodsName = [UILabel new];
     self.goodsName.lineBreakMode = NSLineBreakByWordWrapping;
    self.goodsName.numberOfLines = 2;
    [self.contentView addSubview:self.goodsName];
    self.newsPrice = [UILabel new];
    [self.contentView addSubview:self.newsPrice];
    self.oldsPrice = [UILabel new];
    [self.contentView addSubview:self.oldsPrice];
    self.saleNum = [UILabel new];
    [self.contentView addSubview:self.saleNum];
    self.moneyNum = [UILabel new];
    [self.contentView addSubview:self.moneyNum];
    self.couponsLab = [UILabel new];
    [self.contentView addSubview:self.couponsLab];
    self.packageLab = [UILabel new];
    [self.contentView addSubview:self.packageLab];
    [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self.goodsIcon.mas_height);
    }];
    [self.brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsIcon.mas_top).offset(5);
        make.left.mas_equalTo(self.goodsIcon.mas_right).offset(10);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(36);
    }];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.brandLab.mas_centerY).offset(0);
        make.left.mas_equalTo(self.brandLab.mas_right).offset(5);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
    }];
    [self.oldsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.brandLab.mas_bottom).offset(10);
        make.left.mas_equalTo(self.brandLab.mas_left).offset(0);
    }];
    [self.saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.oldsPrice.mas_centerY).offset(0);
        make.left.mas_equalTo(self.oldsPrice.mas_right).offset(scale(40));
    }];
    [self.newsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.brandLab.mas_left).offset(0);
        make.top.mas_equalTo(self.oldsPrice.mas_bottom).offset(2);
    }];
    [self.moneyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.newsPrice.mas_centerY).offset(0);
        make.left.mas_equalTo(self.saleNum.mas_left).offset(0);
    }];
    [self.couponsLab mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.newsPrice.mas_bottom).offset(5);
          make.left.mas_equalTo(self.newsPrice.mas_left).offset(0);
      }];
    [self.packageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.couponsLab.mas_centerY).offset(0);
        make.left.mas_equalTo(self.couponsLab.mas_right).offset(5);
    }];
    
    self.goodsIcon.image = [UIImage imageNamed:@"goods_bg"];
    self.goodsName.textColor = COLOR_STR(0x333333);
    self.goodsName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:scale(13)];
    self.goodsName.text = @"都加班加点觉得溃不成军";
    self.brandLab.text = @"天猫";
    self.oldsPrice.textColor = COLOR_STR(0x999999);
    self.oldsPrice.font = font(12);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"券前 ¥60"];
     [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3, 3)];
    self.oldsPrice.attributedText = str;
    self.saleNum.textColor = COLOR_STR(0x999999);
    self.saleNum.font = font(12);
    self.saleNum.text = @"月销：3.05w";
    self.newsPrice.textColor = COLOR_STR(0xEB3341);
      self.moneyNum.textColor = COLOR_STR(0xEB3341);
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"券后¥45"];
    [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(0, 2)];
     [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)] range:NSMakeRange(2, 3)];
       self.newsPrice.attributedText = str1;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"佣金：35%"];
       [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(0, 3)];
        [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)] range:NSMakeRange(3, 3)];
          self.moneyNum.attributedText = str2;
    self.couponsLab.textColor = COLOR_STR(0xE3375D);
    self.couponsLab.font = font(9);
    self.couponsLab.text = @" ¥10券 ";
    self.couponsLab.layer.cornerRadius = 2.5;
    self.couponsLab.layer.masksToBounds = YES;
    self.couponsLab.layer.borderColor = COLOR_STR(0xE3375D).CGColor;
    self.couponsLab.layer.borderWidth = 0.5;
    
    self.packageLab.textColor = COLOR_STR(0xE3375D);
       self.packageLab.font = font(9);
       self.packageLab.text = @" 包邮 ";
       self.packageLab.layer.cornerRadius = 2.5;
       self.packageLab.layer.masksToBounds = YES;
       self.packageLab.layer.borderColor = COLOR_STR(0xE3375D).CGColor;
       self.packageLab.layer.borderWidth = 0.5;
}
- (NSOperationQueue *)queue {

    if (!_queue) {
        _queue = ({
            NSOperationQueue *q = [[NSOperationQueue alloc]init];
            //设置最大并行操作数为1相当于将queue设置为串行线程
            q.maxConcurrentOperationCount = 1;
            q;
        });
    }
    return _queue;
}
- (void)optimizeOperation:(NSDictionary *)model {

        
            


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
//    if (isNotNull(model[@"short_title"])) {
//        self.goodsName.text = model[@"short_title"];
//    }
//    else
//    {
        self.goodsName.text = model[@"title"];
//    }
               
               if ([model[@"user_type"] intValue] == 1) {
                   self.brandLab.text = @"天猫";
                   [self.brandLab setGradientBackgroundWithColors:@[COLOR_STR(0xEB3341),COLOR_STR(0xEB3341)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
               }
               else
               {
                   
                   self.brandLab.text = @"淘宝";
                   [self.brandLab setGradientBackgroundWithColors:@[COLOR_STR(0xEE7D2E),COLOR_STR(0xEA682B)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
               }
               NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"券前 ¥%@",[Network removeSuffix:model[@"zk_final_price"]]]];
                   [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3, str.length-3)];
                  self.oldsPrice.attributedText = str;
    if ([model[@"volume"] integerValue] < 10000) {
           self.saleNum.text = [NSString stringWithFormat:@"月销量%@件",model[@"volume"]];
       }
       else
       {
           self.saleNum.text = [NSString stringWithFormat:@"月销量%@万件",[Network notRounding:[model[@"volume"] floatValue] afterPoint:2]];
       }
            
               NSString *afterPrice = [NSString stringWithFormat:@"券后¥%@",[Network removeSuffix:model[@"zk_final_price"] ]];
               NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:afterPrice];
               [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(0, 2)];
                [str1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)] range:NSMakeRange(2, str1.length-2)];
                  self.newsPrice.attributedText = str1;
               NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"佣金：%@%%",[Network removeSuffix:model[@"commission_rate"]]]];
                  [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:scale(12)] range:NSMakeRange(0, 3)];
                   [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:scale(15)] range:NSMakeRange(3, str2.length-3)];
                     self.moneyNum.attributedText = str2;
               
               if (isNotNull(model[@"coupon_amount"])) {
                   self.couponsLab.text = [NSString stringWithFormat:@" ¥%d券 ",[model[@"coupon_amount"] intValue]];
               }
               else
               {
                   self.couponsLab.text = @"";
               }
              if ([model[@"real_post_fee"] intValue] == 0) {
                    self.packageLab.text = @" 包邮 ";
               }
               else
               {
                   self.packageLab.text = @"";
               }
}


@end
