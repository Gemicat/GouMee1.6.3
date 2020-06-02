//
//  SetViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/2/19.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIImageView *rightBtn;
@property (nonatomic, strong)UILabel *context;

@end

NS_ASSUME_NONNULL_END
