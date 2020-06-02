//
//  StoreDetailViewCell.m
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import "StoreDetailViewCell.h"

@implementation StoreDetailViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self drawSubviews];
    }
    return self;
}

- (void)drawSubviews {
    
    UIView *line = [UIView new];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(10));
        make.top.mas_equalTo(10);
    }];
    line.backgroundColor = viewColor;
//     self.typeLab = [UILabel new];
//        [self addSubview:self.typeLab];
//        [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.mas_top).offset(0);
//            make.left.mas_equalTo(line.mas_left).offset(15);
//            make.centerX.mas_equalTo(0);
//            make.bottom.mas_equalTo(line.mas_top).offset(0);
//        }];
//        self.typeLab.textColor = COLOR_STR(0x999999);
//        self.typeLab.font = font(12);
//        self.typeLab.text = @"";
//    line.backgroundColor = COLOR_STR(0xf2f2f2);
    self.storeView = [[StoreDetailView alloc]initWithFrame:CGRectMake(0, scale(18), SW, scale(70))];
    self.storeView.isCircle = NO;
    [self.contentView addSubview:self.storeView];
}
-(void)addModel:(NSDictionary *)model
{
    self.storeView.StoreModel = model;
//    self.typeLab.text =[NSString stringWithFormat:@"%@>%@",model[@"level_one_category_name"],model[@"category_name"]];
}
@end
