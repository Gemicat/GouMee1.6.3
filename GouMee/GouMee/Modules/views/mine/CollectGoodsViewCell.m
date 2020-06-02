//
//  CollectGoodsViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/19.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "CollectGoodsViewCell.h"
#import "MQGradientProgressView.h"

@interface CollectGoodsViewCell ()
{
    
    UILabel *rightBtn;
    MQGradientProgressView *slider;
    UIView *line;
}

@end
@implementation CollectGoodsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

if (self) {
    self.backgroundColor = COLOR_STR(0xf5f5f5);
    [self creatCell];
}
    return self;
}
-(void)creatCell
{
       UIView *backView = [UIView new];
            [self addSubview:backView];
            backView.backgroundColor = [UIColor whiteColor];
            backView.layer.cornerRadius = 10;
            backView.layer.masksToBounds = YES;
           [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(scale(15));
                make.centerX.mas_equalTo(0);
                make.bottom.mas_equalTo(-scale(10));
            }];
            
            self.goodsIcon = [UIImageView new];
            [backView addSubview:self.goodsIcon];
            [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(backView.mas_top).offset(scale(10));
                make.left.mas_equalTo(scale(10));
                make.height.width.mas_equalTo(scale(124));
            }];
            self.goodsIcon.image = [UIImage imageNamed:@"mianfei"];
            self.FreeIcon = [UIImageView new];
               [backView addSubview:self.FreeIcon];
               [self.FreeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.top.mas_equalTo(self.goodsIcon.mas_top).offset(-2);
                  make.left.mas_equalTo(self.goodsIcon.mas_left).offset(scale(4));
               }];
               self.FreeIcon.hidden = YES;
               self.FreeIcon.image = [UIImage imageNamed:@"jiyang_ss"];
        self.startTime = [UILabel new];
        [self.goodsIcon addSubview:self.startTime];
        [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(scale(25));
        
        }];
        self.startTime.backgroundColor = COLOR_STR1(0, 0, 0, 0.5);
        self.startTime.font = font(10);
        self.startTime.textAlignment = NSTextAlignmentCenter;
        self.startTime.textColor = [UIColor whiteColor];
        [self.startTime sizeToFit];
            self.goodsName = [UILabel new];
               self.goodsName.font = font(14);
               self.goodsName.textColor = COLOR_STR(0x333333);
               self.goodsName.numberOfLines = 2;
               self.goodsName.lineBreakMode = NSLineBreakByWordWrapping;
               [backView addSubview:self.goodsName];
               [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.top.mas_equalTo (self.goodsIcon.mas_top).offset(scale(0));
                   make.left.mas_equalTo(self.goodsIcon.mas_right).offset(scale(10));
                   make.right.mas_equalTo(backView.mas_right).offset(-scale(10));
               }];
            self.goodsName.text = @"babysmile电动牙刷儿童宝宝电动牙刷儿童宝宝童宝宝电动牙刷儿童宝宝";
           
            UIView *centerView = [UIView new];
            [backView addSubview:centerView];
            [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.goodsName.mas_bottom).offset(scale(5));
                make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
                make.right.mas_equalTo(backView.mas_right).offset(scale(-10));
                make.height.mas_equalTo(scale(43));
            }];
            centerView.backgroundColor = COLOR_STR(0xFFF1EE);
            
            self.dateTime = [UILabel new];
            [backView addSubview:self.dateTime];
            [self.dateTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.goodsIcon.mas_bottom).offset(0);
                make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
                make.right.mas_equalTo(self.goodsName.mas_right).offset(0);
            }];
            self.dateTime.textColor = COLOR_STR(0x666666);
            self.dateTime.font = font(12);
            self.dateTime.text = @"报名截止：1月28日 11:00";
            
            self.currentPrice = [UILabel new];
            [backView addSubview:self.currentPrice];
            self.currentPrice.font = font1(@"PingFangSC-Medium", scale(21));
            [self.currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.goodsName.mas_left).offset(0);
                make.bottom.mas_equalTo(self.dateTime.mas_top).offset(0);
            }];
            self.currentPrice.textColor = ThemeRedColor;
           
            
            
            self.oldPrice = [UILabel new];
            [backView addSubview:self.oldPrice];
            self.oldPrice.font = font(12);
            self.oldPrice.textColor = COLOR_STR(0x999999);
            [self.oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.currentPrice.mas_bottom).offset(scale(-4));
                make.left.mas_equalTo(self.currentPrice.mas_right).offset(6);
            }];
           
            
            UIImageView *moneyIcon = [UIImageView new];
            [centerView addSubview:moneyIcon];
            [moneyIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(centerView.mas_top).offset(scale(5));
                make.left.mas_equalTo(centerView.mas_left).offset(scale(11));
                make.bottom.mas_equalTo(centerView.mas_centerY).offset(scale(-2.5));
                make.width.mas_equalTo(moneyIcon.mas_height);
            }];
            moneyIcon.image = [UIImage imageNamed:@"live_money"];
            
            UIImageView *numIcon = [UIImageView new];
            [centerView addSubview:numIcon];
            [numIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(centerView.mas_centerY).offset(scale(2.5));
                make.left.mas_equalTo(centerView.mas_left).offset(scale(11));
                make.bottom.mas_equalTo(centerView.mas_bottom).offset(scale(-5));
                make.width.mas_equalTo(moneyIcon.mas_height);
            }];
            numIcon.image = [UIImage imageNamed:@"live_number"];
            
            self.moneyLab = [UILabel new];
            [centerView addSubview:self.moneyLab];
            [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(moneyIcon.mas_centerY).offset(0);
                make.left.mas_equalTo(moneyIcon.mas_right).offset(scale(5));
                make.right.mas_equalTo(centerView.mas_right).offset(scale(-10));
            }];
            self.moneyLab.textColor = COLOR_STR(0x999999);
            self.moneyLab.font = font(12);
            NSString *sum_Money = @"佣金26% (预计￥28.6)";
            NSString *div_Money = @"26%";
            
            NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
                      // 需要改变的区间(第一个参数，从第几位起，长度)
                    
            [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
            self.moneyLab.attributedText = moneyStr;
            
            
            self.numLab = [UILabel new];
            [centerView addSubview:self.numLab];
            [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(numIcon.mas_centerY).offset(0);
                make.left.mas_equalTo(numIcon.mas_right).offset(scale(5));
                make.right.mas_equalTo(centerView.mas_right).offset(scale(-10));
            }];
            self.numLab.textColor = COLOR_STR(0x999999);
            self.numLab.font = font(12);
           
            
            slider = [[MQGradientProgressView alloc]initWithFrame:CGRectMake(scale(10), scale(154), SW-scale(140), scale(22))];
            [backView addSubview:slider];
            slider.bgProgressColor = COLOR_STR(0xE6AFAA);
             slider.colorArr = @[(id)COLOR_STR(0xD72E51).CGColor,(id)COLOR_STR(0xDC4761).CGColor];
               slider.progress = 0.00;
    
    
    UIView *line = [UIView new];
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(slider.mas_bottom).offset(scale(10));
        make.height.mas_equalTo(scale(1));
        make.left.mas_equalTo(_goodsIcon.mas_left).offset(0);
        make.centerX.mas_equalTo(0);
    }];
    line.backgroundColor = COLOR_STR(0xFFF1EE);
    
    
    self.validLab = [UILabel new];
       self.validLab.text = @"已失效";
       self.validLab.textColor = COLOR_STR(0x666666);
       self.validLab.font = font1(@"PingFangSC-Regular", scale(14));
       self.validLab.hidden = YES;
              [backView addSubview:self.validLab];
           [self.validLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(line.mas_bottom).offset(0);
               make.left.mas_equalTo(line.mas_left).offset(0);
               make.bottom.mas_equalTo(backView.mas_bottom).offset(scale(0));
           }];
    
    self.collectBtn = [UIButton new];
       [backView addSubview:self.collectBtn];
       [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(self.validLab.mas_centerY).offset(0);
           make.height.mas_equalTo(scale(25));
           make.width.mas_equalTo(scale(80));
           make.right.mas_equalTo(line.mas_right).offset(0);
       }];
       self.collectBtn.layer.cornerRadius = scale(12.5);
       self.collectBtn.layer.masksToBounds = YES;

       [self.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
       self.collectBtn.titleLabel.font = font(14);
       [self.collectBtn setTitleColor:COLOR_STR(0x666666) forState:UIControlStateNormal];
       self.collectBtn.layer.borderColor = COLOR_STR(0x666666).CGColor;
       self.collectBtn.layer.borderWidth = 0.5;
          
            
            self.hostNum = [UILabel new];
            [backView addSubview:self.hostNum];
            [self.hostNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(slider.mas_centerY).offset(0);
                make.centerX.mas_equalTo(slider.mas_centerX).offset(0);
            }];
            self.hostNum.text = @"已报名主播（26/50）";
            self.hostNum.textColor = COLOR_STR(0xffffff);
            self.hostNum.font =font(10);
            
            
            rightBtn = [UILabel new];
            [backView addSubview:rightBtn];
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(slider.mas_bottom).offset(0);
                make.right.mas_equalTo(self.goodsName.mas_right).offset(0);
                make.left.mas_equalTo(slider.mas_right).offset(scale(10));
                make.height.mas_equalTo(scale(30));
                
            }];
            rightBtn.layer.cornerRadius = scale(15);
            rightBtn.layer.masksToBounds = YES;
            [rightBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
            rightBtn.text = @"马上拼";
            rightBtn.textAlignment = NSTextAlignmentCenter;
            rightBtn.textColor = [UIColor whiteColor];
            rightBtn.font = font(14);
        }

 
    -(void)addModel1:(NSDictionary *)model
    {

        if (isNotNull(model)) {

        if (isNotNull(model[@"good"][@"white_image"])) {
                [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good"][@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
           }
           else
           {
                [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good"][@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
           }
               self.goodsName.text = model[@"good"][@"title"];
            NSDictionary *fuli = model[@"good"][@"kurangoods"];
            if ([fuli[@"data_source"] integerValue] == 1) {
               NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"good"][@"commission_rate"] floatValue]/100)]]];


                AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                NSString *sum_Money;
                if (app.auditStatus == 0) {
                    sum_Money=[NSString stringWithFormat: @"佣金%@ (预计￥%@)",div_Money,model[@"good"][@"commission"]];
                }
                else
                {
                    sum_Money=[NSString stringWithFormat:@"优惠%@ (预计￥%@)",div_Money,model[@"good"][@"commission"]];
                }
               
               
               NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
                         // 需要改变的区间(第一个参数，从第几位起，长度)
                       
               [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
               self.moneyLab.attributedText = moneyStr;
            }
            else
            {
                if ([fuli[@"commission_rate"] floatValue] > 0) {

                NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([fuli[@"commission_rate"] floatValue]/100)]]];

                    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                    NSString *sum_Money;
                    if (app.auditStatus == 0) {
                        sum_Money=[NSString stringWithFormat: @"佣金%@ (预计￥%@)",div_Money,fuli[@"commission"]];
                    }
                    else
                    {
                        sum_Money=[NSString stringWithFormat: @"优惠%@ (预计￥%@)",div_Money,fuli[@"commission"]];
                    }




                NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
                // 需要改变的区间(第一个参数，从第几位起，长度)

                [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
                self.moneyLab.attributedText = moneyStr;
                }
                else
                {
                    NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"good"][@"commission_rate"] floatValue]/100)]]];


                    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                    NSString *sum_Money;
                    if (app.auditStatus == 0) {
                        sum_Money=[NSString stringWithFormat: @"佣金%@ (预计￥%@)",div_Money,model[@"good"][@"commission"]];
                    }
                    else
                    {
                        sum_Money=[NSString stringWithFormat: @"优惠%@ (预计￥%@)",div_Money,model[@"good"][@"commission"]];
                    }





                    NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
                    // 需要改变的区间(第一个参数，从第几位起，长度)

                    [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
                    self.moneyLab.attributedText = moneyStr;

                }
            }
        NSString *straa =[NSString stringWithFormat:@"¥ %@",[Network removeSuffix:model[@"good"][@"zk_final_price"] ]]  ;
                 NSMutableAttributedString *strs = [[NSMutableAttributedString alloc] initWithString:straa];
                    [strs addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, straa.length)];
                    self.oldPrice.attributedText = strs;
        
        NSString *div_num =[NSString stringWithFormat:@"%@",model[@"live_group_info"][@"stock"]] ;
            NSString *sum_num;
