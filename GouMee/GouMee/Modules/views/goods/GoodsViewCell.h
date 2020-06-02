//
//  GoodsViewCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/11.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *goodsIcon;//商品图片
@property (nonatomic, strong)UILabel *brandLab;//天猫、淘宝
@property (nonatomic, strong)UILabel *goodsName;//商品名字
@property (nonatomic, strong)UILabel *newsPrice;//券后价
@property (nonatomic, strong)UILabel *oldsPrice;//原价
@property (nonatomic, strong)UILabel *saleNum;//月销
@property (nonatomic, strong)UILabel *moneyNum;//佣金
@property (nonatomic, strong)UILabel *couponsLab;//优惠券
@property (nonatomic, strong)UILabel *packageLab;//包邮

-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
