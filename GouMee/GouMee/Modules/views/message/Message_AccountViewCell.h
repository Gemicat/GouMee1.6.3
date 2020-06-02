//
//  Message_AccountViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/3/30.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^cellssHeight)(CGFloat h);
@interface Message_AccountViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *statusLab;//审核状态
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UIImageView *rightIcon;
@property (nonatomic, strong)UILabel *context;
@property (nonatomic, strong)UILabel *titleType;//通知类型
@property (nonatomic, strong)UILabel *applyStatus;//申请或者结算状态
@property (nonatomic, strong)UILabel *applyType;//申请类型
@property (nonatomic, strong)UIView *line;//申请类型
@property (nonatomic, copy)cellssHeight clicks;//申请类型
@property (nonatomic, strong)UILabel *timeLab;
@property (nonatomic, strong)UILabel *resultLab;
@property (nonatomic, strong)UILabel *moneyLab;
@property (nonatomic, strong)UILabel *statusLabs;
@property (nonatomic, assign)CGFloat cellH;//申请类型
-(void)addModel:(NSDictionary *)model;
-(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
