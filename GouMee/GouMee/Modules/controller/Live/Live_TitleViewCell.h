//
//  Live_TitleViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/7.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQGradientProgressView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^TitleHight)(CGFloat h);
@interface Live_TitleViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *goodsName;
@property (nonatomic, strong)UILabel *currentPrice;
@property (nonatomic, strong)UILabel *saleNum;
@property (nonatomic, strong)UILabel *oneMoney;
@property (nonatomic, strong)UILabel *oneNum;
@property (nonatomic, strong)UILabel *twoMoney;
@property (nonatomic, strong)UILabel *twoNum;
@property (nonatomic, strong)UILabel *threeMoney;
@property (nonatomic, strong)UILabel *threeNum;
@property (nonatomic, strong)MQGradientProgressView *slider;
@property (nonatomic, strong)UILabel *teamNum;
@property (nonatomic, strong)UILabel *limitNum;
@property (nonatomic, strong)UILabel *couspondLab;
@property (nonatomic, strong)UILabel *commissionLab;
@property (nonatomic, strong)UIImageView *arrowView;
@property (nonatomic, strong)UIView *oneView;
@property (nonatomic, strong)UIView *twoView;
@property (nonatomic, strong)UIView *threeView;

@property (nonatomic, copy) TitleHight click;
@property (nonatomic, assign)CGFloat cellHeight;
-(CGFloat)getHeight;
-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
