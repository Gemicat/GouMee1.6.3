//
//  Goumee_AddressViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Goumee_AddressViewCell.h"

@implementation Goumee_AddressViewCell

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
    self.leftIcon = [UIImageView new];
    [self addSubview:self.leftIcon];
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(scale(15));
        make.width.height.mas_equalTo(scale(18));
    }];
    self.leftIcon.image = [UIImage imageNamed:@"address_icon"];
    
    self.editBtn = [UIButton new];
    [self addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(scale(40));
        make.right.mas_equalTo(self.mas_right).offset(scale(-10));
        
    }];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = font(12);
    
    self.name = [UILabel new];
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(11));
        make.left.mas_equalTo(self.leftIcon.mas_right).offset(scale(15));
    }];
    self.name.font =font1(@"PingFangSC-Medium", scale(12));
    self.name.textColor = COLOR_STR(0x333333);
    
    self.address = [UILabel new];
       [self addSubview:self.address];
       [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.name.mas_bottom).offset(scale(0));
           make.left.mas_equalTo(self.leftIcon.mas_right).offset(scale(15));
           make.right.mas_equalTo(self.editBtn.mas_left).offset(scale(-15));
       }];
       self.address.font =font1(@"PingFangSC-Thin", scale(12));
       self.address.textColor = COLOR_STR(0x333333);
    self.address.numberOfLines = 2;
    
    self.type = [UILabel new];
    [self addSubview:self.type];
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.name.mas_centerY).offset(0);
        make.left.mas_equalTo(self.name.mas_right).offset(scale(10));
    }];
    self.type.backgroundColor = COLOR_STR(0xD72E51);
    self.type.text = @" 默认 ";
    self.type.font = font(10);
    self.type.layer.cornerRadius = 2.5;
    self.type.layer.masksToBounds = YES;self.type.textColor = [UIColor whiteColor];
    UIView *line = [UIView new];
    [self addSubview:line];
    line.backgroundColor = COLOR_STR(0xf2f2f2);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    self.name.text = @"张三  130098982837";
    self.address.text = @"浙江省杭州市滨江区江南大道但是你不会减肥 v 黄金时代看就是 v 比较好";
    
}
-(void)addModel:(NSDictionary *)model
{
    self.name.text = [NSString stringWithFormat:@"%@   %@",model[@"realname"],model[@"mobile"]];
    self.address.text = [NSString stringWithFormat:@"%@%@%@%@",model[@"province"],model[@"city"],model[@"area"],model[@"address"]];
    
    if ([model[@"is_default"] intValue] == 1) {
        self.type.hidden = NO;
    }
    else
    {
        self.type.hidden = YES;
    }
    
}
-(void)setChooseBool:(NSInteger)chooseBool
{
    if (chooseBool == 1) {
        [self.leftIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
                   make.left.mas_equalTo(scale(15));
                   make.width.height.mas_equalTo(scale(18));
        }];
    }
    else
    {
       [self.leftIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(scale(0));
            make.width.height.mas_equalTo(scale(0));
        }];
    
    }
    
}
@end
