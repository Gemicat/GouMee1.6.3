//
//  LiveStoreViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "LiveStoreViewCell.h"

@interface LiveStoreViewCell ()
{
    UIView *line;
}

@end

@implementation LiveStoreViewCell

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

//    self.typeLab = [UILabel new];
//    [self addSubview:self.typeLab];
//    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(line.mas_bottom).offset(scale(10));
//        make.left.mas_equalTo(scale(15));
//        make.centerX.mas_equalTo(0);
//    }];
//    self.typeLab.textColor = COLOR_STR(0x999999);
//    self.typeLab.font = font(12);
//    self.typeLab.text = @"个护工具 ＞美容美体仪器＞口腔电子/智能产品";
    
    UIView *centerViews = [UIView new];
    [self addSubview:centerViews];
    centerViews.backgroundColor = [UIColor whiteColor];
    [centerViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(scale(124));
    }];
    
    UILabel *tips = [UILabel new];
    [centerViews addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scale(12));
        make.left.mas_equalTo(scale(12));
    }];
    tips.text = @"拼播流程";
    tips.textColor = COLOR_STR(0x333333);
    tips.font = font1(@"PingFangSC-Medium", scale(16)); 
    
    UIImageView *rightIcon = [UIImageView new];
    [centerViews addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(scale(-13));
        make.centerY.mas_equalTo(tips.mas_centerY).offset(0);
    }];
    rightIcon.image = [UIImage imageNamed:@"rule_ss"];
    
    
    UIImageView *liuView = [UIImageView new];
    [centerViews addSubview:liuView];
    [liuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scale(12));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(tips.mas_bottom).offset(scale(16));
        make.bottom.mas_equalTo(scale(-12));
    }];
    liuView.image = [UIImage imageNamed:@"liucheng"];
    liuView.userInteractionEnabled= YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(acc)];
    [liuView addGestureRecognizer:tap];
    
    rightIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(acc)];
      [rightIcon addGestureRecognizer:tap1];
    
    
    UIView *lines = [UIView new];
    [self addSubview:lines];
    [lines mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(centerViews.mas_bottom).offset(scale(0));
           make.left.right.mas_equalTo(0);
           make.height.mas_equalTo(scale(10));
       }];
       lines.backgroundColor = viewColor;
   
    self.storeView = [[StoreDetailView alloc]initWithFrame:CGRectMake(0, scale(144), SW, 82)];
    self.storeView.isCircle = NO;
    self.storeView.backgroundColor = viewColor;
    [self addSubview:self.storeView];
    
    
}
-(void)acc
{
    
    if (self.clickAction) {
        self.clickAction(0);
    }
}
-(void)addModel:(NSDictionary *)model
{
   
    self.storeView.StoreModel = model[@"good"];
  
       CGFloat h = scale(144);
    if (self.click) {
        self.click(h+72);
    }
}

@end
