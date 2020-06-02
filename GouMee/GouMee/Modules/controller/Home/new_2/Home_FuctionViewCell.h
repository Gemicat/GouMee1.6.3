//
//  Home_FuctionViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/5.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"

typedef void(^HomePushBlock)(NSDictionary *selectM);
NS_ASSUME_NONNULL_BEGIN

@interface Home_FuctionViewCell : UICollectionViewCell<SDCycleScrollViewDelegate>
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIImageView *rightBtn;
@property (nonatomic, strong)SDCycleScrollView *customCellScrollViewDemo;
@property (nonatomic, strong)NSDictionary *selectModel;
@property (nonatomic, copy)HomePushBlock click;
-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
