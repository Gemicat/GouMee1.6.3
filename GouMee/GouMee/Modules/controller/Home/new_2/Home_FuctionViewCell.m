//
//  Home_FuctionViewCell.m
//  GouMee
//
//  Created by 白冰 on 2020/3/5.
//  Copyright © 2020 白冰. All rights reserved.
//

#import "Home_FuctionViewCell.h"

@implementation Home_FuctionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self creatView];
    }
    return self;
}

-(void)creatView
{
    
    
//    UIView *view1 = [UIView new];
//    [self addSubview:view1];
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mas_top).offset(scale(8));
//        make.left.mas_equalTo(self.mas_left).offset(15);
//        make.right.mas_equalTo(self.mas_centerX).offset(-5);
//        make.bottom.mas_equalTo(0);
//    }];
//    self.leftBtn = [UIButton new];
//    [view1 addSubview:self.leftBtn];
//    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(view1.mas_top).offset(1);
//        make.left.mas_equalTo(view1.mas_left).offset(1);
//        make.centerX.mas_equalTo(view1.mas_centerX).offset(0);
//        make.bottom.mas_equalTo(-1);
//    }];
//    self.leftBtn.layer.cornerRadius = 6;
//    self.leftBtn.layer.masksToBounds = YES;

    
//    view1.layer.cornerRadius = 6;                           //圆角弧度
//       view1.layer.shadowOffset =  CGSizeMake(0, 0);           //阴影的偏移量
//       view1.layer.shadowOpacity = 1;                        //阴影的不透明度
//       view1.layer.shadowColor = COLOR_STR1(0, 0, 0, 0.1).CGColor;//阴影的颜色
//
//
//    UIView *view2 = [UIView new];
//       [self addSubview:view2];
//       [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.mas_equalTo(self.mas_top).offset(scale(8));
//                     make.right.mas_equalTo(self.mas_right).offset(-15);
//                     make.left.mas_equalTo(self.mas_centerX).offset(5);
//                     make.bottom.mas_equalTo(0);
//       }];
//    view2.layer.cornerRadius = 6;                           //圆角弧度
//          view2.layer.shadowOffset =  CGSizeMake(0, 0);           //阴影的偏移量
//          view2.layer.shadowOpacity = 1;                        //阴影的不透明度
//          view2.layer.shadowColor = COLOR_STR1(0, 0, 0, 0.1).CGColor;//阴影的颜色
    self.rightBtn = [UIImageView new];
       [self addSubview:self.rightBtn];
       [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(view2.mas_top).offset(1);
//                  make.left.mas_equalTo(view2.mas_left).offset(1);
//                  make.centerX.mas_equalTo(view2.mas_centerX).offset(0);
//                  make.bottom.mas_equalTo(-1);
           make.left.right.top.bottom.mas_equalTo(0);
//           make.top.mas_equalTo(scale(10));
              }];
    _customCellScrollViewDemo = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:self placeholderImage:[UIImage imageNamed:@"goods_bg"]];
    _customCellScrollViewDemo.currentPageDotImage = [UIImage imageNamed:@"banner_select"];
    _customCellScrollViewDemo.pageDotImage = [UIImage imageNamed:@"banner_normal"];

    [self addSubview:_customCellScrollViewDemo];
    self.rightBtn.hidden = NO;
    self.customCellScrollViewDemo.hidden = NO;
}
-(void)addModel:(NSDictionary *)model
{
    self.selectModel = model;
    CGFloat height = [model[@"height"] intValue];
    CGFloat width = [model[@"width"] intValue];
    _customCellScrollViewDemo.frame = CGRectMake(0, 0, SW-scale(30), (SW-scale(30))*height/width);

    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *models in model[@"items"]) {
        [arr addObject:models[@"imgUrl"]];
    }
    _customCellScrollViewDemo.imageURLStringsGroup = arr;

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    if (self.click) {
        NSDictionary *m = self.selectModel[@"items"][index];
        self.click(m);
    }

}
@end
