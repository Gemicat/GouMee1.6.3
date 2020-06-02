//
//  ScheduleListViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleListViewCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *statusLab;
@property (nonatomic, strong)UIImageView *goodsIcon;
@property (nonatomic, strong)UILabel *goosName;
@property (nonatomic, strong)UILabel *currentPrice;
@property (nonatomic, strong)UILabel *oldPrice;
@property (nonatomic, strong)UILabel *saleNum;
@property (nonatomic, strong)UILabel *hostNum;
@property (nonatomic, strong)UIButton *seeBtn;
@property (nonatomic, strong)UIView *lineView;

-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
