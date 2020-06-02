//
//  SellPointViewCells.h
//  GouMee
//
//  Created by 白冰 on 2020/4/15.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SellPointViewCells : UICollectionViewCell
@property (nonatomic, strong)UILabel *contextLab;
@property (nonatomic, assign)CGFloat cellHeight;
@property (nonatomic, strong) UIView *bomLine;
@property (nonatomic, strong)UILabel *tips;
-(void)addModel:(NSDictionary *)model;
-(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
