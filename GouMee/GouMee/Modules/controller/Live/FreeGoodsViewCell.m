//
//  FreeGoodsViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/13.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "FreeGoodsViewCell.h"
#import "MQGradientProgressView.h"
#import "AppDelegate.h"
@interface FreeGoodsViewCell ()
{
    
    UILabel *rightBtn;
    MQGradientProgressView *slider;
}
@end

@implementation  FreeGoodsViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
        UIView *backView = [UIView new];
        [self addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.cornerRadius = 10;
        backView.layer.masksToBounds = YES;
       [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(scale(10));
            make.left.mas_equalTo(scale(15));
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-scale(0));
        }];
        
        self.goodsIcon = [UIImageView new];
        [backView addSubview:self.goodsIcon];
        [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(backView.mas_top).offset(scale(10));
            make.left.mas_equalTo(scale(10));
            make.height.width.mas_equalTo(scale(124));
        }];
        self.goodsIcon.image = [UIImage imageNamed:@"mianfei"];
        self.goodsIcon.layer.cornerRadius =4;
           self.goodsIcon.layer.masksToBounds = YES;
    self.startTime = [UILabel new];
    [self.goodsIcon addSubview:self.startTime];
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(scale(25));
    
    }];
   
    self.startTime.font = font(12);
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
        self.dateTime.text = @"报名截止:1月28日 11:00";
        
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
           slider.progress = 0.35;
        
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

-(void)addModel:(NSDictionary *)model
    {
        
         AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (isNotNull(model[@"good"][@"white_image"])) {
            [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good"][@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
        }
        else
        {
            [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good"][@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
        }
        self.goodsName.text = model[@"good"][@"title"];
        NSDictionary *fuli = model[@"kurangoods"];
       if ([fuli[@"data_source"] integerValue] == 1) {
        NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"good"][@"commission_rate"] floatValue]/100)]]];
         NSString*aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:model[@"good"][@"commission"]]];
        NSString *sum_Money;
        if (app.auditStatus == 0) {
             NSArray *arr = model[@"price_json"];
            if (arr.count == 1) {

                aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([div_Money floatValue]*[arr.firstObject[@"price"] floatValue]/100)]]];
                sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@）",div_Money,aa];
            }
            else
            {
                NSMutableArray *priceArr = [NSMutableArray array];
                for (NSDictionary *dic in arr) {
                    [priceArr addObject:[Network removeSuffix:dic[@"price"]]];
                }

                CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];


                aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",(min*[div_Money floatValue]/100)]]];
                sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@起）",div_Money,aa];
            }

        }
        else
        {
             sum_Money =[NSString stringWithFormat: @"节省%@ (预计¥%@)",div_Money,aa];
        }
           NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
           // 需要改变的区间(第一个参数，从第几位起，长度)
           [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-2, 1)];
           [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-3, 1)];
           [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
           self.moneyLab.attributedText = moneyStr;
       }
        else
        {
            NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([fuli[@"commission_rate"] floatValue]/100)]]];
            NSString*aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:fuli[@"commission"]]];
            NSString *sum_Money;
            if (app.auditStatus == 0) {
                 NSArray *arr = model[@"price_json"];
                if (arr.count == 1) {

                    aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([div_Money floatValue]*[arr.firstObject[@"price"] floatValue]/100)]]];
                    sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@）",div_Money,aa];
                }
                else
                {
                    NSMutableArray *priceArr = [NSMutableArray array];
                    for (NSDictionary *dic in arr) {
                        [priceArr addObject:[Network removeSuffix:dic[@"price"]]];
                    }

                    CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];


                    aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",(min*[div_Money floatValue]/100)]]];
                    sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@起）",div_Money,aa];
                }

            }
            else
            {
                sum_Money =[NSString stringWithFormat: @"节省%@ (预计¥%@)",div_Money,aa];
            }
            NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
            // 需要改变的区间(第一个参数，从第几位起，长度)
            [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-2, 1)];
            [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-3, 1)];
            [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
            self.moneyLab.attributedText = moneyStr;
        }
       
        
        

        
         NSString *div_num =[NSString stringWithFormat:@"%@",model[@"stock"]] ;
        NSString *sum_num;
//        if ([model[@"stock"] integerValue] < 10000) {
            sum_num = [NSString stringWithFormat:@"限量%@件",model[@"stock"]];
