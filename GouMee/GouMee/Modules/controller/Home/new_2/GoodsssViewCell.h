//
//  GoodsssViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/2/11.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsssViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *goodIcon;
@property (nonatomic, strong)UILabel  *goodsName;
@property (nonatomic, strong)UILabel *oldPrice;
@property (nonatomic, strong)UILabel *currentPrice;
@property (nonatomic, strong)UILabel *saleNum;
@property (nonatomic, strong)UILabel *couponsLab;
@property (nonatomic, strong)UILabel *money;
@property (nonatomic, strong)UILabel *rating;
@property (nonatomic, strong)UILabel *markLab;
@property (nonatomic, strong)UIView *couponsView;
@property (nonatomic,strong)UILabel *commissionLab;//佣金
@property (nonatomic, strong)UIImageView *commissionIcon;//佣金Icon
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIImageView *leftIcon;
@property (nonatomic, strong)UIImageView *FreeIcon;
-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
