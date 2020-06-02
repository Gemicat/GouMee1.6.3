//
//  ScheluTimeViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/2.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "ScheluTimeViewCell.h"

@implementation ScheluTimeViewCell

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
  
    UIView *backView = [UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(scale(44));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(scale(3));
        make.left.mas_equalTo(scale(15));
        
    }];
    backView.backgroundColor = COLOR_STR(0xf8f8f8);
    backView.layer.cornerRadius = 6;
    backView.layer.masksToBounds = YES;
    
    UIImageView *leftIcon = [UIImageView new];
    [backView addSubview:leftIcon];
    [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(10));
        make.centerY.mas_equalTo(0);
    }];
    leftIcon.image = [UIImage imageNamed:@"time_ss"];
    self.timeLab = [UILabel new];
    [backView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(leftIcon.mas_right).offset(scale(10));
    }];
    self.timeLab.textColor = COLOR_STR(0x333333);
    self.timeLab.font = font(14);
    
    UIImageView *rightIcon = [UIImageView new];
    [backView addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(scale(-13));
        make.centerY.mas_equalTo(0);
    }];
    rightIcon.image = [UIImage imageNamed:@"next_ss"];
    
    
}

@end