//        }
//        else
//        {
//            sum_num = [NSString stringWithFormat:@"限量%@万件",[Network notRounding:[model[@"stock"] floatValue] afterPoint:2]];
//        }

           NSMutableAttributedString *numStr = [[NSMutableAttributedString alloc] initWithString:sum_num];
                     // 需要改变的区间(第一个参数，从第几位起，长度)
                   
           [numStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, sum_num.length-2)];
           self.numLab.attributedText = numStr;
        
         self.hostNum.text = [NSString stringWithFormat:@"已报名主播（%@/%@）",model[@"usercount"],model[@"max_usercount"]];
        slider.progress = [model[@"usercount"] floatValue]/[model[@"max_usercount"] floatValue];
        
         
        NSString *straa =[NSString stringWithFormat:@"¥%@",[Network removeSuffix:model[@"good"][@"zk_final_price"] ]]  ;
          NSMutableAttributedString *strs = [[NSMutableAttributedString alloc] initWithString:straa];
             [strs addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, straa.length)];
       
             self.oldPrice.attributedText = strs;
        
       NSArray *arr = model[@"price_json"];
          NSString *price;
          if (arr.count == 1) {
              price =[NSString stringWithFormat:@"¥%@", [Network removeSuffix:arr.firstObject[@"price"] ]] ;
              NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                           // 需要改变的区间(第一个参数，从第几位起，长度)
                           NSRange range = NSMakeRange(0, 1);
                           // 改变字体大小及类型
              [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                           [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                    self.currentPrice.attributedText = noteStr;
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
                  NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                               // 需要改变的区间(第一个参数，从第几位起，长度)
                               NSRange range = NSMakeRange(0, 1);
                               // 改变字体大小及类型
                               [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                  [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                  [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(price.length-2, 1)];
                   [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:NSMakeRange(price.length-1, 1)];
                        self.currentPrice.attributedText = noteStr;
              }
              else
              {
                   price =[NSString stringWithFormat:@"¥%@~%@", [Network removeSuffix:[priceArr valueForKeyPath:@"@min.doubleValue"]], [Network removeSuffix:[priceArr valueForKeyPath:@"@max.doubleValue"]]] ;
                  NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                               // 需要改变的区间(第一个参数，从第几位起，长度)
                               NSRange range = NSMakeRange(0, 1);
                               // 改变字体大小及类型
                  [noteStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(0, 1)];
                               [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                        self.currentPrice.attributedText = noteStr;
              }
              
              
          }
        NSInteger status = [model[@"get_status"] intValue];
      if (status == 2) {
          [rightBtn setGradientBackgroundWithColors:@[ThemeRedColor,ThemeRedColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
              rightBtn.text = @"马上拼";
          rightBtn.textColor =COLOR_STR(0xffffff);
      }
      if (status == 8) {
          [rightBtn setGradientBackgroundWithColors:@[COLOR_STR1(102, 102, 102, 0.16),COLOR_STR1(102, 102, 102, 0.16)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
          rightBtn.text = @"已报名";
           rightBtn.textColor =COLOR_STR1(102, 102, 102, 0.5);
         
      }
      if (status == 9) {
           [rightBtn setGradientBackgroundWithColors:@[COLOR_STR1(102, 102, 102, 0.16),COLOR_STR1(102, 102, 102, 0.16)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
          rightBtn.textColor =COLOR_STR1(102, 102, 102, 0.5);
                    rightBtn.text = @"已满员";
         }
      if (status == 1) {
             [rightBtn setGradientBackgroundWithColors:@[ThemeGreenColor,ThemeGreenColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
                       rightBtn.text = @"即将开始";
          rightBtn.textColor =COLOR_STR(0xffffff);
         }
        
        if (status != 1) {
                   
                   self.currentPrice.textColor = ThemeRedColor;
             slider.bgProgressColor = COLOR_STR1(51, 51, 51, 0.24);
            self.startTime.backgroundColor = COLOR_STR1(215, 46, 81, 0.61);
            slider.colorArr = @[(id)COLOR_STR1(215, 46, 81, 0.8).CGColor,(id)COLOR_STR1(215, 46, 81, 0.8).CGColor];
            NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"end_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
                   self.dateTime.text =[NSString stringWithFormat:@"报名截止:%@",time ] ;
               }
               else
               {
                    
                   self.currentPrice.textColor = ThemeGreenColor;
                    slider.bgProgressColor = ThemeGreenColor;
                   self.startTime.backgroundColor = COLOR_STR1(15, 183, 78, 0.74);
                   NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
                    self.dateTime.text =[NSString stringWithFormat:@"报名开始:%@",time] ;
                  
               }
        
         NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"MM.dd HH:mm"];
        self.startTime.text =[NSString stringWithFormat:@"%@ 开播",time ] ;
          
        
    }



-(void)addModel1:(NSDictionary *)model
{
     AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
           self.goodsName.text = model[@"title"];
 NSArray *arr = model[@"live_group_info"][@"price_json"];
    NSDictionary *fuli = model[@"kurangoods"];
    if ([fuli[@"data_source"] integerValue] == 1) {
           NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"commission_rate"] floatValue]/100)]]];
     NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:model[@"commission"] ]];
    NSString *sum_Money;
           if (app.auditStatus == 0) {
               if (arr.count == 1) {
      aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([div_Money floatValue]*[arr.firstObject[@"price"] floatValue]/100)]]];
                   sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@）",div_Money,aa];
               }
               else
               {
                   NSMutableArray *priceArr = [NSMutableArray array];
                   for (NSDictionary *dic in arr) {
                       [priceArr addObject:[Network removeSuffix:dic[@"price"]]];
                   }

                   CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];

 aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",min*[div_Money floatValue]/100]]];

                   sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@起）",div_Money,aa];
               }

                  }
                  else
                  {
                       sum_Money =[NSString stringWithFormat: @"节省%@ (预计¥%@)",div_Money,aa];
                  }
           
           
           NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
                     // 需要改变的区间(第一个参数，从第几位起，长度)
                   [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-2, 1)];
     [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-3, 1)];
           [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
           self.moneyLab.attributedText = moneyStr;

    }
    else
    {
        if ([fuli[@"commission"] floatValue] > 0) {

        NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([fuli[@"commission_rate"] floatValue]/100)]]];
        NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:fuli[@"commission"]]];
        NSString *sum_Money;
        if (app.auditStatus == 0) {
            if (arr.count == 1) {



                aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([div_Money floatValue]*[arr.firstObject[@"price"] floatValue]/100)]]];
                sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@）",div_Money,aa];
            }
            else
            {
                NSMutableArray *priceArr = [NSMutableArray array];
                for (NSDictionary *dic in arr) {
                    [priceArr addObject:[Network removeSuffix:dic[@"price"] ]];
                }

                CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];

 aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",(min*[div_Money floatValue]/100)]]];

                sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@起）",div_Money,aa];
            }

        }
        else
        {
            sum_Money =[NSString stringWithFormat: @"节省%@ (预计¥%@)",div_Money,aa];
        }


        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
        // 需要改变的区间(第一个参数，从第几位起，长度)
        [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-2, 1)];
        [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-3, 1)];
        [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
        self.moneyLab.attributedText = moneyStr;
        }
        else
        {
            NSString *div_Money = [NSString stringWithFormat:@"%@%%",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([model[@"commission_rate"] floatValue]/100)]]];
            NSString *aa = [NSString stringWithFormat:@"%@",[Network removeSuffix:model[@"commission"] ]];
            NSString *sum_Money;
            if (app.auditStatus == 0) {
                if (arr.count == 1) {

                     aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",([div_Money floatValue]*[arr.firstObject[@"price"] floatValue]/100)]]];
                    sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@）",div_Money,aa];
                }
                else
                {
                    NSMutableArray *priceArr = [NSMutableArray array];
                    for (NSDictionary *dic in arr) {
                        [priceArr addObject:[Network removeSuffix:dic[@"price"]]];
                    }

                    CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];

  aa= [NSString stringWithFormat:@"%@",[Network removeSuffix:[NSString stringWithFormat:@"%.2f",(min*[div_Money floatValue]/100)]]];
                    sum_Money=[NSString stringWithFormat: @"佣金%@（预计¥%@起）",div_Money,aa];
                }

            }
            else
            {
                sum_Money =[NSString stringWithFormat: @"节省%@ (预计¥%@）",div_Money,aa];
            }


            NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:sum_Money];
            // 需要改变的区间(第一个参数，从第几位起，长度)
            [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-2, 1)];
            [moneyStr addAttribute:NSKernAttributeName value:@(2.0) range:NSMakeRange(sum_Money.length-aa.length-3, 1)];
            [moneyStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(2, div_Money.length)];
            self.moneyLab.attributedText = moneyStr;
        }

    }
    NSString *straa =[NSString stringWithFormat:@"¥%@",[Network removeSuffix:model[@"zk_final_price"]]]  ;
             NSMutableAttributedString *strs = [[NSMutableAttributedString alloc] initWithString:straa];
                [strs addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, straa.length)];
                self.oldPrice.attributedText = strs;
    
    NSString *div_num =[NSString stringWithFormat:@"%@",model[@"live_group_info"][@"stock"]] ;
          NSString *sum_num =[NSString stringWithFormat:@"限量%@件",div_num] ;
             
             
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
                }
                else
                {
                    NSMutableArray *priceArr = [NSMutableArray array];
                    for (NSDictionary *dic in arr) {
                        [priceArr addObject:[Network removeSuffix:dic[@"price"]]];
                    }
                     CGFloat max =[[priceArr valueForKeyPath:@"@max.floatValue"] floatValue];
                     CGFloat min =[[priceArr valueForKeyPath:@"@min.floatValue"] floatValue];
                    
                    if (max >= 1000 || min >= 1000) {
                         price =[NSString stringWithFormat:@"¥%@起", [Network removeSuffix:[priceArr valueForKeyPath:@"@min.doubleValue"]]] ;
                        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                                     // 需要改变的区间(第一个参数，从第几位起，长度)
                                     NSRange range = NSMakeRange(0, 1);
                                     // 改变字体大小及类型
                                     [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                        [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                        [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(price.length-2, 1)];
                         [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:NSMakeRange(price.length-1, 1)];
                              self.currentPrice.attributedText = noteStr;
                    }
                    else
                    {
                         price =[NSString stringWithFormat:@"¥%@~%@", [Network removeSuffix:[priceArr valueForKeyPath:@"@min.doubleValue"]], [Network removeSuffix:[priceArr valueForKeyPath:@"@max.doubleValue"]]] ;
                        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:price];
                                     // 需要改变的区间(第一个参数，从第几位起，长度)
                                     NSRange range = NSMakeRange(0, 1);
                                     // 改变字体大小及类型
                        [noteStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, 1)];
                                     [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:range];
                              self.currentPrice.attributedText = noteStr;
                    }
                    
                    
                }
           NSInteger status = [model[@"live_group_info"][@"get_status"] intValue];
    if (status == 2) {
        [rightBtn setGradientBackgroundWithColors:@[ThemeRedColor,ThemeRedColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        rightBtn.text = @"马上拼";
        rightBtn.textColor =COLOR_STR(0xffffff);
    }
    if (status == 8) {
        [rightBtn setGradientBackgroundWithColors:@[COLOR_STR1(102, 102, 102, 0.16),COLOR_STR1(102, 102, 102, 0.16)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        rightBtn.text = @"已报名";
        rightBtn.textColor =COLOR_STR1(102, 102, 102, 0.5);

    }
    if (status == 9) {
        [rightBtn setGradientBackgroundWithColors:@[COLOR_STR1(102, 102, 102, 0.16),COLOR_STR1(102, 102, 102, 0.16)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        rightBtn.textColor =COLOR_STR1(102, 102, 102, 0.5);
        rightBtn.text = @"已满员";
    }
    if (status == 1) {
        [rightBtn setGradientBackgroundWithColors:@[ThemeGreenColor,ThemeGreenColor] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        rightBtn.text = @"即将开始";
        rightBtn.textColor =COLOR_STR(0xffffff);
    }
                
           
           if (status != 1) {
                       self.currentPrice.textColor = ThemeRedColor;
                self.startTime.backgroundColor = COLOR_STR1(215, 46, 81, 0.61);
                                   slider.bgProgressColor = COLOR_STR1(51, 51, 51, 0.24);
               slider.colorArr = @[(id)COLOR_STR1(215, 46, 81, 0.8).CGColor,(id)COLOR_STR1(215, 46, 81, 0.8).CGColor];
               NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_group_info"][@"end_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
                      self.dateTime.text =[NSString stringWithFormat:@"报名截止:%@",time ] ;
                  }
                  else
                  {
                       
                      self.currentPrice.textColor = ThemeGreenColor;
                                         slider.bgProgressColor = ThemeGreenColor;
                       self.startTime.backgroundColor = COLOR_STR1(15, 183, 78, 0.74);
                      NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_group_info"][@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"YYY.MM.dd HH:mm"];
                       self.dateTime.text =[NSString stringWithFormat:@"报名开始:%@",time] ;
                     
                  }
           
            NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"live_group_info"][@"live_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"MM.dd HH:mm"];
           self.startTime.text =[NSString stringWithFormat:@"%@ 开播",time ] ;
             
          
}



@end
