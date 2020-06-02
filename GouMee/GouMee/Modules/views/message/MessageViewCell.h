//
//  MessageViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCVerticalBadgeBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageViewCell : UITableViewCell

@property (nonatomic, strong)LCVerticalBadgeBtn *leftBtn;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UILabel *context;
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UIView *line;
@end

NS_ASSUME_NONNULL_END
