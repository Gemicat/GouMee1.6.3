//
//  With_RecordCell.h
//  GouMee
//
//  Created by 白冰 on 2020/1/8.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface With_RecordCell : UITableViewCell
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *dateLab;
@property (nonatomic, strong)UILabel *moneyLab;
@property (nonatomic, strong)UILabel *statusLab;
@property (nonatomic, strong)UILabel *statusLabs;
@property (nonatomic, strong)UILabel *resultBtn;

-(void)addModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
