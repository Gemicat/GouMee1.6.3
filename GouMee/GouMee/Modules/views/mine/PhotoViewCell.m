//
//  PhotoViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/1/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.backView = [UIImageView new];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(0));
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-40);
        make.right.mas_equalTo(-15);
    }];
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = COLOR_STR(0xffffff);
    self.backView.contentMode = UIViewContentModeScaleAspectFit;
//    self.tips = [UILabel new];
//    [self addSubview:self.tips];
//    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.backView.mas_bottom).offset(0);
//        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
//        make.centerX.mas_equalTo(0);
//    }];
//    self.tips.textColor = COLOR_STR(0xF29537);
//    self.tips.text = @"重新拍摄";
//    self.tips.hidden = YES;
//    self.tips.font = font1(@"PingFangSC-Regular", scale(10));
}

@end
