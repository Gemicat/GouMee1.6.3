//
//  GoodsListViewCell.h
//  KuRanApp
//
//  Created by 白冰 on 2020/2/10.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsListViewCell : UICollectionViewCell

@property (nonatomic, strong)UIImageView *goodsIcon;
@property (nonatomic, strong)UILabel *currentPrice;
@property (nonatomic, strong)UIButton *moneyLab;
@property (nonatomic, strong)NSDictionary *model;

@end

NS_ASSUME_NONNULL_END
