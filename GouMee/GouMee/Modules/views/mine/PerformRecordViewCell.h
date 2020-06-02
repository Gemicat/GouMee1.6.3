//
//  PerformRecordViewCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/17.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PerformRecordViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *dateLab;
@property (nonatomic, strong)UILabel *payNum;
@property (nonatomic, strong)UILabel *payMoney;
@property (nonatomic, strong)UILabel *settleMoney;
@property (nonatomic, strong)UIView *line;
@end

NS_ASSUME_NONNULL_END
