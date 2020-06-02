//
//  FilterInputCell.h
//  GouMee
//
//  Created by 白冰 on 2019/12/13.
//  Copyright © 2019 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterInputCell : UICollectionViewCell
@property (nonatomic, strong)UITextField *lowPrice;
@property (nonatomic, strong)UITextField *highPrice;
@property (nonatomic, strong)UITextField *profitsNum;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UILabel *markLab;
@end

NS_ASSUME_NONNULL_END
