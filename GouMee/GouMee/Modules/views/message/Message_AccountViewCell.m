//
//  Message_AccountViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Message_AccountViewCell.h"
#import "DateTranslate.h"
@implementation Message_AccountViewCell

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
    
   self.moneyLab = [UILabel new];
   [backView addSubview:self.moneyLab];
   self.moneyLab.textColor = COLOR_STR(0x999999);
      self.moneyLab.font = font(14);
      self.moneyLab.text = @"";
   [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(topView.mas_bottom).offset(scale(12));
       make.left.mas_equalTo(scale(15));
       make.width.mas_equalTo(scale(70));
   }];
    
    self.applyType = [UILabel new];
    [backView addSubview:self.applyType];
    self.applyType.textColor = COLOR_STR(0x333333);
       self.applyType.font = font(14);
       self.applyType.text = @"";
    [self.applyType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.moneyLab.mas_bottom).offset(scale(4));
        make.left.mas_equalTo(self.moneyLab.mas_right).offset(0);
        make.right.mas_equalTo(topView.mas_right).offset(scale(-12));
    }];
    
    
    self.statusLabs = [UILabel new];
       [backView addSubview:self.statusLabs];
       self.statusLabs.textColor = COLOR_STR(0x999999);
          self.statusLabs.font = font(14);
          self.statusLabs.text = @"";
       [self.statusLabs mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.moneyLab.mas_bottom).offset(scale(6));
           make.left.mas_equalTo(scale(15));
           make.width.mas_equalTo(scale(70));
       }];
    
    self.applyStatus = [UILabel new];
    [backView addSubview:self.applyStatus];
    self.applyStatus.textColor = COLOR_STR(0x333333);
       self.applyStatus.font = font(14);
       self.applyStatus.text = @"";
    [self.applyStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statusLabs.mas_top).offset(scale(0));
        make.left.mas_equalTo(self.statusLabs.mas_right).offset(0);
        make.right.mas_equalTo(topView.mas_right).offset(scale(-12));
    }];
    
    self.resultLab = [UILabel new];
       self.resultLab.textColor = COLOR_STR(0x999999);
       self.resultLab.numberOfLines = 0;
       self.resultLab.font = font(14);
       self.resultLab.text = @"";
       [backView addSubview:self.resultLab];
       [self.resultLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.applyStatus.mas_bottom).offset(scale(6));
           make.left.mas_equalTo(scale(15));
           make.width.mas_equalTo(scale(70));
       }];
    
    
    self.context = [UILabel new];
    self.context.textColor = COLOR_STR(0x333333);
    self.context.numberOfLines = 0;
    self.context.font = font(14);
    self.context.text = @"";
    [backView addSubview:self.context];
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.resultLab.mas_top).offset(scale(0));
        make.left.mas_equalTo(self.resultLab.mas_right).offset(scale(0));
        make.right.mas_equalTo(topView.mas_right).offset(scale(-12));
    }];
    
       self.context.textColor = COLOR_STR(0x333333);
       self.context.numberOfLines = 0;
       self.context.font = font(14);
       self.context.text = @"";
       [backView addSubview:self.context];
     
    
    
    self.line = [UIView new];
    [backView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.context.mas_bottom).offset(scale(12));
        make.left.mas_equalTo(topView.mas_left).offset(scale(15));
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
    self.statusLab.text = @"";
    
    
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
    self.titleType = [UILabel new];
       [topView addSubview:self.titleType];
       [self.titleType mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.mas_equalTo(0);
           make.left.mas_equalTo(topView.mas_left).offset(scale(12));
           make.right.mas_equalTo(self.mas_centerX).offset(10);
       }];
       self.titleType.textColor = COLOR_STR(0x333333);
       self.titleType.font = font1(@"PingFangSC-Semibold", scale(16));
       self.titleType.text = @"";
    
}
-(void)addModel:(NSDictionary *)model
{
    NSInteger status = [model[@"account_type"] intValue];
     NSInteger refuse = [model[@"refused"] boolValue];
    CGFloat h = scale(44);
     CGSize baseSize = CGSizeMake(SW-scale(54), CGFLOAT_MAX);
     self.titleType.text = model[@"title"];
    NSString *time = [Network timestampSwitchTime:[model[@"create_time"] integerValue] andFormatter:@"YYYY.MM.dd HH:mm"];
       _timeLab.text = [DateTranslate formateDate:time withFormate:@"YYYY.MM.dd HH:mm"];
    if (status == 1 && refuse == 0) {
        //实名认证完成
       
        [self.resultLab mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.width.mas_equalTo(0);
               }];
        [self.applyType mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.applyStatus mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        self.resultLab.text = @"";
        [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.applyType.mas_top).offset(0);
          
        }];
        self.resultLab.text = @"";
        self.line.hidden = YES;
        self.rightIcon.hidden = YES;
                  self.nextBtn.hidden = YES;
        self.statusLabs.hidden = YES;
        self.context.text = model[@"content"];
        self.context.textColor = COLOR_STR(0x333333);
        CGSize labelsize = [self.context sizeThatFits:baseSize];
        h = h+scale(44)+scale(12)+scale(20)+labelsize.height;
    }
    else if (status == 1 && refuse == 1)
    {
        //实名认证未通过
        self.resultLab.text = @"";
        [self.resultLab mas_updateConstraints:^(MASConstraintMaker *make) {
                          make.width.mas_equalTo(0);
                      }];
        [self.applyType mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.applyStatus mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.applyType.mas_top).offset(0);
        }];
        self.line.hidden = NO;
        self.rightIcon.hidden = NO;
                  self.nextBtn.hidden = NO;
        self.statusLab.hidden = NO;
        [self.nextBtn setTitle:@"重新认证" forState:UIControlStateNormal];
       
        self.context.text = model[@"refuse_content"];
        self.statusLab.text = model[@"content"];
        self.context.textColor = ThemeRedColor;
        CGSize labelsize = [self.context sizeThatFits:baseSize];
        CGSize labelsize1 = [self.statusLab sizeThatFits:baseSize];
               h = h+scale(44)+scale(12)+scale(20)+labelsize.height+scale(24.5)+labelsize1.height;
    }
    else if (status == 2 && refuse == 0)
       {
           //提现申请已处理
           [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(0);
           }];
           self.line.hidden = YES;
           self.rightIcon.hidden = YES;
           self.nextBtn.hidden = YES;
           self.statusLab.hidden = YES;
           self.moneyLab.text = @"申请提现：";
                      self.statusLabs.text = @"申请状态：";
           self.applyType.text =[NSString stringWithFormat:@"¥%.2f",[model[@"phrase"] floatValue]] ;
           self.applyStatus.text =[NSString stringWithFormat:@"%@",model[@"content"]];
           NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.applyType.text];
                            
           [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:NSMakeRange(0,1)];
            [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Semibold", scale(18)) range:NSMakeRange(1,_applyType.text.length-1)];
           
           self.applyType.attributedText = noteStr;

           CGSize labelsize = [self.applyStatus sizeThatFits:baseSize];
            CGSize labelsize1 = [self.applyType sizeThatFits:baseSize];
                h =h+ scale(44)+scale(12)+scale(12)+labelsize.height+labelsize1.height;
       }
    else if (status == 2 && refuse == 1)
       {
           //提现处理未通过
           [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(self.applyStatus.mas_bottom).offset(scale(12));
           }];
           self.line.hidden = NO;
           self.statusLab.hidden = NO;
           self.moneyLab.text = @"申请提现：";
            self.statusLabs.text = @"申请状态：";
          self.applyType.text =[NSString stringWithFormat:@"¥%.2f",[model[@"phrase"] floatValue]] ;
           self.applyStatus.text =[NSString stringWithFormat:@"%@",model[@"content"]];
           self.rightIcon.hidden = YES;
            self.nextBtn.hidden = YES;
           self.context.textColor = ThemeRedColor;
           self.resultLab.text = @"原因：";
                  self.context.text = [NSString stringWithFormat:@"%@",model[@"refuse_content"]];
                  self.statusLab.text = model[@"content"];
           NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.applyType.text];
                                      
                     [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:NSMakeRange(0,1)];
                      [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Semibold", scale(18)) range:NSMakeRange(1,_applyType.text.length-1)];
                     
                     self.applyType.attributedText = noteStr;
                      CGSize baseSize1 = CGSizeMake(SW-scale(124), CGFLOAT_MAX);
           CGSize labelsize = [self.applyStatus sizeThatFits:baseSize];
                      CGSize labelsize1 = [self.applyType sizeThatFits:baseSize];
           CGSize labelsize2 = [self.applyStatus sizeThatFits:baseSize];
                CGSize labelsize3 = [self.context sizeThatFits:baseSize1];
            h =h+ scale(44)+scale(24)+scale(6)+labelsize.height+labelsize1.height+labelsize2.height+labelsize3.height+scale(20);
           
       }
 
        else if (status == 3)
           {
               //实名认证未通过
        
              [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
                             make.height.mas_equalTo(0);
                }];
                         self.line.hidden = YES;
                         self.statusLab.hidden = YES;
               self.moneyLab.text = @"结算金额：";
               self.statusLabs.text = @"结算状态：";
               self.resultLab.text = @"";
               
             self.applyType.text =[NSString stringWithFormat:@"¥%.2f",[model[@"phrase"] floatValue]] ;
               self.applyStatus.text =[NSString stringWithFormat:@"%@",model[@"content"]];
               self.rightIcon.hidden = NO;
                         self.nextBtn.hidden = NO;
                 [self.nextBtn setTitle:@"查看余额" forState:UIControlStateNormal];
               NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.applyType.text];
                                    
                         [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Regular", scale(13)) range:NSMakeRange(0,1)];
                          [noteStr addAttribute:NSFontAttributeName value:font1(@"PingFangSC-Semibold", scale(18)) range:NSMakeRange(1,_applyType.text.length-1)];
                         
                         self.applyType.attributedText = noteStr;
                         
                      
                CGSize labelsize = [self.applyStatus sizeThatFits:baseSize];
                           CGSize labelsize1 = [self.applyType sizeThatFits:baseSize];
                               h = h+scale(44)+scale(12)+scale(12)+labelsize.height+labelsize1.height;
           }
    
    
  
    self.cellH = h;
    
}
-(CGFloat)height
{
    return self.cellH;
}
@end
