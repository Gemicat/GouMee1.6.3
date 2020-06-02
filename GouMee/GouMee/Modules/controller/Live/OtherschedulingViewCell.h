//
//  OtherschedulingViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/4/2.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OtherschedulingViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *moneyLab;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, strong) UIView *bomLine;
@property (nonatomic, strong)UIButton *moreBtn;
-(void)addModel:(NSDictionary *)model;
-(void)addModel1:(NSMutableArray *)array addModel2:(NSDictionary *)model;
-(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
