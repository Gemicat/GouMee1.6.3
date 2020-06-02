//
//  FilterChooseCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/13.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "FilterChooseCell.h"
#import "UIView+Gradient.h"
@implementation FilterChooseCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.nameLab = [UILabel new];
    [self.contentView addSubview:self.nameLab];
    self.markLab = [UIImageView new];
    [self.nameLab addSubview:self.markLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(scale(35));
    }];
    self.nameLab.backgroundColor = COLOR_STR(0xe6e6e6);
    self.nameLab.layer.cornerRadius = scale(2.5);
    self.nameLab.layer.masksToBounds = YES;
    self.nameLab.textColor = COLOR_STR(0x333333);
    self.nameLab.font = font(11);
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.text = @"10元以下";
    
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.nameLab.mas_bottom).offset(0);
        make.right.mas_equalTo(self.nameLab.mas_right).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    self.markLab.image = [UIImage imageNamed:@"select_bg"];
    self.markLab.hidden = YES;
   
}
@end
