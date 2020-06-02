//
//  OrderListViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *statusLab;
@property (nonatomic, strong)UIImageView *goodsIcon;
@property (nonatomic, strong)UILabel *goosName;
@property (nonatomic, strong)UILabel *orderNo;
-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
