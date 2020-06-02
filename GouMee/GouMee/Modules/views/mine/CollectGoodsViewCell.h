//
//  CollectGoodsViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/19.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectGoodsViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *goodsIcon;
@property (nonatomic, strong)UILabel *goodsName;
@property (nonatomic, strong)UILabel *currentPrice;
@property (nonatomic, strong)UILabel *oldPrice;
@property (nonatomic, strong)UILabel *dateTime;
@property (nonatomic, strong)UILabel *moneyLab;
@property (nonatomic, strong)UILabel *numLab;
@property (nonatomic, strong)UILabel *hostNum;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong)UILabel *startTime;
@property (nonatomic, strong)UIButton *collectBtn;
@property (nonatomic, strong) UILabel *validLab;
@property (nonatomic, strong)UIImageView *FreeIcon;
-(void)addModel:(NSDictionary *)model;
-(void)addModel1:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
