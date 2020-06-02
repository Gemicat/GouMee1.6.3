//
//  SetViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/2/19.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "SetViewCell.h"

@implementation SetViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {

        [self creatCell];
    }
    return self;
}
-(void)creatCell
{

    self.backgroundColor = COLOR_STR(0xffffff);
    self.name = [UILabel new];
    [self addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    self.name.textColor = COLOR_STR(0x3D3D3D);
    self.name.font =font(14);

   _line = [UIView new];
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(1);
    }];
    _line.backgroundColor =COLOR_STR(0xebebeb);
    self.line.hidden = YES;
    _rightBtn = [UIImageView new];
    [self addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(scale(-16));
        make.centerY.mas_equalTo(0);
    }];
    _rightBtn.image = [UIImage imageNamed:@"hahaha_ss"];

    self.context = [UILabel new];
    [self addSubview:self.context];
    self.context.hidden = YES;
    [self.context mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(scale(-16));
        make.centerY.mas_equalTo(0);
    }];
    self.context.text = @"版本1.6.3";
    self.context.textColor = COLOR_STR(0x999999);
    self.context.font =font(12);


}

@end
