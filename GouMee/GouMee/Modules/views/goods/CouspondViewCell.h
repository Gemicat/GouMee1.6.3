//
//  CouspondViewCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/16.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^couponHight)(CGFloat h);
NS_ASSUME_NONNULL_BEGIN

@interface CouspondViewCell : UICollectionViewCell

@property (nonatomic, strong)UIButton *titleLab;
@property (nonatomic, strong)UIButton *ruleBtn;




@property (nonatomic, copy)couponHight click;
@property (nonatomic, strong)NSDictionary *model;
-(CGFloat)getHeight;
@end

NS_ASSUME_NONNULL_END
