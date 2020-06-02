//
//  OrderListViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "OrderListViewCell.h"

@implementation OrderListViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_STR(0xf5f5f5);
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
    line1.backgroundColor = COLOR_STR(0xf2f2f2);
    self.orderNo = [UILabel new];
    [backView addSubview:self.orderNo];
    [self.orderNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_top).offset(0);
        make.bottom.mas_equalTo(line1.mas_top).offset(0);
        make.left.mas_equalTo(line1.mas_left).offset(0);
    }];
    self.orderNo.textColor = COLOR_STR(0x666666);
    self.orderNo.font= font(12);
    self.orderNo.text = @"1234455";
    
    self.statusLab = [UILabel new];
       [backView addSubview:self.statusLab];
       [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(backView.mas_top).offset(0);
           make.bottom.mas_equalTo(line1.mas_top).offset(0);
           make.right.mas_equalTo(line1.mas_right).offset(0);
       }];
       self.statusLab.textColor = COLOR_STR(0x1B9747);
       self.statusLab.font= font1(@"PingFangSC-Regular", scale(12));
    
       self.statusLab.text = @"待审核";
    
    self.goodsIcon = [UIImageView new];
    [backView addSubview:self.goodsIcon];
    [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(line1.mas_left).offset(0);
        make.bottom.mas_equalTo(backView.mas_bottom).offset(scale(-10));
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
    self.goosName.text = @"babysmile电动牙刷儿童宝宝儿童电动牙电动牙刷儿童宝宝电动牙";
    
    self.timeLab = [UILabel new];
    [backView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodsIcon.mas_bottom).offset(0);
        make.left.mas_equalTo(self.goosName.mas_left).offset(0);
        make.right.mas_equalTo(self.goosName.mas_right).offset(0);
    }];
     self.statusLab.textColor = ThemeRedColor;
    self.timeLab.font = font(13);
    self.timeLab.textColor = COLOR_STR(0x666666);
    self.timeLab.text = @"直播排期：2019-1-11 15:10";
    
}
-(void)addModel:(NSDictionary *)model
{
    self.orderNo.text = model[@"no"];
    NSInteger status = [model[@"status"] intValue];
    switch (status) {
            case 0:
                   {
                       self.statusLab.text = @"待审核";
                   }
             break;
        case 1:
        {
            self.statusLab.text = @"待发货";
        }
            break;
            case 2:
                   {
                       self.statusLab.text = @"已发货";
                   }
                       break;
            case 3:
                   {
                       self.statusLab.text = @"已收货";
                   }
                       break;
            case 4:
                   {
                       self.statusLab.text = @"已取消";
                   }
                       break;
            case 5:
                   {
                       self.statusLab.text = @"未通过";
                   }
                       break;
            case 6:
                             {
                                 self.statusLab.text = @"样品待寄回";
                             }
                                 break;
            case 7:
                             {
                                 self.statusLab.text = @"寄回待确认";
                             }
                                 break;
            case 8:
                             {
                                 self.statusLab.text = @"样品已回收";
                             }
                                 break;
            
        default:
            break;
    }
    self.goosName.text = model[@"good_title"];
   NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"start_time"] andFormatter:@"YYY-MM-dd HH:mm:ss"] andFormatter:@"yyyy.MM.dd HH:mm"];
    if (isNotNull(model[@"good"][@"white_image"])) {
 [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good"][@"white_image"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }
    else
    {
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good_pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    }
    self.timeLab.text = [NSString stringWithFormat:@"直播排期：%@",time];
}
@end
