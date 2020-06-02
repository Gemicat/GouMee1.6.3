//
//  ServiceMessageViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "ServiceMessageViewCell.h"
#import "DateTranslate.h"
@implementation ServiceMessageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

if (self) {
    self.contentView.backgroundColor = viewColor;
    [self creatCell];
}
    return self;
}
-(void)creatCell
{
     self.timeLab = [UILabel new];
      [self addSubview:self.timeLab];
      _timeLab.textColor = COLOR_STR(0x999999);
    
      _timeLab.font = font1(@"PingFangSC-Medium", scale(12));
      [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.mas_equalTo(0);
          make.top.mas_equalTo(0);
          make.height.mas_equalTo(scale(44));
      }];
      UIView *backView = [UIView new];
      [self addSubview:backView];
      [backView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.bottom.mas_equalTo(0);
          make.top.mas_equalTo(_timeLab.mas_bottom).offset(0);
          make.left.mas_equalTo(scale(12));
          make.centerX.mas_equalTo(0);
      }];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = scale(6);
    backView.layer.masksToBounds = YES;
    
    UIView *topView = [UIView new];
       [backView addSubview:topView];
       [topView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(0);
           make.left.mas_equalTo(scale(0));
           make.centerX.mas_equalTo(0);
           make.height.mas_equalTo(scale(44));
       }];
       topView.backgroundColor = COLOR_STR(0xFBFBFB);
    
    self.titleType = [UILabel new];
    [topView addSubview:self.titleType];
    [self.titleType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(topView.mas_left).offset(scale(12));
    }];
    self.titleType.textColor = COLOR_STR(0x333333);
    self.titleType.font = font1(@"PingFangSC-Semibold", scale(16));
    self.titleType.text = @"拼播组团失败";
    self.context = [UILabel new];
       self.context.textColor = ThemeRedColor;
       self.context.numberOfLines = 0;
       self.context.font = font(14);
       [backView addSubview:self.context];
       [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(topView.mas_bottom).offset(scale(14));
           make.left.mas_equalTo(scale(15));
           make.centerX.mas_equalTo(0);
       }];
    
    self.goodsView = [UIView new];
    [backView addSubview:self.goodsView];
    [self.goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.context.mas_bottom).offset(scale(12));
        make.left.mas_equalTo(backView.mas_left).offset(scale(15));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(scale(60));
    }];
    self.goodsView.layer.cornerRadius = 6;
    self.goodsView.layer.masksToBounds = YES;
    self.goodsView.backgroundColor = COLOR_STR(0xF8F8F8);
    
    self.goodsIcon = [UIImageView new];
    [self.goodsView addSubview:self.goodsIcon];
    [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.goodsIcon.mas_height);
    }];
    self.goodsIcon.image = [UIImage imageNamed:@"sucai1"];
    
    self.goodsName = [UILabel new];
    [self.goodsView addSubview:self.goodsName];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.goodsIcon.mas_right).offset(scale(12));
        make.right.mas_equalTo(self.goodsView.mas_right).offset(scale(-12));
    }];
    self.goodsName.textColor = COLOR_STR(0x333333);
    self.goodsName.font = font(14);
    self.goodsName.text = @"得衣岩 80支精纺无缝羊绒衫女 秋冬超薄高领修身针织打底修身针织打";
    self.goodsName.numberOfLines = 2;
    self.line = [UIView new];
       [backView addSubview:self.line];
       [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.goodsView.mas_bottom).offset(scale(12));
           make.left.mas_equalTo(self.goodsView.mas_left).offset(0);
           make.centerX.mas_equalTo(0);
           make.height.mas_equalTo(scale(0.5));
       }];
       self.line.backgroundColor = COLOR_STR1(0, 0, 0, 0.08);
       
       self.statusLab = [UILabel new];
       [backView addSubview:self.statusLab];
       [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.line.mas_bottom).offset(scale(12));
           make.left.mas_equalTo(self.line.mas_left).offset(0);
       }];
       self.statusLab.textColor = ThemeRedColor;
       self.statusLab.font = font(14);
       self.statusLab.text = @"拼播组团失败";
    self.rightIcon = [UIImageView new];
       [topView addSubview:self.rightIcon];
       [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(topView.mas_centerY).offset(0);
           make.right.mas_equalTo(topView.mas_right).offset(scale(-12));
       }];
       self.rightIcon.image = [UIImage imageNamed:@"next_ss"];
       
       self.nextBtn = [UIButton new];
       [topView addSubview:self.nextBtn];
       [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(topView.mas_centerY).offset(0);
           make.right.mas_equalTo(self.rightIcon.mas_left).offset(scale(-3));
       }];
       [self.nextBtn setTitleColor:COLOR_STR(0x666666) forState:UIControlStateNormal];
       self.nextBtn.titleLabel.font = font(14);
    [self.nextBtn setTitle:@"订单详情" forState:UIControlStateNormal];
  
}
-(void)addModel:(NSDictionary *)model
{
    
   
       CGFloat h = scale(44);
        CGSize baseSize = CGSizeMake(SW-scale(54), CGFLOAT_MAX);
    NSString *time = [Network timestampSwitchTime:[model[@"create_time"] integerValue] andFormatter:@"YYYY.MM.dd HH:mm"];
         _timeLab.text = [DateTranslate formateDate:time withFormate:@"YYYY.MM.dd HH:mm"];
    self.titleType.text = model[@"title"];
    self.statusLab.text = model[@"content"];
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model[@"good_pict_url"]] placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    self.goodsName.text = model[@"good_title"];
    
    if ([model[@"refused"] intValue] == 1) {
        self.context.textColor = ThemeRedColor;
        self.rightIcon.hidden = YES ;
              self.nextBtn.hidden = YES ;
    }
    else
    {
        self.context.textColor = COLOR_STR(0x333333);
        self.rightIcon.hidden = NO;
        self.nextBtn.hidden = NO;
    }
    
    
    
    
    
       if (isNotNull(model[@"refuse_content"])) {
          
            self.context.text = model[@"refuse_content"];
           CGSize labelsize = [self.context sizeThatFits:baseSize];
                   CGSize labelsize1 = [self.statusLab sizeThatFits:baseSize];
                        h =h+ scale(44)+scale(15)+scale(12)+scale(60)+scale(12)+scale(0.5)+scale(12)+scale(12)+labelsize.height+labelsize1.height;
       }
    else
    {

        if (isNotNull(model[@"content"])) {
           self.statusLab.hidden = YES;
              self.line.hidden = YES;
            self.context.text = model[@"content"];
            CGSize labelsize1 = [self.context sizeThatFits:baseSize];
            h =h+ scale(44)+scale(15)+scale(12)+scale(60)+scale(12)+scale(0.5)+labelsize1.height;
        }
        else
        {
        [self.context mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.height.mas_equalTo(0);
                         }];
                         [self.goodsView mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.top.mas_equalTo(self.context.mas_top).offset(0);
                         }];
                         self.line.hidden = YES;
                         self.statusLab.hidden = YES;
                         h =h+ scale(44)+scale(12)+scale(60)+scale(12);

        }
    }
    
    
    _cellH = h;
    
}
-(CGFloat)height
{
    return _cellH;
}

@end
