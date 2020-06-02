//
//  HomeGoodsViewCell.h
//  KuRanApp
//
//  Created by 白冰 on 2020/2/10.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeGoodsViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *goodsIcon;
@property (nonatomic, strong)UILabel *currentPrice;
@property (nonatomic, strong)UIButton *moneyLab;
@property (nonatomic, strong)UILabel *goodsName;
@property (nonatomic, strong)UILabel *salesNum;
@property (nonatomic, strong)UILabel *oldPrice;
@property (nonatomic, strong)UILabel *couponsLab;
@property (nonatomic, strong)UILabel *markLab;
-(void)addModel:(NSDictionary *)model;


@end

NS_ASSUME_NONNULL_END
