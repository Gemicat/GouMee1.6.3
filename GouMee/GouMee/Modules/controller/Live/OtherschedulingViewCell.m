//
//  OtherschedulingViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/2.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "OtherschedulingViewCell.h"

@interface OtherschedulingViewCell ()
{
    UILabel *tips;
}

@end

@implementation OtherschedulingViewCell

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
  

    
    _bomLine = [UIView new];
    [self addSubview:_bomLine];
    [_bomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(scale(0));
        make.height.mas_equalTo(scale(10));
    }];
    _bomLine.backgroundColor = viewColor;

    self.moneyLab = [UILabel new];
    [self addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bomLine.mas_bottom).offset(scale(10));
        make.left.mas_equalTo(self.mas_left).offset(scale(15));
    }];
    self.moneyLab.font =font(12);
    self.moneyLab.text = @"";
    self.moneyLab.textColor = COLOR_STR(0x999999);
    
    tips = [UILabel new];
       [self addSubview:tips];
       [tips mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(_bomLine.mas_bottom).offset(scale(0));
           make.left.mas_equalTo(scale(12));
           make.height.mas_equalTo(scale(40));
       }];

       tips.textColor = COLOR_STR(0x333333);
       tips.font = font1(@"PingFangSC-Medium", scale(16));
    
    
    _moreBtn = [UIButton new];
    [self addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(tips.mas_centerY).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(scale(-30));
        
    }];
    [_moreBtn setTitle:@"更多排期" forState:UIControlStateNormal];
     [_moreBtn setTitle:@"收起排期" forState:UIControlStateSelected];
     [_moreBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleRight imageTitleSpace:0];
    [_moreBtn setTitleColor:COLOR_STR(0x666666) forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = font(12);
    [_moreBtn setImage:[UIImage imageNamed:@"time_up"] forState:UIControlStateNormal];
    [_moreBtn setImage:[UIImage imageNamed:@"time_down"] forState:UIControlStateSelected];
    
}
-(void)addModel:(NSDictionary *)model
{
//   if (isNotNull(model[@"good"][@"coupon_amount"])) {
//       NSString *num = [Network removeSuffix:[NSString stringWithFormat:@"%.2f",[model[@"good"][@"coupon_amount"] floatValue]]];
//           if ([model[@"good"][@"coupon_remain_count"] intValue] > 0) {
//
//                NSString *time = [Network timestampSwitchTime:[Network timeSwitchTimestamp:model[@"good"][@"coupon_end_time"] andFormatter:@"YYY-MM-dd"] andFormatter:@"YYY.MM.dd"];
//       _moneyLab.text =[NSString stringWithFormat:@" 优惠券%@元(%@过期，剩余%@张)",num,time,model[@"good"][@"coupon_remain_count"]] ;
//       NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:_moneyLab.text];
//       [attriStr addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(4, num.length)];
//       /**
//        添加图片到指定的位置
//        */
//       NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
//       // 表情图片
//       attchImage.image = [UIImage imageNamed:@"coupon_bg"];
//       // 设置图片大小
//       attchImage.bounds = CGRectMake(0, 0, 12, 9);
//       NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
//       [attriStr insertAttributedString:stringImage atIndex:0];
//       _moneyLab.attributedText = attriStr;
//               CGSize baseSize = CGSizeMake(SW-scale(30), CGFLOAT_MAX);
//                  CGSize labelsize = [_moneyLab sizeThatFits:baseSize];
//               _cellHeight = scale(15)+labelsize.height;
//       }
//       }
//     else
//     {
    

//     }
}
-(void)addModel1:(NSMutableArray *)array addModel2:(nonnull NSDictionary *)model
{
    if (array.count  > 0) {
         tips.text = @"该商品其他排期";
         _bomLine.hidden = NO;
        [_bomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_top).offset(scale(10));
            make.height.mas_equalTo(scale(10));
        }];
        _cellHeight = _cellHeight+scale(68);
        _moneyLab.text = @"";

    }
    else
    {
        tips.text = @"";
        _moneyLab.text = @"";
        NSDictionary *fuli = model[@"kurangoods"];
        _cellHeight = scale(15);
            _bomLine.hidden = NO;

    }
}
-(CGFloat)height
{
    return _cellHeight;
}
@end
