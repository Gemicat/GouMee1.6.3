//
//  LiveStoreViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^StoreHight)(CGFloat h);
@interface LiveStoreViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *typeLab;
@property (nonatomic, strong)StoreDetailView *storeView;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, copy) StoreHight click;
@property (nonatomic, copy) StoreHight clickAction;
-(void)addModel:(NSDictionary *)model;
-(CGFloat)getHeight;
@end

NS_ASSUME_NONNULL_END
