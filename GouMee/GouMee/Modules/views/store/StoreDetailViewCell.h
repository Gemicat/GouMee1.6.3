//
//  StoreDetailViewCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailView.h"
NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailViewCell : UICollectionViewCell
@property (nonatomic, strong)StoreDetailView *storeView;
@property (nonatomic, strong)UILabel *typeLab;

-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
