//
//  ScheduleListViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "ScheduleListViewCell.h"

@implementation ScheduleListViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = viewColor;
        [self creatView];
    }
    return self;
}

-(void)creatView
{
    UIView *backView = [UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(10));
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(scale(15));
        make.bottom.mas_equalTo(0);
    }];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    
    UIView *line1 = [UIView new];
    [backView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(31));
        make.left.mas_equalTo(scale(10));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));
    }];
    line1.backgroundColor = COLOR_STR(0xEFEFEF);
    
    self.timeLab = [UILabel new];
    [backView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top).offset(0);
        make.bottom.mas_equalTo(line1.mas_top).offset(0);
        make.left.mas_equalTo(line1.mas_left).offset(0);
    }];
    self.timeLab.textColor = COLOR_STR(0x333333);
    self.timeLab.font= font(12);
    self.timeLab.text = @"9:00开播";
    
    self.statusLab = [UILabel new];
       [backView addSubview:self.statusLab];
       [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(backView.mas_top).offset(0);
           make.bottom.mas_equalTo(line1.mas_top).offset(0);
           make.right.mas_equalTo(line1.mas_right).offset(0);
       }];
       self.statusLab.textColor = COLOR_STR(0x1B9747);
       self.statusLab.font= font1(@"PingFangSC-Medium", scale(12));
    
       self.statusLab.text = @"已到样";
    
    self.goodsIcon = [UIImageView new];
    [backView addSubview:self.goodsIcon];
    [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(line1.mas_left).offset(0);
        make.height.mas_equalTo(scale(88));
        make.width.mas_equalTo(self.goodsIcon.mas_height);
    }];
    self.goodsIcon.image = [UIImage imageNamed:@"goods_bg"];
    
    self.goosName = [UILabel new];
    [backView addSubview:self.goosName];
    [self.goosName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsIcon.mas_top).offset(0);
        make.left.mas_equalTo(self.goodsIcon.mas_right).offset(scale(10));
        make.right.mas_equalTo(line1.mas_right).offset(0);
    }];
    self.goosName.numberOfLines = 2;
    self.goosName.textColor = COLOR_STR(0x333333);
    self.goosName.font = font(13);
    self.goosName.text = @"";
    
    self.currentPrice = [UILabel new];
    [backView addSubview:self.currentPrice];
    [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goosName.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(self.goosName.mas_left).offset(0);
    }];
    self.currentPrice.textColor = ThemeRedColor;
    self.currentPrice.font = font1(@"PingFangSC-Medium", scale(21));

    
    self.oldPrice = [UILabel new];
    [backView addSubview:self.oldPrice];
    self.oldPrice.font = font(12);
    self.oldPrice.textColor = COLOR_STR(0x999999);
    [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(-4));
        make.left.mas_equalTo(self.currentPrice.mas_right).offset(6);
    }];

    
    
    self.saleNum = [UILabel new];
       [backView addSubview:self.saleNum];
       self.saleNum.font = font(12);
       self.saleNum.textColor = COLOR_STR(0x333333);
       [self.saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(-4));
           make.left.mas_equalTo(self.oldPrice.mas_right).offset(6);
       }];
    self.saleNum.text = @"";
    
    
    self.hostNum = [UILabel new];
       [backView addSubview:self.hostNum];
       self.hostNum.font = font(13);
       self.hostNum.textColor = COLOR_STR(0x666666);
       [self.hostNum mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(self.goodsIcon.mas_bottom).offset(scale(0));
           make.left.mas_equalTo(self.goosName.mas_left).offset(6);
       }];
    self.hostNum.text = @"";


    self.lineView = [UIView new];
    [backView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsIcon.mas_bottom).offset(scale(10));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(0.5));
    }];
    self.lineView.backgroundColor = COLOR_STR(0xEFEFEF);

    self.seeBtn = [UIButton new];
    [backView addSubview:self.seeBtn];
    [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(scale(10));
        make.right.mas_equalTo(scale(-12));
        make.height.mas_equalTo(scale(30));
        make.width.mas_equalTo(scale(104));
    }];
    self.seeBtn.layer.cornerRadius = scale(15);
    self.seeBtn.layer.masksToBounds = YES;
    self.seeBtn.layer.borderWidth = 1;
    self.seeBtn.layer.borderColor = ThemeRedColor.CGColor;
    self.seeBtn.titleLabel.font = font(14);
    [self.seeBtn setTitle:@"查看库然福利" forState:UIControlStateNormal];
    [self.seeBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];

}
-(void)addModel:(NSDictionary *)model
{
    self.goosName.text = model[@"good_info"][@"title"];
    if (isNotNull(model[@"good_info"][@"white_image"])) {
         [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good_info"][@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }
    else
    {
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good_info"][@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }
   
    NSInteger apply_status = [model[@"apply_status"] intValue];
    switch (apply_status) {
       
            case 1:
        {
                       self.statusLab.text = @"未发货";
            self.statusLab.textColor =ThemeRedColor;
        }
                       break;
            case 2:
                       self.statusLab.text = @"途中";
             self.statusLab.textColor =COLOR_STR(0x1B9747);
                       break;
            case 3:
                       self.statusLab.text = @"已到样";
             self.statusLab.textColor =COLOR_STR(0x1B9747);
                       break;
           
            
        default:
            break;
    }
    
    
    
    NSInteger status = [model[@"live_type"] intValue];
     NSDictionary *fuli = model[@"kurangoods"];
    if ([model[@"stock"] integerValue] > 0) {

        NSString *sum_num;
//        if ([model[@"stock"] integerValue] < 10000) {
            sum_num = [NSString stringWithFormat:@"限量%@件",model[@"stock"]];
//        }
//        else
//        {
//            sum_num = [NSString stringWithFormat:@"限量%@万件",[Network notRounding:[model[@"stock"] floatValue] afterPoint:2]];
//        }

        self.saleNum.text = sum_num;
    }
    else
    {
        self.saleNum.text = @"";
    }
    if (status == 1) {

        NSArray *arr = model[@"price_json"];
           NSString *price;
           if (arr.count == 1) {
               price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:arr.firstObject[@"price"]]] ;
               NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                                   // 需要改变的区间(第一个参数，从第几位起，长度)
                                   NSRange range = NSMakeRange(0, 1);
                                   // 改变字体大小及类型
                        [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                          [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                            self.currentPrice.attributedText = noteStr;
               NSNumber *a=[NSNumber numberWithFloat:[model[@"good_info"][@"zk_final_price"] floatValue]];
               NSNumber *b=[NSNumber numberWithFloat:[arr.firstObject[@"price"] floatValue]];
               if ([a compare:b]==1) {
                   NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:model[@"good_info"][@"zk_final_price"]]]];
                   [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
                   self.oldPrice.attributedText = str;
               }
               else
               {
                   self.oldPrice.text = @"";
               }
           }
           else
           {
               NSMutableArray *priceArr = [NSMutableArray array];
               for (NSDictionary *dic in arr) {
                   [priceArr addObject:[Network removeSuffix:dic[@"price"] ]];
               }
                CGFloat max =[[priceArr valueForKeyPath:@"@max.floatValue"] floatValue];
                CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];
                    price =[NSString stringWithFormat:@"¥%@起", [Network removeSuffix:[priceArr valueForKeyPath:@"@min.doubleValue"]]] ;
                   NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                                       // 需要改变的区间(第一个参数，从第几位起，长度)
                                       NSRange range = NSMakeRange(0, 1);
                                       // 改变字体大小及类型
                            [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                    [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(price.length-2, 1)];
                              [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                 [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:NSMakeRange(price.length-1, 1)];
                                self.currentPrice.attributedText = noteStr;

               NSNumber *a=[NSNumber numberWithFloat:[model[@"good_info"][@"zk_final_price"] floatValue]];
               NSNumber *b=[NSNumber numberWithFloat:min];
               if ([a compare:b]==1) {
                   NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:model[@"good_info"][@"zk_final_price"]]]];
                   [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
                   self.oldPrice.attributedText = str;
               }
               else
               {
                   self.oldPrice.text = @"";
               }


           }
          

                    
    }
    else
    {
        if ([fuli[@"data_source"] integerValue] != 1) {
            NSString *price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:fuli[@"kuran_price"]]] ;
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
            // 需要改变的区间(第一个参数，从第几位起，长度)
            NSRange range = NSMakeRange(0, 1);
            // 改变字体大小及类型
            [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
            [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
            self.currentPrice.attributedText = noteStr;
            NSNumber *a=[NSNumber numberWithFloat:[fuli[@"kuran_price"] floatValue]];
            NSNumber *b=[NSNumber numberWithFloat:[model[@"good_info"][@"zk_final_price"] floatValue]];
            if ([a compare:b]==-1) {
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[Network removeSuffix:model[@"good_info"][@"zk_final_price"]]]];
                [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
                self.oldPrice.attributedText = str;
            }
            else
            {
                self.oldPrice.text = @"";
            }

        }
        else
        {



              NSString  *price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:model[@"good_info"][@"final_price"] ]] ;
                NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                // 需要改变的区间(第一个参数，从第几位起，长度)
                NSRange range = NSMakeRange(0, 1);
                // 改变字体大小及类型
                [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                self.currentPrice.attributedText = noteStr;


                if (isNotNull(model[@"good_info"][@"coupon_amount"])) {
                    NSString *straa = [NSString stringWithFormat:@"￥%@",[Network removeSuffix:model[@"good_info"][@"zk_final_price"] ]];
                    NSMutableAttributedString *strs = [[NSMutableAttributedString alloc] initWithString:straa];
                    [strs addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, straa.length)];
                    self.oldPrice.attributedText = strs;
                }
        }



    }





    if ([model[@"usercount"] intValue] > 0) {


        NSString *price =[NSString stringWithFormat:@"%@",model[@"usercount"]] ;
         self.hostNum.text = [NSString stringWithFormat: @"共有%@名主播参与拼播",price];
        NSMutableAttributedString *noteStrx = [[NSMutableAttributedString alloc] initWithString:self.hostNum.text];
        // 需要改变的区间(第一个参数，从第几位起，长度)
        NSRange range = NSMakeRange(2, price.length);
        // 改变字体大小及类型
        [noteStrx addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:range];
        self.hostNum.attributedText = noteStrx;
    }
    else
    {
        self.hostNum.text = @"";
    }
    NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"HH:mm"];
    self.timeLab.text = [NSString stringWithFormat:@"%@ 开播",time];
}


@end
