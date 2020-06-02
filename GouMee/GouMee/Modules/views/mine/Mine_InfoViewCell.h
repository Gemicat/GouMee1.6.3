//
//  Mine_InfoViewCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BalanceBlock)(void);
@interface Mine_InfoViewCell : UICollectionViewCell
@property (nonatomic, strong)UIButton *userIcon;
@property (nonatomic, strong)UILabel *userName;
@property (nonatomic, strong)UILabel *retainLab;
@property (nonatomic, copy) BalanceBlock click;
@property (nonatomic, copy) BalanceBlock clickBlock;
@property (nonatomic, copy) BalanceBlock setBlock;

@property (nonatomic, strong)UIButton *willDay;
@property (nonatomic, strong)UIButton *willMonth;
@property (nonatomic, strong)UIButton *sumMoney;

@property (nonatomic, strong)UILabel *balanceLab;
@property (nonatomic, strong)UIButton *withMoneyBtn;

@end

NS_ASSUME_NONNULL_END