//            if ([model[@"stock"] integerValue] < 10000) {
                sum_num = [NSString stringWithFormat:@"限量%@件",model[@"live_group_info"][@"stock"]];
//            }
//            else
//            {
//                sum_num = [NSString stringWithFormat:@"限量%@万件",[Network notRounding:[model[@"live_group_info"][@"stock"] floatValue] afterPoint:2]];
//            }

                 
                 NSMutableAttributedString *numStr = [[NSMutableAttributedString alloc] initWithString:sum_num];
                           // 需要改变的区间(第一个参数，从第几位起，长度)
                         
                 [numStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, sum_num.length-2)];
                 self.numLab.attributedText = numStr;
              
               self.hostNum.text = [NSString stringWithFormat:@"已报名主播（%@/%@）",model[@"live_group_info"][@"usercount"],model[@"live_group_info"][@"max_usercount"]];
        if ([model[@"live_group_info"][@"max_usercount"] floatValue] > 0) {
             slider.progress = [model[@"live_group_info"][@"usercount"] floatValue]/[model[@"live_group_info"][@"max_usercount"] floatValue];
        }
        else
        {
            slider.progress = 0.0;
        }
             
        
        
        NSArray *arr = model[@"live_group_info"][@"price_json"];
               NSString *price;
               if (arr.count == 1) {
                   price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:arr.firstObject[@"price"]]] ;
               }
               else
               {
                  NSMutableArray *priceArr = [NSMutableArray array];
                    for (NSDictionary *dic in arr) {
                        [priceArr addObject:[Network removeSuffix:dic[@"price"] ]];
                    }
                     CGFloat max =[[priceArr valueForKeyPath:@"@max.floatValue"] floatValue];
                     CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];
                    
                    if (max >= 1000 || min >= 1000) {
                         price =[NSString stringWithFormat:@"¥%@起", [Network removeSuffix:[priceArr valueForKeyPath:@"@min.doubleValue"]]] ;
                    }
                    else
                    {
                         price =[NSString stringWithFormat:@"¥%@~%@", [Network removeSuffix:[priceArr valueForKeyPath:@"@min.doubleValue"]], [Network removeSuffix:[priceArr valueForKeyPath:@"@max.doubleValue"]]] ;
                    }
                    
               }
              
               
                         NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                         // 需要改变的区间(第一个参数，从第几位起，长度)
                         NSRange range = NSMakeRange(0, 1);
                         // 改变字体大小及类型
                         [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                  self.currentPrice.attributedText = noteStr;
              
               NSInteger status = [model[@"live_group_info"][@"get_status"] intValue];
             if (status == 2) {
                 [rightBtn setGradientBackgroundWithColors:@[COLOR_STR(0xD72E51),COLOR_STR(0xDC4761)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
                     rightBtn.text = @"马上拼";
             }
             if (status == 8) {
                 [rightBtn setGradientBackgroundWithColors:@[COLOR_STR(0xEDA0AE),COLOR_STR(0xEDA0AE)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
                 rightBtn.text = @"已报名";
                
             }
             if (status == 9) {
                    [rightBtn setGradientBackgroundWithColors:@[COLOR_STR(0xEDA0AE),COLOR_STR(0xEDA0AE)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
                           rightBtn.text = @"已满员";
                }
             if (status == 1) {
                    [rightBtn setGradientBackgroundWithColors:@[COLOR_STR(0x40B71B),COLOR_STR(0x3EA919)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
                              rightBtn.text = @"即将开始";
                }
               
               if (status != 1) {
                           self.currentPrice.textColor = ThemeRedColor;
                          slider.bgProgressColor = COLOR_STR(0xE6AFAA);
                   NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_group_info"][@"end_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
                          self.dateTime.text =[NSString stringWithFormat:@"报名截止:%@",time ] ;
                      }
                      else
                      {
                           
                          self.currentPrice.textColor = COLOR_STR(0x40B71B);
                           slider.bgProgressColor = COLOR_STR(0xADDB9F);
                          
                          NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_group_info"][@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
                           self.dateTime.text =[NSString stringWithFormat:@"报名开始:%@",time] ;
                         
                      }
               
                NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_group_info"][@"live_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
               self.startTime.text =[NSString stringWithFormat:@"%@ 开播",time ] ;
        
        if ([model[@"good"][@"is_invalid"] intValue] == 1) {

            self.validLab.hidden = NO;

        }
        else
        {

            self.validLab.hidden = YES;
        }
                 
              
    }
    }


@end
