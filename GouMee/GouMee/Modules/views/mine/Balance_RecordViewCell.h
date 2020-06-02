//
//  Balance_RecordViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/1/9.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Balance_RecordViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *typeLab;
@property (nonatomic, strong)UILabel *moneyLab;
@property (nonatomic, strong)UILabel *retainLab;
@property (nonatomic, strong)UILabel *timeLab;

-(void)addModel:(NSDictionary *)model;

@end

NS_ASSUME_NONNULL_END
