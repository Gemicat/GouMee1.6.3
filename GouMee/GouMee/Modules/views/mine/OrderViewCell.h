//
//  OrderViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/5.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCVerticalBadgeBtn.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^OrdersBlock)(NSInteger tag);
@interface OrderViewCell : UICollectionViewCell
@property (nonatomic, strong)LCVerticalBadgeBtn *collectBtn;
@property (nonatomic, strong)LCVerticalBadgeBtn *PidBtn;
@property (nonatomic, strong)LCVerticalBadgeBtn *BoBtn;
@property (nonatomic, strong)LCVerticalBadgeBtn *SendBtn;
@property (nonatomic, copy)OrdersBlock click;

@end

NS_ASSUME_NONNULL_END
