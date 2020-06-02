//
//  ChoosePictureViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/4/18.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "ChoosePictureViewCell.h"

@implementation ChoosePictureViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    return self;
}

-(void)creatView
{

    self.backImg = [UIImageView new];
    [self addSubview:self.backImg];
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(scale(14));
        make.right.mas_equalTo(scale(-14));
         make.height.mas_equalTo(self.backImg.mas_width);
    }];
    self.backImg.image = [UIImage imageNamed:@"add_pic"];

    self.deleBtn = [UIButton new];
    [self addSubview:self.deleBtn];
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backImg.mas_right).offset(0);
        make.centerY.mas_equalTo(self.backImg.mas_top).offset(0);
        make.height.width.mas_equalTo(scale(18));
    }];
    [self.deleBtn setImage:[UIImage imageNamed:@"dele_pic"] forState:UIControlStateNormal];

}
@end
