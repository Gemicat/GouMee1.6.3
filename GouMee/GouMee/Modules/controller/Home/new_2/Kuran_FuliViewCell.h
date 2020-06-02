//
//  Kuran_FuliViewCell.h
//  GouMee
//
//  Created by 白冰 on 2020/4/22.
//  Copyright © 2020 白冰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Kuran_FuliViewCell : UITableViewCell

@property (nonatomic, strong)UIButton *titleLab;
@property (nonatomic, strong)UIButton *ruleBtn;

-(void)addModel:(NSDictionary *)model;
@property (nonatomic, assign)CGFloat cellHeight;
-(CGFloat)getHeight;



@end

NS_ASSUME_NONNULL_END
