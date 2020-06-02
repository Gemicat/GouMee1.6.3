//
//  ScheduleViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/14.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleViewCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *liveTime;
@property (nonatomic, strong)UILabel *wentLab;
@property (nonatomic, strong)UILabel *willLab;
@property (nonatomic, strong)UILabel *notLab;
@property (nonatomic, strong)UILabel *numLab;
@property (nonatomic, strong)UILabel *timeLab;
-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
