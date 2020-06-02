//
//  SellPointViewCells.m
//  GouMee
//
//  Created by 白冰 on 2020/4/15.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "SellPointViewCells.h"

@implementation SellPointViewCells
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

    _tips = [UILabel new];
    [self addSubview:_tips];
    [_tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(0));
        make.left.mas_equalTo(scale(12));
        make.height.mas_equalTo(scale(40));
    }];
    _tips.textColor = COLOR_STR(0x333333);
    _tips.font = font1(@"PingFangSC-Medium", scale(16));

    self.contextLab = [UILabel new];
    [self addSubview:self.contextLab];
    self.contextLab.numberOfLines = 0;
    self.contextLab.textColor = COLOR_STR(0x333333);
    self.contextLab.font = font(14);

    [self.contextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tips.mas_bottom).offset(0);
        make.left.mas_equalTo(_tips.mas_left).offset(0);
        make.centerX.mas_equalTo(0);

    }];

    _bomLine = [UIView new];
    [self addSubview:_bomLine];
    [_bomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.contextLab.mas_bottom).offset(scale(10));
        make.height.mas_equalTo(scale(8));
    }];
    _bomLine.backgroundColor = viewColor;

}
-(void)addModel:(NSDictionary *)model
{

    if (isNotNull(model[@"sell_point"])) {
        _tips.text = @"产品卖点";

        self.contextLab.text = model[@"sell_point"];
        CGSize baseSize = CGSizeMake(SW-scale(30), CGFLOAT_MAX);
        CGSize labelsize = [self.contextLab sizeThatFits:baseSize];
        CGFloat h = 0;
        _bomLine.hidden = NO;
        h = scale(40)+labelsize.height+scale(18);
        _cellHeight = h;
    }
    else
    {
        self.contextLab.text = @"";
        self.tips.text = @"";
        _bomLine.hidden = YES;
        _cellHeight = 0;
    }


}
-(CGFloat)height
{
    return _cellHeight;
}
@end
